import 'dart:ui';
import 'package:ab_assignment/screen/home.dart';
import 'package:ab_assignment/utils/constant.dart';
import 'package:get/get.dart';
import 'package:ab_assignment/Exceptions/exception_handling.dart';
import 'package:ab_assignment/controller/weather_home_controller.dart';
import 'package:flutter/material.dart';

class SearchedResultPage extends StatelessWidget {
  final String query; // This can be the city name or zip code
  SearchedResultPage({required this.query});

  @override
  Widget build(BuildContext context) {
    var sSize = MediaQuery.of(context).size;
    return FutureBuilder<Map<String, dynamic>>(
      future: WeatherController().fetchSearchData(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return WhenLoading();
        } else if (snapshot.hasError) {
          return CustomAlertDialog();
        } else if (snapshot.hasData) {
          final weatherData = snapshot.data!;
          final data = weatherData; // Use data to display weather information

          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: sSize.height,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/bg.jpg',
                        ),
                      )),
                      child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Center(
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.white,
                                          )),
                                      Text(
                                        'Weather of ${data['city']['name']}',
                                        style: TextStyle(
                                            color: Color(0xffF8FEFF),
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 15,
                                ),

                                SizedBox(
                                  height: 15,
                                ),
                                Center(
                                  child: Image.asset(
                                    'assets/splash icon.png',
                                    width: 220,
                                  ),
                                ),
                                Container(
                                  width: 70,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Text(
                                        '${(data['list'][0]['main']['temp'] - 273).toInt()}',
                                        style: TextStyle(
                                          color: Color(0xffF8FEFF),
                                          fontSize: 45,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        // bottom: 10,
                                        top: 10,
                                        child: Text(
                                          '°C',
                                          style: TextStyle(
                                            color: Color(0xffF8FEFF),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${data['city']['name']}',
                                      style: TextStyle(
                                        color: Color(0xffF8FEFF),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      ',${data['city']['country']}',
                                      style: TextStyle(
                                        color: Color(0xffF8FEFF),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${data['list'][0]['weather'][0]['description']}',
                                  style: TextStyle(
                                    color: Colors.yellowAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                //------------row of humidity wind and feels like-----------------
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${data['list'][0]['main']['humidity']}',
                                              style: TextStyle(
                                                color: Color(0xffA3B9E0),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/humidity.png',
                                              color: Color(0xffF8FEFF),
                                              height: 20,
                                              width: 30,
                                            ),
                                            Text(
                                              'Humidity',
                                              style: TextStyle(
                                                color: Color(0xffA3B9E0),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      height: sSize.height * .1,
                                      width: sSize.width * .25,
                                      decoration: BoxDecoration(
                                          color: Color(0xff384266),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${data['list'][0]['wind']['speed']}',
                                              style: TextStyle(
                                                color: Color(0xffA3B9E0),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/wind.png',
                                              color: Color(0xffF8FEFF),
                                              height: 20,
                                              width: 30,
                                            ),
                                            Text(
                                              'Wind',
                                              style: TextStyle(
                                                color: Color(0xffA3B9E0),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      height: sSize.height * .1,
                                      width: sSize.width * .25,
                                      decoration: BoxDecoration(
                                          color: Color(0xff384266),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${(data['list'][0]['main']['feels_like'] - 273).toInt()} c',
                                              style: TextStyle(
                                                color: Color(0xffA3B9E0),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/wind.png',
                                              color: Color(0xffF8FEFF),
                                              height: 20,
                                              width: 30,
                                            ),
                                            Text(
                                              'Feels',
                                              style: TextStyle(
                                                color: Color(0xffA3B9E0),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      height: sSize.height * .1,
                                      width: sSize.width * .25,
                                      decoration: BoxDecoration(
                                          color: Color(0xff384266),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //------------------------botttom list of weather expect----------------------
                                SizedBox(
                                    height: sSize.height * .2,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: data['list'].length,
                                        itemBuilder: (context, index) {
                                          String dateTimeString =
                                              data['list'][index]['dt_txt'];
                                          DateTime dateTime =
                                              DateTime.parse(dateTimeString);
                                          String timeString =
                                              '${dateTime.hour}:${dateTime.minute}';
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white54),
                                            margin: EdgeInsets.only(right: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  '${data['list'][index]['weather'][0]['description']}',
                                                  style: TextStyle(
                                                    color: Colors.black38,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.asset(
                                                      (() {
                                                        final weatherMain =
                                                            data['list'][index]
                                                                    ['weather']
                                                                [0]['main'];
                                                        if (weatherMain ==
                                                            'Rain') {
                                                          return 'assets/rainy.png';
                                                        } else if (weatherMain ==
                                                            'Clear') {
                                                          return 'assets/sunny.jpg';
                                                        } else {
                                                          return 'assets/cloudy.png';
                                                        }
                                                      })(),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "At:",
                                                        style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      Text(
                                                        timeString,
                                                        style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        })),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Get.to(() => WeatherHomePage());
                },
                child: Icon(Icons.home),
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
