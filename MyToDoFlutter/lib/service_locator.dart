import 'package:MyToDoFlutter/dao/to_do.dao.dart';
import 'package:MyToDoFlutter/database/my_todo_database.dart';
import 'package:MyToDoFlutter/repositories/todo.repository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerSingleton<MyToDoDatabase>(
    MyToDoDatabase(),
  );

  getIt.registerSingleton<ToDoDao>(
    ToDoDao(
      getIt.get<MyToDoDatabase>(),
    ),
  );

  getIt.registerSingleton<ToDoRepository>(
    ToDoRepository(
      getIt.get<ToDoDao>(),
    ),
  );
}
