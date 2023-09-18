import 'package:ab_assignment/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add a 4-second delay before navigating to the next page
    Future.delayed(Duration(seconds: 6), () {
      // Use Navigator.pushReplacement to navigate to the next page
      Get.to(() => WeatherHomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.green], // Adjust colors as needed
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/splash icon.png', // Replace with your asset image path
                width: 200, // Adjust the image size as needed
              ),
              SizedBox(height: 16),
              CircularProgressIndicator(
                color: Colors.white, // Adjust the color as needed
              ),
            ],
          ),
        ),
      ),
    );
  }
}
