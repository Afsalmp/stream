

import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final StreamController<int> _streamController = StreamController<int>();

  MyApp() {
    // Emit numbers at one-second intervals
    Timer.periodic(Duration(seconds: 1), (timer) {
      _streamController.add(timer.tick);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Number Stream '),
        ),
        body: Center(
          child: StreamBuilder<int>(
            stream: _streamController.stream,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return Text('No  ');
              } else {
                return Text('Number: ${snapshot.data}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
              }
            },
          ),
        ),
      ),
    );
  }
}
