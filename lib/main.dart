import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Таймер',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(title: 'Таймер'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? _timer; // таймер, который управляет увеличением счетчика один раз в секунду
  int _countedSeconds = 0; // сколько секунд уже отсчитано, инициализируется нулем
  Duration timedDuration = Duration.zero; // продолжительность таймера до сих пор инициализируется нулем
  bool _timerRunning = false; // состояние того, работает ли таймер или нет
  //final lapTimes = <Duration>[]; // Вы можете понять, как добавить таймер круга?

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  void startTimer() {
    _timerRunning = true; // set the timer state to running
    _timer?.cancel(); // if there's a timer running already, cancel it
    _countedSeconds = 0; // restart the timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) { // callback
      setState(() {
        _countedSeconds++; 
        print(_countedSeconds); 
        timedDuration = Duration(seconds: _countedSeconds); 
      });
    });
  }

  void stopTimer() { 
    _timerRunning = false; 
    _timer?.cancel(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: AspectRatio(
                // ignore: sort_child_properties_last
                child: CircularProgressIndicator(

                  strokeWidth: 20,
  
                  value: _countedSeconds.remainder(60) / 60,
                ),
                aspectRatio: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  timedDuration.inMinutes.toString(),
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                ),
                Text(
                  ":",
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  timedDuration.inSeconds.remainder(60).toString().padLeft(2, '0'),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_timerRunning) {
            setState(() {
              stopTimer();
            });
          } else {
            setState(() {
              startTimer();
            });
          }
        },
        // onPressed: _incrementCounter,
        child: Icon(_timerRunning ? Icons.pause : Icons.play_arrow),
      ), 
    );
  }
}
