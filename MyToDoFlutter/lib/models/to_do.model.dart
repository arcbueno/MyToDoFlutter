class ToDoModel {
  int rowid;
  String title;
  String body;
  bool done;

  ToDoModel({this.rowid, this.title, this.body, this.done});

  ToDoModel.fromJson(Map<String, dynamic> json) {
    rowid = json['rowid'];
    title = json['title'];
    body = json['body'];
    done = json['done'];
  }

  ToDoModel.fromDb(Map<String, dynamic> map)
      : rowid = map['rowid'],
        title = map['title'],
        body = map['body'],
        done = map['done'] == 1;

  Map<String, dynamic> toDb() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rowid'] = this.rowid;
    data['title'] = this.title;
    data['body'] = this.body;
    data['done'] = this.done ? 1 : 0;
    return data;
  }
}
