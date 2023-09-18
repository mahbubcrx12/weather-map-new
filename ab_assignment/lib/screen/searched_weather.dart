import 'package:ab_assignment/controller/weather_home_controller.dart';
import 'package:flutter/material.dart';

class SearchedResultPage extends StatelessWidget {
  final String query; // This can be the city name or zip code
  SearchedResultPage({required this.query});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: WeatherHomeController().fetchSearchData(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final weatherData = snapshot.data!;
          // Use weatherData to display weather information in your widget
          return Scaffold(
            appBar: AppBar(
              title: Text('Searched city'),
            ),
            body: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    'City: ${weatherData['city']['name']}',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Text(
                      'Temperature: ${weatherData['list'][0]['main']['temp'] - 273}°C',
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  // Add more widgets to display other weather information
                ],
              ),
            ),
          );
        } else {
          return Text('No data available');
        }
      },
    );
  }
}
