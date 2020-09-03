import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;
  final List<String> categories = ['Chats', 'Contact', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      color: Colors.green,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
                child: Text(categories[index],
                    style: TextStyle(
                      color: index == selectedIndex
                          ? Colors.white
                          : Colors.white60,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    )),
              ),
            );
          }),
    );
  }
}
