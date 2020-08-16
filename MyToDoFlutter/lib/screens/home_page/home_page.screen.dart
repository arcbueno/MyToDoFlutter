import 'package:MyToDoFlutter/dao/to_do.dao.dart';
import 'package:MyToDoFlutter/database/my_todo_database.dart';
import 'package:MyToDoFlutter/models/to_do.model.dart';
import 'package:MyToDoFlutter/repositories/todo.repository.dart';
import 'package:MyToDoFlutter/screens/home_page/home_page.viewmodel.dart';
import 'package:MyToDoFlutter/screens/todo_new/todo_new.screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final HomePageViewModel _viewModel =
      HomePageViewModel(ToDoRepository(ToDoDao(MyToDoDatabase())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My To Do list'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: _viewModel.toDo$,
          builder:
              (BuildContext context, AsyncSnapshot<List<ToDoModel>> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            var lista = snapshot.data;

            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                itemCount: lista.length,
                itemBuilder: (BuildContext context, int index) {
                  Text(lista[index].title);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TodoNewScreen(),
          ),
        ),
        tooltip: 'New To Do',
        child: Icon(Icons.add),
      ),
    );
  }
}
