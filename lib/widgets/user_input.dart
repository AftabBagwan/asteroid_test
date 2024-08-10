import 'package:asteroid_test/utils/colors.dart';
import 'package:flutter/material.dart';

class UserInput extends StatelessWidget {
  final TextEditingController numCirclesController;
  final TextEditingController avgSpeedController;
  final TextEditingController startingRangeController;
  final VoidCallback onUpdate;

  const UserInput({
    super.key,
    required this.numCirclesController,
    required this.avgSpeedController,
    required this.startingRangeController,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: AppColors.white.withOpacity(0.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: TextField(
              style: TextStyle(
                color: AppColors.black,
              ),
              controller: numCirclesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of Circles',
                labelStyle: TextStyle(
                  color: AppColors.black,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 200,
            child: TextField(
              style: TextStyle(
                color: AppColors.black,
              ),
              controller: avgSpeedController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Average Speed',
                labelStyle: TextStyle(
                  color: AppColors.black,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 200,
            child: TextField(
              style: TextStyle(
                color: AppColors.black,
              ),
              controller: startingRangeController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Starting Position Range',
                labelStyle: TextStyle(
                  color: AppColors.black,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onUpdate,
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
