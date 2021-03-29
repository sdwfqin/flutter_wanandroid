import 'package:flutter/material.dart';

class ProjectPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: new Text(
          "项目",
        ),
      ),
      body: Container(
        child: new Text("项目"),
      ),
    );
  }
}
