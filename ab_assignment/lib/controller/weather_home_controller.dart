import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherHomeController extends GetxController {
  var weatherData = {}.obs;
  Position? position;
  double? lat;
  double? lon;

  @override
  void onInit() {
    super.onInit();
    _determinePosition();
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    position = await Geolocator.getCurrentPosition();
    lat = position!.latitude;
    lon = position!.longitude;
    print("latitude : $lat, longitude: $lon");
    fetchData(lat!, lon!);
  }

  void fetchData(double lat, double lon) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=${lat}&lon=${lon}&appid=906c0c77ba8058de5f2455853703dc3e'));
    print('rrrrrrrrrrrrrrrrrrrrrrrrrrr');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      weatherData.value = data;
    } else {
      throw Exception('Failed to load data');
    }
  }

//-----------------------fetch data for search-----------------------
  Future<Map<String, dynamic>> fetchSearchData(String query) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$query&appid=906c0c77ba8058de5f2455853703dc3e'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
