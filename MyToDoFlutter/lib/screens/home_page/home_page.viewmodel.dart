import 'dart:developer';

import 'package:MyToDoFlutter/models/to_do.model.dart';
import 'package:MyToDoFlutter/repositories/todo.repository.dart';
import 'package:rxdart/rxdart.dart';

class HomePageViewModel {
  final ToDoRepository repository;

  final _toDos = BehaviorSubject<List<ToDoModel>>();
  Stream<List<ToDoModel>> get toDo$ => _toDos.stream;
  List<ToDoModel> get toDo => _toDos.value;

  HomePageViewModel(this.repository);

  atualizar() {
    repository.getAll().then((value) {
      _toDos.sink.add(value);
    }).catchError((error) {
      log(error);
    });
  }

  void dispose() {
    _toDos.close();
  }
}
