import 'package:flutter/material.dart';
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
    Provider.of<ProviderCurrentLocation>(context, listen: false)
        .isGettingLocation(false);
    String result = await ServicesCurrentLocation.getGeoPositionWeatherData({
      "lat": currentPos.latitude.toString(),
      "lon": currentPos.longitude.toString(),
      "appid": ConfigReader.getApiKey(),
      "units": "metric"
    });
    if (!mounted) return;
    Provider.of<ProviderCurrentLocation>(context, listen: false)
        .saveCurrentLocationData(result);
    print(result);
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
                  children: const [
                    Icon(Icons.location_on_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'San Francisco',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.search_rounded,
                    color: Colors.white,
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
          : GeoLocation(screenHeight: screenHeight),
    );
  }
}

class GeoLocation extends StatelessWidget {
  const GeoLocation({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Placeholder(
            fallbackHeight: screenHeight * 0.4,
          ),
          const Text(
            'Cloudy',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              '28º',
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              TinyDetail(
                icon: Icons.air,
                value: 8,
                completer: 'km/h',
              ),
              SizedBox(
                width: 20,
              ),
              TinyDetail(
                icon: Icons.water_drop_rounded,
                value: 47,
                completer: '%',
              ),
            ],
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return const BoxDaily(
                  date: "Today",
                  icon: Icons.cloudy_snowing,
                  heat: '28',
                );
              },
              itemCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}
