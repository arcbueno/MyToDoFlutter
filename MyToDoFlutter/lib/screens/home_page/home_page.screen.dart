import 'package:MyToDoFlutter/custom_widgets/todo_grid_item/todo_grid_item.dart';
import 'package:MyToDoFlutter/models/to_do.model.dart';
import 'package:MyToDoFlutter/repositories/todo.repository.dart';
import 'package:MyToDoFlutter/screens/home_page/home_page.viewmodel.dart';
import 'package:MyToDoFlutter/screens/todo_detail/todo_detail.screen.dart';
import 'package:MyToDoFlutter/screens/todo_new/todo_new.screen.dart';
import 'package:MyToDoFlutter/service_locator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final HomePageViewModel _viewModel =
      HomePageViewModel(getIt.get<ToDoRepository>());

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;

    _viewModel.atualizar();

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
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                  childAspectRatio: 2 / 1),
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: lista.length,
              itemBuilder: (BuildContext context, int index) {
                return ToDoGridItem(
                  id: lista[index].rowid,
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('home_button'),
        onPressed: () async {
          await Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => TodoNewScreen(),
                ),
              )
              .then((value) => _viewModel.atualizar());
        },
        tooltip: 'New To Do',
        child: Icon(Icons.add),
      ),
    );
  }
}
