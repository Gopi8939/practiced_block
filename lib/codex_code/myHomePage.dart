import 'dart:developer';

import 'package:flutter/material.dart';

import 'counter_block.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final counterBloc = CounterBloc();
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    log("initState");
    _animationController = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    log("didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.title != oldWidget.title) {
      log("didChangeDependencies ${oldWidget.title}");
    }
  }

  @override
  void deactivate() {
    log("deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    log("dispose");
    counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Widget tree");
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              StreamBuilder(
                stream: counterBloc.counterStream,
                initialData: 0,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      '${snapshot.data}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  }
                  if (snapshot.hasError) {
                    log(snapshot.error.toString());
                  }
                  return SizedBox();
                },
              ),
              ElevatedButton(
                  onPressed: widget.onPressed,
                  child: const Text("DidUpdateWidgets")),
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.of(context).pushReplacement(MaterialPageRoute(
              //           builder: (context) => const SecondPage()));
              //     },
              //     child: Text("Second page")),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () {
                counterBloc.eventSink.add(CounterAction.increment);
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
                onPressed: () {
                  counterBloc.eventSink.add(CounterAction.decrement);
                },
                tooltip: 'Drecrement',
                child: const Icon(Icons.remove)),
            FloatingActionButton(
                onPressed: () {
                  counterBloc.eventSink.add(CounterAction.reset);
                },
                tooltip: 'Drecrement',
                child: const Icon(Icons.restart_alt)),
          ],
        ));
  }
}
