import 'package:flutter/material.dart';
import 'car.dart';
import 'dbhelper.dart';

void main() => runApp(MySqliteApp());

class MySqliteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Dev',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MySqliteHome(),
    );
  }
}

class MySqliteHome extends StatefulWidget {
  @override
  _MySqliteHomeState createState() => _MySqliteHomeState();
}

class _MySqliteHomeState extends State<MySqliteHome> {
  final dbhelper = DatabaseHelper.instance;

  List<Car> cars = [];
  List<Car> carByName = [];

  //insert controller
  TextEditingController nameController = TextEditingController();
  TextEditingController milesController = TextEditingController();

  //update controllers
  TextEditingController nameUpdateController = TextEditingController();
  TextEditingController milesUpdateController = TextEditingController();
  TextEditingController idUpdateController = TextEditingController();

  //search key controller
  TextEditingController searchController = TextEditingController();

  //delete controller
  TextEditingController idDeleteController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static List<DataRow> tableRow = [];
  var data = DataTable(
      columns: [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Miles')),
      ],
    rows: tableRow,
      );

  void _showMessageInScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('SQLite Navigation'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Insert',
              ),
              Tab(
                text: 'Fetch',
              ),
              Tab(
                text: 'Search',
              ),
              Tab(
                text: 'Update',
              ),
              Tab(
                text: 'Delete',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Car name',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: milesController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Car Miles',
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text('Register'),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      String name = nameController.text;
                      int miles = int.parse(milesController.text);
                      _insert(name, miles);
                    },
                  )
                ],
              ),
            ),
            Container(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: cars.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == cars.length) {
                      return RaisedButton(
                        child: Text('Refresh'),
                        color: Colors.green,
                        textColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            _queryAll();
                          });
                        },
                      );
                    }
                    return (cars.length -1 == index?data:Text(''));
//                    return Container(
//                      height: 40,
//                      child: Center(
//                        child: Text(
//                            "${cars[index].id} -  ${cars[index].name} - ${cars[index].miles}"),
//                      ),
//                    );
                  }),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 100,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Car name',
                      ),
                      onChanged: (text) {
                        if (text.length >= 2) {
                          setState(() {
                            _query(text);
                          });
                        } else {
                          setState(() {
                            carByName.clear();
                          });
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 300,
                    child: ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: carByName.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 40,
                            child: Center(
                              child: Text(
                                '[${cars[index].id}] ${cars[index].name} - ${cars[index].miles} miles',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: idUpdateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Car id',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: nameUpdateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Car name',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: milesUpdateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Car miles',
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text('Update'),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      int id = int.parse(idUpdateController.text);
                      String name = nameUpdateController.text;
                      int miles = int.parse(milesUpdateController.text);
                      _update(id, name, miles);
                    },
                  )
                ],
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: idDeleteController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Car id',
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text('Delete'),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      int id = int.parse(idDeleteController.text);
                      _delete(id);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _insert(name, miles) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnMiles: miles
    };
    Car car = Car.fromMap(row);
    final id = await dbhelper.insert(car);
    _showMessageInScaffold('inserted row id: $id');
  }

  void _queryAll() async {
    final allRows = await dbhelper.queryAllRows();
    cars.clear();
    tableRow.clear();
    allRows.forEach((row) {
      print("Data map " + row['name']);
      int id = row['id'];
      int miles = row['miles'];
        tableRow.add(
          DataRow(
              cells: [
                DataCell(Text('$id')),
                DataCell(Text(row['name'])),
                DataCell(Text('$miles')),
              ]),
        );
      cars.add(Car.fromMap(row));
    });
    _showMessageInScaffold('Fetch done');
    setState(() {});
  }

  void _query(name) async {
    final allRows = await dbhelper.queryRows(name);
    carByName.clear();
    allRows.forEach((row) => carByName.add(Car.fromMap(row)));
  }

  void _update(id, name, mile) async {
    Car car = Car(id, name, mile);
    final rowsAffected = await dbhelper.update(car);
    _showMessageInScaffold('Updated $rowsAffected row(s)');
  }

  void _delete(id) async {
    final rowsDeleted = await dbhelper.delete(id);
    _showMessageInScaffold('Deleted $rowsDeleted row(s): row $id');
  }
}
