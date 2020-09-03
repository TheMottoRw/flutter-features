import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Todo{
  String title,description;
  Todo(this.title,this.description);
}
void main() {
  runApp(MaterialApp(
      title: 'Passing',
      home: TodoList(),
  )
  );
}
class TodoList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo app"),
      ),
      body: TodoScreen(
          todos: List.generate(
              20,
                  (i) =>
                  Todo(
                    "Todo number $i",
                    "A description whats to be done for to do $i",
                  )
          )
      ),
    );
  }
}
    class TodoScreen extends StatelessWidget{
      final List<Todo> todos;

      TodoScreen({Key key,@required this.todos}) : super(key: key);

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(
                  todos[index].title,
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(),
                    settings: RouteSettings(
                      arguments: todos[index],
                    )
                      )
                  );
                },
              );
            },
          ),
        );
  }
    }

    class DetailScreen extends StatelessWidget{
      @override
      Widget build(BuildContext context) {
        final Todo todo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(todo.description),
      ),
    );
  }
    }