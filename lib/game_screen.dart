import 'dart:math';

import 'package:flutter/material.dart';
import 'package:helloworld/flip_box.dart';
import 'package:helloworld/options.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({key, required this.type}) : super(key: key);

  final String type;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  FlipBoxController flipBoxController1 = FlipBoxController();
  FlipBoxController flipBoxController2 = FlipBoxController();

  @override
  Widget build(BuildContext context) {
    final List<String> options = Options.getOptionData(widget.type);

    void switchCards() {
      flipBoxController1.switchCard(options[getRandomNumber(0, 5)]);
      flipBoxController2.switchCard(options[getRandomNumber(0, 5)]);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type),
        centerTitle: true,
        actions: [],
      ),
      body: GestureDetector(
        onTap: switchCards,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Options.getOptionBackground(widget.type)),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlipBox(
                          key: UniqueKey(),
                          title: options[0],
                          color: Colors.purple,
                          controller: flipBoxController1,
                        ),
                        Container(
                          width: 10,
                        ),
                        FlipBox(
                          key: UniqueKey(),
                          title: options[0],
                          color: Colors.pink,
                          controller: flipBoxController2,
                        ),
                      ],
                    ),
                    Container(
                      height: 20,
                    ),
                    ElevatedButton(
                      key: UniqueKey(),
                      child: const Text('ROLL'),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(90, 45),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      onPressed: () {
                        switchCards();
                      },
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  int getRandomNumber(min, max) {
    Random rnd = Random();
    return min + rnd.nextInt(max - min);
  }
}
