import 'package:asteroid_test/utils/colors.dart';
import 'package:flutter/material.dart';

class PlayGround extends StatefulWidget {
  const PlayGround({super.key});

  @override
  State<PlayGround> createState() => _PlayGroundState();
}

class _PlayGroundState extends State<PlayGround> {
  Offset _mousePosition = Offset(-50, -50); // Moved this outside of the build method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegion(
        onHover: (event) {
          setState(() {
            _mousePosition = event.position;
          });
        },
        child: Stack(
          children: [
            Positioned(
              left: _mousePosition.dx - 25,
              top: _mousePosition.dy - 25,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
