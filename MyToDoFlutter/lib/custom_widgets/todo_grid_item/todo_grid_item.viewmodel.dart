import 'package:MyToDoFlutter/models/to_do.model.dart';
import 'package:MyToDoFlutter/repositories/todo.repository.dart';
import 'package:rxdart/rxdart.dart';

class ToDoItemViewModel {
  final ToDoRepository repository;

  final _toDo = BehaviorSubject<ToDoModel>();
  Stream<ToDoModel> get toDo$ => _toDo.stream;
  Sink<ToDoModel> get inToDo => _toDo.sink;
  ToDoModel get toDo => _toDo.value;

  final _done = BehaviorSubject<bool>();
  Stream<bool> get done$ => _done.stream;
  Sink<bool> get inDone => _done.sink;
  bool get done => _done.value;

  ToDoItemViewModel({this.repository});

  setTodo(int id) {
    repository.getById(id).then((model) {
      _toDo.sink.add(model);
      _done.sink.add(model?.done);
    });
  }

  void selectDone(bool val) {
    inDone.add(!val);
    update();
    atualizar();
  }

  update() {
    _toDo.value.done = _done.value;
    repository.update(_toDo.value);
    atualizar();
  }

  atualizar() {
    repository.getById(_toDo.value.rowid).then((value) {
      _toDo.sink.add(value);
      _done.sink.add(value?.done);
    });
  }

  void dispose() {
    _toDo.close();
    _done.close();
  }
}
