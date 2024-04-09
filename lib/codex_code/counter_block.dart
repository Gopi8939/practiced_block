import 'dart:async';

enum CounterAction { increment, decrement, reset }

class CounterBloc {
  int counter = 0;

  final _stateStreamController = StreamController<int>();
  //Input
  StreamSink<int> get counterSink => _stateStreamController.sink;
  //Output
  Stream<int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterAction>();
  //Input
  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  //Output
  Stream<CounterAction> get eventStream => _eventStreamController.stream;

  CounterBloc() {
    counter = 0;
    eventStream.listen((event) {
      if (event == CounterAction.increment) {
        counter++;
      } else if (event == CounterAction.decrement) {
        counter--;
      } else if (event == CounterAction.reset) {
        counter = 0;
      }
      counterSink.add(counter);
    });
  }
  void dispose() {
    _stateStreamController.close();
  }
}
