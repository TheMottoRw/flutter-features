import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(new MyContactApp());

class MyContactApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Code Snippets',
      theme: new ThemeData(primarySwatch: Colors.green),
      home: new AccessContacts(),
    );
  }
}

class AccessContacts extends StatefulWidget {
  @override
  _AccessContactsState createState() => _AccessContactsState();
}

class _AccessContactsState extends State<AccessContacts> {
  Iterable<Contact> _contacts;

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  getContacts() async {
    PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      var contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts;
        print("Contact List "+contacts.toList().toString());
      });
    } else {
      print("Contact List: Permission denied ");
      throw PlatformException(
        code: 'PERMISSION_DENIED',
        message: 'Access to location data denied',
        details: null,
      );
    }
  }

  Future<PermissionStatus> _getPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      Map<PermissionGroup, PermissionStatus> permisionStatus =
      await PermissionHandler()
          .requestPermissions([PermissionGroup.contacts]);
      return permisionStatus[PermissionGroup.contacts] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacts Read')),
      body: _contacts != null
          ? ListView.builder(
        itemCount: _contacts.length ?? 0,
        itemBuilder: (context, index) {
          Contact c = _contacts.elementAt(index);
          return ListTile(
            leading: (c.avatar != null && c.avatar.length > 0)
                ? CircleAvatar(
              backgroundImage: MemoryImage(c.avatar),
            )
                : CircleAvatar(child: Text(c.initials())),
            title: Text(c.displayName ?? ''),
            onTap: () async{
              print("Selected contact "+c.toString());
              await ContactsService.openExistingContact(c);
            },
            onLongPress: () async{
              await ContactsService.openDeviceContactPicker().then((value) => print("Selected contact "+value.toMap().toString()));
            },
          );
        },
      )
          : CircularProgressIndicator(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async{  await ContactsService.openContactForm();},
      ),
    );
  }
}