import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelanius/presentation/providers/providers.dart';

class GyroscopeBallScreen extends ConsumerWidget {
  const GyroscopeBallScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final gyroscope = ref.watch(gyroscopeProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Giroscopio con bola"),
        ),
        body: SizedBox.expand(
          child: gyroscope.when(
              data: (data) => _MovingBall(x: data.x, y: data.y),
              error: (error, stackTrace) => Text("$error"),
              loading: () => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )),
        ));
  }
}

class _MovingBall extends StatelessWidget {
  final double x;
  final double y;

  const _MovingBall({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeigth = size.height;
    double currentXPos = (x * 150);
    double currentYPos = (y * 150);
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          ''' 
              x: $x,
              y: $y
            ''',
          style: const TextStyle(fontSize: 30),
        ),
        AnimatedPositioned(
            left: currentYPos - 25 + (screenWidth/2),
            top: currentXPos - 25 + (screenHeigth/2),
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 1000),
            child: _Ball())
      ],
    );
  }
}

class _Ball extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          borderRadius: BorderRadius.circular(100)),
    );
  }
}
