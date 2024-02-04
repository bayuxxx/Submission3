import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Disconec extends StatelessWidget {
  const Disconec({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lag.json'),
              const SizedBox(height: 10),
              const Text(
                'No internet connection. Please check your connection and reload app.',
                style: TextStyle(
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
