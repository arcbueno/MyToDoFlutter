import 'package:MyToDoFlutter/dao/to_do.dao.dart';
import 'package:MyToDoFlutter/models/to_do.model.dart';

class ToDoRepository {
  final ToDoDao dao;
  ToDoRepository(this.dao);

  Future<ToDoModel> getById(int id) {
    return dao.getById(id);
  }

  Future<List<ToDoModel>> getAll() {
    return dao.getAll();
  }

  void insert(ToDoModel todo) async {
    await dao.add(todo);
  }

  void update(ToDoModel todo) async {
    await dao.update(todo);
  }

  void remove(int id) async {
    await dao.remove(id);
  }
}
