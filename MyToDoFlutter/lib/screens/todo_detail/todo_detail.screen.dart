import 'package:MyToDoFlutter/models/to_do.model.dart';
import 'package:MyToDoFlutter/repositories/todo.repository.dart';
import 'package:MyToDoFlutter/screens/todo_detail/todo_detail.viewmodel.dart';
import 'package:MyToDoFlutter/service_locator.dart';
import 'package:flutter/material.dart';

class TodoDetailScreen extends StatefulWidget {
  final ToDoModel toDo;

  TodoDetailScreen({this.toDo});

  @override
  _TodoDetailScreenState createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  ToDoDetailViewModel _viewModel;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    _viewModel = ToDoDetailViewModel(
      getIt.get<ToDoRepository>(),
      widget.toDo,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update To Do"),
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
                  'Update to do',
                  style: Theme.of(context).textTheme.headline4,
                ),
                StreamBuilder<String>(
                  stream: _viewModel.title$,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        key: Key('title_detail_key'),
                        initialValue: snapshot.data,
                        decoration: const InputDecoration(labelText: 'Title'),
                        onChanged: _viewModel.inTitle.add,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Cannot insert a to do without title";
                          }
                          return null;
                        },
                      ),
                    );
                  },
                ),
                StreamBuilder<String>(
                  stream: _viewModel.body$,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          key: Key('body_detail_key'),
                          decoration: const InputDecoration(labelText: 'Body'),
                          onChanged: _viewModel.inBody.add,
                          maxLines: null,
                        ),
                      );
                    }

                    _bodyController.value =
                        _bodyController.value.copyWith(text: snapshot.data);

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        key: Key('body_detail_key'),
                        controller: _bodyController,
                        decoration: const InputDecoration(
                          labelText: 'Body',
                        ),
                        onChanged: _viewModel.inBody.add,
                        maxLines: null,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              key: Key('remove_button'),
              heroTag: 'unq1',
              onPressed: () {
                _viewModel.remove();
                Navigator.pop(context);
              },
              tooltip: 'Remove',
              child: Icon(Icons.delete),
            ),
          ),
          FloatingActionButton(
            key: Key('update_button'),
            heroTag: null,
            onPressed: () {
              if (formKey.currentState.validate()) {
                _viewModel.save();
                Navigator.pop(context, _viewModel.todo);
              }
            },
            tooltip: 'Create',
            child: Icon(Icons.check),
          ),
        ],
      ),
    );
  }
}
