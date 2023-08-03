import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelanius/presentation/providers/providers.dart';
import 'package:miscelanius/presentation/screens/screens.dart';

class CompassScreen extends ConsumerWidget {
  const CompassScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final locationGranted = ref.watch(permissionsProvider).locationGranted;
    if (!locationGranted) return const AskLocationScreen();
    final compass = ref.watch(compassProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Brujula",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: compass.when(
              data: (data) => _Brujula(heading: data ?? 0),
              error: (error, stackTrace) => Text(
                    "$error",
                    style: const TextStyle(color: Colors.white),
                  ),
              loading: () => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )),
        ),
      ),
    );
  }
}

class _Brujula extends StatefulWidget {
  final double heading;

  const _Brujula({required this.heading});

  @override
  State<_Brujula> createState() => _BrujulaState();
}

class _BrujulaState extends State<_Brujula> {
  double prevValue = 0.0;
  double turns = 0;

  double getTurns() {
    double? direction = widget.heading;
    direction = (direction < 0) ? (360 + direction) : direction;

    double diff = direction - prevValue;
    if (diff.abs() > 180) {
      if (prevValue > direction) {
        diff = 360 - (direction - prevValue).abs();
      } else {
        diff = 360 - (prevValue - direction).abs();
        diff = diff * -1;
      }
    }

    turns += (diff / 360);
    prevValue = direction;

    return turns * -1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text("${widget.heading.ceil()} °",
        //     style: TextStyle(color: Colors.white, fontSize: 30)),
        // const SizedBox(
        //   height: 20,
        // ),
        Stack(
          alignment: Alignment.center,
          children: [
            // AnimatedRotation(
            //     turns: getTurns(),
            //     duration: const Duration(seconds: 1),
            //     curve: Curves.easeOut,
            //     child: Image.asset('assets/images/needle-2.png')),
            AnimatedRotation(
                turns: getTurns(),
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
                child: Image.asset('assets/images/quadrant-3.png')),
            Image.asset('assets/images/needle-2.png'),
          ],
        )
      ],
    );
  }
}
