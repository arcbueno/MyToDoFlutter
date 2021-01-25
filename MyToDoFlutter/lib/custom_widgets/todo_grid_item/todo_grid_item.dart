import 'package:MyToDoFlutter/custom_widgets/todo_grid_item/todo_grid_item.viewmodel.dart';
import 'package:MyToDoFlutter/models/to_do.model.dart';
import 'package:MyToDoFlutter/repositories/todo.repository.dart';
import 'package:MyToDoFlutter/screens/todo_detail/todo_detail.screen.dart';
import 'package:MyToDoFlutter/service_locator.dart';
import 'package:flutter/material.dart';

class ToDoGridItem extends StatelessWidget {
  Key key;
  final int id;

  ToDoGridItem({this.id}) {
    key = Key('todo_item_$id');
  }

  final _viewModel = ToDoItemViewModel(repository: getIt.get<ToDoRepository>());

  @override
  Widget build(BuildContext context) {
    _viewModel.setTodo(id);

    return StreamBuilder<ToDoModel>(
      stream: _viewModel.toDo$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TodoDetailScreen(toDo: snapshot.data),
              ),
            );
            _viewModel.atualizar();
          },
          child: Container(
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width / 2,
            child: Card(
              elevation: 2,
              color: snapshot.data.done ? Colors.grey : Color(0xFFFFFF99),
              child: ListTile(
                title: StreamBuilder<bool>(
                  stream: _viewModel.done$,
                  builder: (context, snap) {
                    if (!snap.hasData) return Container();
                    return CheckboxListTile(
                      title: Text(snapshot.data.title ?? ""),
                      value: snap.data,
                      onChanged: (val) {
                        _viewModel.inDone.add(val);
                        _viewModel.update();
                      },
                    );
                  },
                ),
                subtitle: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TodoDetailScreen(toDo: snapshot.data),
                      ),
                    );
                    _viewModel.atualizar();
                  },
                  child: snapshot.data.body != null
                      ? Text(
                          snapshot.data.body,
                          overflow: TextOverflow.fade,
                          maxLines: 7,
                        )
                      : Container(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
