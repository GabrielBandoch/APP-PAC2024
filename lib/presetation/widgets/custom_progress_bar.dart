import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final Animation<double> progress; // Recebe a animação como parâmetro

  CustomProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Stack(
        children: [
          Container(
            height: 12,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
          ),

          Positioned(
            top: 2,
            left: 2,
            right: 2,
            child: AnimatedBuilder(
              animation: progress,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: progress.value,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  minHeight: 8,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
