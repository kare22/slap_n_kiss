import 'package:flutter/material.dart';
import 'package:helloworld/game_screen.dart';

import 'options.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slap \'N\' Kiss',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(key: const ValueKey(true), title: 'Slap \'N\' Kiss'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<Container> options = Options.getOptions().map((String option) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ElevatedButton(
          key: UniqueKey(),
          child: Text(option),
          style: ElevatedButton.styleFrom(
            backgroundColor: Options.getOptionColor(option),
            fixedSize: const Size(130, 50),
            textStyle: const TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => GameScreen(
                  type: option,
                ),
              ),
            );
          },
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        centerTitle: true,
        actions: [],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/home_background.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.deepPurple.withOpacity(0.4), BlendMode.darken),
          ),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center, children: options),
          ),
        ),
      ),
    );
  }
}
