import 'package:MyToDoFlutter/repositories/todo.repository.dart';
import 'package:MyToDoFlutter/screens/todo_new/todo_new.viewmodel.dart';
import 'package:MyToDoFlutter/service_locator.dart';
import 'package:flutter/material.dart';

class TodoNewScreen extends StatelessWidget {
  final _viewModel = ToDoNewViewModel(
    getIt.get<ToDoRepository>(),
  );
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New To do"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              border: Border.all(),
              color: Color(0xFFFFFF99),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'New to do',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    key: Key('title_new_key'),
                    decoration: const InputDecoration(labelText: 'Title'),
                    onChanged: _viewModel.inTitle.add,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Cannot insert a to do without title";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
                    key: Key('body_new_key'),
                    maxLines: null,
                    onChanged: _viewModel.inBody.add,
                    decoration: const InputDecoration(labelText: 'Text'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('new_button'),
        onPressed: () {
          if (formKey.currentState.validate()) {
            _viewModel.save();
            Navigator.pop(context);
          }
        },
        tooltip: 'Create',
        child: Icon(Icons.check),
      ),
    );
  }
}
