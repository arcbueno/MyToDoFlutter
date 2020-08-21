import 'package:MyToDoFlutter/models/to_do.model.dart';
import 'package:MyToDoFlutter/repositories/todo.repository.dart';
import 'package:rxdart/rxdart.dart';

class ToDoDetailViewModel {
  final ToDoRepository repository;
  ToDoModel todo;

  final _title = BehaviorSubject<String>();
  Stream<String> get title$ => _title.stream;
  Sink<String> get inTitle => _title.sink;
  String get title => _title.value;

  final _body = BehaviorSubject<String>();
  Stream<String> get body$ => _body.stream;
  Sink<String> get inBody => _body.sink;
  String get body => _body.value;

  ToDoDetailViewModel(this.repository, this.todo) {
    _title.sink.add(todo.title);
    _body.sink.add(todo.body);
  }

  void save() {
    this.todo.title = title;
    this.todo.body = body;
    repository.update(this.todo);
  }

  void remove() {
    repository.remove(todo.rowid);
  }

  void dispose() {
    _title.close();
    _body.close();
  }
}
