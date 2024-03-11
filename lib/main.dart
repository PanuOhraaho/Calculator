import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      //Muuttaa apin ulkoasua
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      //Tästä app käytännässä alkaa
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int result = 0;
  String calculation = "";

  void clear() { setState(() { calculation = ""; result = 0; }); }

  void addToCalculation(String input) { 
    setState(() { 
      calculation += input;
      }); 
    }
  void calculate() { 
    var calArray = [];
    setState(() {
      for(var i = 0; i < calculation.length; i++) { 
        switch(calculation[i]) {
          case "+": calArray.add(calculation[i]);
          case "-": calArray.add(calculation[i]);
          default: try {
            var temp = int.parse(calArray[calArray.length-1]);
            calArray[calArray.length-1] += calculation[i];
          } catch (FormatException) {
            calArray.add(calculation[i]);
          }
        }
      }
      var temp = 0;
      for(var i = 0; i<calArray.length; i++) {
        switch(calArray[i]) {
          case "+": temp += int.parse(calArray[i+1]); i++;
          case "-": temp -= int.parse(calArray[i+1]); i++;
          default: temp = int.parse(calArray[i]);
        }
      }
       result = temp;
      }); 
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      //Display
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              calculation,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '$result',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),

      //Keyboard
      bottomSheet: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              addToCalculation("+");
            },
            child: const Text('+'),
          ),
          ElevatedButton(
            onPressed: () {
              addToCalculation("-");
            },
            child: const Text('-'),
          ),
          ElevatedButton(
            onPressed: () {
              addToCalculation("1");
            },
            child: const Text('1'),
          ),
          ElevatedButton(
            onPressed: () {
              addToCalculation("2");
            },
            child: const Text('2'),
          ),
        ],
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            onPressed: () { clear(); },
            tooltip: 'Increment',
            child: const Icon(Icons.clear),
          )),
          FloatingActionButton(
            onPressed: calculate,
            tooltip: 'Increment',
            child: const Icon(Icons.done),
          ),
        ],
        ),
      );
  }
}


