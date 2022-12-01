import 'package:flutter/material.dart';

///SECOND PAGE, SHOW DETAIL FOR SOME WEATHER LOCATION

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: Center(
        child: Text("Second page"),
      ),
    );
  }
}
