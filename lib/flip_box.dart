import 'dart:math';

import 'package:flutter/material.dart';

class FlipBoxController {
  Function(String) switchCard = (title) => {};

  void dispose() {
    switchCard = (title) => {};
  }
}

class FlipBox extends StatefulWidget {
  final String title;
  final FlipBoxController controller;
  final MaterialColor color;

  const FlipBox(
      {required Key key,
      required this.title,
      required this.controller,
      this.color = Colors.blue})
      : super(key: key);

  @override
  _FlipBoxState createState() => _FlipBoxState();
}

class _FlipBoxState extends State<FlipBox> {
  bool _showFrontSide = false;
  bool _flipXAxis = false;
  String title = '';
  bool _canAnimate = true;

  @override
  void initState() {
    super.initState();

    widget.controller.switchCard = _switchCard;

    title = widget.title;

    _showFrontSide = true;
    _flipXAxis = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        constraints: BoxConstraints.tight(Size.square(150.0)),
        child: _buildFlipAnimation(title),
      ),
    );
  }

  void _switchCard(String newTitle) {
    if (_canAnimate == false) {
      return;
    }
    setState(() {
      _showFrontSide = !_showFrontSide;

      title = newTitle;
    });
  }

  Widget _buildFlipAnimation(String title) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 800),
      transitionBuilder: __transitionBuilder,
      layoutBuilder: (widget, list) {
        if (widget == null) {
          return Stack();
        }
        return Stack(children: [widget, ...list]);
      },
      child: _showFrontSide ? _buildFront(title) : _buildRear(title),
      switchInCurve: Curves.easeInBack,
      switchOutCurve: Curves.easeInBack.flipped,
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    _canAnimate = false;
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _canAnimate = true;
        }
      });
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _buildFront(
    String title,
  ) {
    return __buildLayout(
      key: ValueKey(true),
      backgroundColor: widget.color,
      faceName: "Front",
      title: title,
    );
  }

  Widget _buildRear(
    String title,
  ) {
    return __buildLayout(
      key: ValueKey(false),
      backgroundColor: widget.color.shade700,
      faceName: "Rear",
      title: title,
    );
  }

  Widget __buildLayout({
    required Key key,
    required String faceName,
    required Color backgroundColor,
    required String title,
  }) {
    return Container(
      padding: EdgeInsets.all(8),
      key: key,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(title, style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
