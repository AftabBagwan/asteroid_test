import 'package:asteroid_test/models/circle.dart';
import 'package:asteroid_test/utils/colors.dart';
import 'package:asteroid_test/widgets/player.dart';
import 'package:flutter/material.dart';

class CirclePainter extends StatelessWidget {
  final Offset mousePosition;
  final List<Circle> circles;

  const CirclePainter({
    super.key,
    required this.mousePosition,
    required this.circles,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Positioned(
        //   left: mousePosition.dx,
        //   top: mousePosition.dy,
        //   child: CircleAvatar(
        //     radius: 10,
        //     backgroundColor: AppColors.white,
        //   ),
        // ),
         const Player(),
        ...circles.map((circle) {
          return Positioned(
            left: circle.position.dx,
            top: circle.position.dy,
            child: CircleAvatar(
              radius: circle.radius,
              backgroundColor: AppColors.red,
            ),
          );
        }),
       
      ],
    );
  }
}
