import 'package:asteroid_test/pages/playground.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
              child: Text(
            "Game Over",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          )),
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PlayGround()));
              },
              child: const Text(
                "Try Again",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
