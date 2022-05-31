import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_top_blocked_bouncing_scroll_physics/flutter_top_blocked_bouncing_scroll_physics.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TopBlockedBouncingScrollPhysics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'TopBlockedBouncingScrollPhysics',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _totalElements = 3;

  static final _randomColors = <Color>[
    Colors.indigo.shade100,
    Colors.indigo.shade200,
    Colors.indigo.shade300,
    Colors.green.shade300,
    Colors.green.shade400,
    Colors.red.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
          parent: TopBlockedBouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: _totalElements,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: _getRandomColor(index),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Element #${index + 1}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _totalElements++;
    });
  }

  Color _getRandomColor(int index) {
    final colorIndex = Random(index).nextInt(_randomColors.length);
    return _randomColors.elementAt(colorIndex);
  }
}
