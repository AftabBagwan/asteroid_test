import 'dart:async';
import 'dart:math';
import 'package:asteroid_test/models/circle.dart';
import 'package:asteroid_test/pages/game_over.dart';
import 'package:asteroid_test/widgets/circle_painter.dart';
import 'package:asteroid_test/widgets/user_input.dart';
import 'package:flutter/material.dart';

class PlayGround extends StatefulWidget {
  const PlayGround({super.key});

  @override
  State<PlayGround> createState() => _PlayGroundState();
}

class _PlayGroundState extends State<PlayGround> {
  final Random _random = Random();
  late List<Circle> _circles;
  late Offset _mousePosition;
  late Timer _timer;
  late Size _screenSize;
  int _remainingTime = 180;

  final TextEditingController _numCirclesController =
      TextEditingController(text: '10');
  final TextEditingController _avgSpeedController =
      TextEditingController(text: '4.0');
  final TextEditingController _startingRangeController =
      TextEditingController(text: '100.0');

  int _numberOfCircles = 10;
  double _averageSpeed = 4.0;
  double startingPositionRange = 100.0;

  @override
  void initState() {
    super.initState();
    _mousePosition = const Offset(-50, -50);
    _circles = [];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenSize = MediaQuery.of(context).size;
      _generateCircles();
      _startMovement();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenSize = MediaQuery.of(context).size;
  }

  void _generateCircles() {
    _circles = List.generate(_numberOfCircles, (index) {
      double dx = _random.nextDouble() * _screenSize.width;
      double dy = _random.nextDouble() * _screenSize.height;
      double vx = (_random.nextDouble() - 0.5) * _averageSpeed * 2;
      double vy = (_random.nextDouble() - 0.5) * _averageSpeed * 2;
      double radius = 10 + _random.nextDouble() * 20;

      return Circle(
        position: Offset(dx, dy),
        velocity: Offset(vx, vy),
        radius: radius,
      );
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _startMovement() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const GameOverScreen()));
      }
    });
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        for (var circle in _circles) {
          circle.position += circle.velocity;

          if (circle.position.dx < 0 ||
              circle.position.dx > _screenSize.width - circle.radius * 2) {
            circle.velocity = Offset(-circle.velocity.dx, circle.velocity.dy);
            circle.position = Offset(
              circle.position.dx
                  .clamp(0.0, _screenSize.width - circle.radius * 2),
              circle.position.dy,
            );
          }
          if (circle.position.dy < 0 ||
              circle.position.dy > _screenSize.height - circle.radius * 2) {
            circle.velocity = Offset(circle.velocity.dx, -circle.velocity.dy);
            circle.position = Offset(
              circle.position.dx,
              circle.position.dy
                  .clamp(0.0, _screenSize.height - circle.radius * 2),
            );
          }
          if (_checkCollision(circle)) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const GameOverScreen()));
            _timer.cancel(); // Stop the movement
            break;
          }
        }
      });
    });
  }

  bool _checkCollision(Circle circle) {
    double dx = _mousePosition.dx - circle.position.dx;
    double dy = _mousePosition.dy - circle.position.dy;
    double distance = sqrt(dx * dx + dy * dy);

    return distance < circle.radius + 25; // Cursor radius is assumed to be 25
  }

  void _updateParameters() {
    setState(() {
      _numberOfCircles = int.tryParse(_numCirclesController.text) ?? 10;
      _averageSpeed = double.tryParse(_avgSpeedController.text) ?? 4.0;
      startingPositionRange =
          double.tryParse(_startingRangeController.text) ?? 100.0;
      _generateCircles();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _numCirclesController.dispose();
    _avgSpeedController.dispose();
    _startingRangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.none,
            onHover: (event) {
              setState(() {
                _mousePosition = event.position;
              });
            },
            child:
          _circles.isNotEmpty
              ? CirclePainter(
                  mousePosition: _mousePosition,
                  circles: _circles,
                )
              : const Center(child: Text('No circles to display')),
          ),
          Positioned(
              left: 0,
              top: 0,
              child: Text(
                _formatTime(_remainingTime),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              )),
          Positioned(
            right: 20,
            top: 20,
            child: UserInput(
              numCirclesController: _numCirclesController,
              avgSpeedController: _avgSpeedController,
              startingRangeController: _startingRangeController,
              onUpdate: _updateParameters,
            ),
          ),
        ],
      ),
    );
  }
}
