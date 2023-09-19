import 'dart:async';
import 'package:ab_assignment/controller/weather_home_controller.dart';
import 'package:ab_assignment/screen/searched_weather.dart';
import 'package:ab_assignment/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class WeatherHomePage extends StatefulWidget {
  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  TextEditingController _searchController = TextEditingController();

  //--------homepage data storing------------
  final WeatherController weatherController = Get.put(WeatherController());
//-------------checking internet connectivity-------------
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    // TODO: implement initState
    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: sSize.height,
                  decoration: BoxDecoration(
                      color: Color(0xff293251),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue, Color(0xff293251)],
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/bg.jpg',
                        ),
                      )),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Obx(
                      () {
                        if (weatherController.weatherData.isEmpty) {
                          return WhenLoading();
                        } else {
                          final data = weatherController
                              .weatherData; // Use data to display weather information

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'Weather',
                                    style: TextStyle(
                                        color: Color(0xffF8FEFF),
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),

                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                        child: TextField(
                                      controller: _searchController,
                                      decoration: InputDecoration(
                                          hintText: 'Enter City or Zip code',
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.all(16.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide:
                                                BorderSide(color: Colors.blue),
                                          ),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                Get.to(() => SearchedResultPage(
                                                        query: _searchController
                                                            .text))!
                                                    .then((value) {
                                                  _searchController.clear();
                                                });
                                              },
                                              icon: Icon(Icons.search_sharp))),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                      ),
                                    )),
                                  ],
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
                                            Icon(
                                              Icons.person,
                                              color: Color(0xffA3B9E0),
                                              size: 20,
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
                                                  MainAxisAlignment.spaceEvenly,
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
                                                            'Sunny') {
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
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Get.to(() => WeatherHomePage());
        //   },
        //   child: Icon(Icons.refresh),
        // ),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
