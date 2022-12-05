import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clima/helpers/datetime_ext.dart';
import 'package:flutter_clima/helpers/string_ext.dart';
import 'package:flutter_clima/providers/currentlocation_provider.dart';
import 'package:flutter_clima/services/configreader.dart';
import 'package:flutter_clima/services/currentlocation_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../widgets/boxdia.dart';
import '../widgets/tinydetail.dart';

///FIRST PAGE, SHOWS YOUR LOCATION WEATHER

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void getLocation() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;
    Provider.of<ProviderCurrentLocation>(context, listen: false)
        .isGettingLocation(true);
    Position? currentPos =
        await ServicesCurrentLocation.getDeviceLocation().catchError(
      (err) {
        print('Error: $err');
        // Provider.of<ProviderCurrentLocation>(context, listen: false)
        //     .locationUnavailableMessage = err;
        Provider.of<ProviderCurrentLocation>(context, listen: false)
            .isGettingLocation(false);
      },
    );
    if (!mounted) return;

    String resultCurrentWeather =
        await ServicesCurrentLocation.getGeoPositionWeatherData({
      "lat": currentPos.latitude.toString(),
      "lon": currentPos.longitude.toString(),
      "appid": ConfigReader.getApiKey(),
      "units": "metric",
      "lang": "es"
    });

    String resultForecastWeather =
        await ServicesCurrentLocation.getForecastWeather({
      "lat": currentPos.latitude.toString(),
      "lon": currentPos.longitude.toString(),
      "appid": ConfigReader.getApiKey(),
      "units": "metric",
      "lang": "es"
    });

    Map<String, dynamic> currentWeatherMap = jsonDecode(resultCurrentWeather);
    Map<String, dynamic> forecastWeatherMap = jsonDecode(resultForecastWeather);

    if (!mounted) return;
    Provider.of<ProviderCurrentLocation>(context, listen: false)
        .saveCurrentLocationData(currentWeatherMap);
    Provider.of<ProviderCurrentLocation>(context, listen: false)
        .saveForecastLocationData(forecastWeatherMap);

    Provider.of<ProviderCurrentLocation>(context, listen: false)
        .isGettingLocation(false);
    print(resultCurrentWeather);
    print(currentPos);
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenTopPadding = MediaQuery.of(context).padding.top;
    final double screenBottomPadding = MediaQuery.of(context).padding.bottom;
    final double leftPadding = 10;
    final double rightPadding = 10;

    return Scaffold(
      backgroundColor: const Color(0xff70F3EB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // title: const Text("First Page"),
        flexibleSpace: Container(
          height: kToolbarHeight + screenTopPadding,
          // color: Colors.red,
          padding: EdgeInsets.fromLTRB(
            leftPadding,
            screenTopPadding,
            rightPadding,
            0,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      Provider.of<ProviderCurrentLocation>(context)
                          .getCityName(),
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.search_rounded,
                    // color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/second');
                  },
                )
              ],
            ),
          ),
        ),
      ),
      body: Provider.of<ProviderCurrentLocation>(context, listen: true)
              .gettingLocation
          ? Container()
          : GeoLocation(
              screenHeight: screenHeight,
              bottomPadding: screenBottomPadding,
            ),
    );
  }
}

class GeoLocation extends StatelessWidget {
  const GeoLocation({
    Key? key,
    required this.screenHeight,
    required this.bottomPadding,
  }) : super(key: key);

  final double screenHeight;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding + 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CachedNetworkImage(
            imageUrl: Provider.of<ProviderCurrentLocation>(context)
                .getActualWeatherIcon(),
            height: screenHeight * 0.3,
          ),
          Text(
            Provider.of<ProviderCurrentLocation>(context)
                .getWeatherDescription()
                .toTitleCase(),
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              Provider.of<ProviderCurrentLocation>(context)
                  .getWeatherActualTemp(),
              style: const TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              TinyDetail(
                value: 8,
                completer: 'ºMin',
              ),
              SizedBox(
                width: 5,
              ),
              Text('/'),
              SizedBox(
                width: 5,
              ),
              TinyDetail(
                value: 47,
                completer: 'ºMax',
              ),
            ],
          ),
          SizedBox(
            height: 150,
            child: Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var actualDate = DateTime.now().add(Duration(days: index));
                  String indexDay = actualDate.day == DateTime.now().day
                      ? "Hoy"
                      : actualDate.weekdayName()!;
                  return BoxDaily(
                    date: indexDay,
                    imageUrl: Provider.of<ProviderCurrentLocation>(context)
                        .getForecastWeatherIcon(index),
                    min: Provider.of<ProviderCurrentLocation>(context)
                        .getForecastMinTemp(index),
                    max: Provider.of<ProviderCurrentLocation>(context)
                        .getForecastMaxTemp(index),
                  );
                },
                itemCount: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
