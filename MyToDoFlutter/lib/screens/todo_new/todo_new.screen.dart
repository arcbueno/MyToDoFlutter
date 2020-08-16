import 'package:flutter/material.dart';

class TodoNewScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New To do"),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Container(
            child: Column(
              children: <Widget>[
                Text('New to do'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
