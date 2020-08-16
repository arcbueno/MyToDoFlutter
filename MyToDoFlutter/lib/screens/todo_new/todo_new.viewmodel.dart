import 'package:MyToDoFlutter/models/to_do.model.dart';
import 'package:MyToDoFlutter/repositories/todo.repository.dart';
import 'package:rxdart/rxdart.dart';

class ToDoNewViewModel {
  final ToDoRepository repository;

  final _title = BehaviorSubject<String>();
  Stream<String> get title$ => _title.stream;
  Sink<String> get inTitle => _title.sink;
  String get title => _title.value;

  final _body = BehaviorSubject<String>();
  Stream<String> get body$ => _body.stream;
  Sink<String> get inBody => _body.sink;
  String get body => _body.value;

  ToDoNewViewModel(this.repository);

  void save() {
    var newTodo =
        ToDoModel(title: _title.value, body: _body.value, done: false);
    repository.insert(newTodo);
  }

  void dispose() {
    _title.close();
    _body.close();
  }
}
