import 'package:flutter/material.dart';

import '../home.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      // backgroundColor: Colors.blueGrey[700],
      body: HomeForm(),
    );
  }
}
