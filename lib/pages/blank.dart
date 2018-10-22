import 'package:flutter/material.dart';

class BlankPage extends StatelessWidget {

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => BlankPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
