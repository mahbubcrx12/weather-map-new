import 'dart:ui';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class WhenLoading extends StatelessWidget {
  const WhenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(
          'assets/bg.jpg',
        ),
      )),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitSpinningLines(
                color: Colors.yellowAccent, // Color of the spinner
                size: 70.0, // Size of the spinner
              ),
              Text(
                'Plaese wait,Data is loading...',
                style: TextStyle(
                    color: Color(0xffF8FEFF),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              )
            ],
          ))),
    );
  }
}
