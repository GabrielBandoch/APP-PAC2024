import 'package:flutter/material.dart';
import 'package:pac20242/presetation/widgets/custom_progress_bar.dart'; 

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller; 

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), 
    )..repeat(reverse: false); 
    _controller.addListener(() {
      if (_controller.isCompleted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, 
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'BiBi',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'ComicSans', // só dar um jeito de mudar essa fonte aq, mt trabalho
            ),
          ),
          
          SizedBox(height: 20),

          Image.asset(
            '../../../assets/images/bibi.png',
            width: 350,
            height: 350,
          ),

          SizedBox(height: 40),

          CustomProgressBar(progress: _controller),
        ],
      ),
    );
  }
}
