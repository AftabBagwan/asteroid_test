import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  double dx = 0.0;
  double dy = 0.0;

  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void moveLeft() {
    setState(() {
      dx -= 10; // Adjust the movement speed as needed
    });
  }

  void moveRight() {
    setState(() {
      dx += 10;
    });
  }

  void moveUp() {
    setState(() {
      dy -= 10;
    });
  }

  void moveDown() {
    setState(() {
      dy += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return RawKeyboardListener(
      focusNode: _focusNode,
      autofocus: true, // Ensure the widget gains focus automatically
      onKey: _onKeyEventHandler,
      child: Stack(
        children: [
          Positioned(
            left: dx,
            top: dy,
            bottom: 0,
            right: 0,
            child: const Icon(
              Icons.rocket,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  void _onKeyEventHandler(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowLeft:
          moveLeft();
          break;
        case LogicalKeyboardKey.arrowRight:
          moveRight();
          break;
        case LogicalKeyboardKey.arrowUp:
          moveUp();
          break;
        case LogicalKeyboardKey.arrowDown:
          moveDown();
          break;
      }
    }
  }
}
