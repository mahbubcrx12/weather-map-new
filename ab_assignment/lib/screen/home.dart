import 'package:ab_assignment/controller/weather_home_controller.dart';
import 'package:ab_assignment/screen/searched_weather.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherHomePage extends StatelessWidget {
  TextEditingController _searchController = TextEditingController();
  final WeatherHomeController weatherController =
      Get.put(WeatherHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Home Page'),
      ),
      body: Center(
        child: Obx(
          () {
            if (weatherController.weatherData.isEmpty) {
              return CircularProgressIndicator();
            } else {
              final data = weatherController.weatherData;
              // Use data to display weather information
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                                hintText: 'Enter City or Zip code'),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Get.to(() => SearchedResultPage(
                                      query: _searchController.text))!
                                  .then((value) {
                                _searchController.clear();
                              });
                            },
                            icon: Icon(Icons.search_sharp))
                      ],
                    ),
                  ),

                  Text('City: ${data['city']['name']}'),
                  Text(
                      'Temperature: ${data['list'][0]['main']['temp'] - 273}°C'),
                  // Add more widgets to display other weather information
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
