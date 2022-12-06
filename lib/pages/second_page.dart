import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clima/classes/coord_class.dart';
import 'package:flutter_clima/helpers/datetime_ext.dart';
import 'package:flutter_clima/helpers/string_ext.dart';
import 'package:flutter_clima/providers/customcity_provider.dart';
import 'package:flutter_clima/providers/searchcity_provider.dart';
import 'package:flutter_clima/services/configreader.dart';
import 'package:flutter_clima/services/searchlocation_services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../services/currentlocation_services.dart';
import '../widgets/tinydetail.dart';

///SECOND PAGE, SHOW DETAIL FOR SOME WEATHER LOCATION

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  void searchCity() async {
    if (!mounted) return;
    Provider.of<ProviderSearchCity>(context, listen: false)
        .changeStateSearching(true);
    String res = await ServicesSearchLocation.getLocationsByName({
      "q": Provider.of<ProviderSearchCity>(context, listen: false).citysearched,
      "limit": "10",
      "appid": ConfigReader.getApiKey(),
    });

    if (!mounted) return;
    Provider.of<ProviderSearchCity>(context, listen: false)
        .saveCitiesAvailables(jsonDecode(res));

    Provider.of<ProviderSearchCity>(context, listen: false)
        .changeStateSearching(false);
    print(res);
  }

  void getCityWeather(int index) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;
    Provider.of<ProviderCustomCity>(context, listen: false)
        .isGettingLocation(true);
    Coord coordCitySelected =
        Provider.of<ProviderSearchCity>(context, listen: false)
            .getCoodByIndex(index);

    String resultCurrentWeather =
        await ServicesCurrentLocation.getGeoPositionWeatherData({
      "lat": coordCitySelected.lat.toString(),
      "lon": coordCitySelected.lon.toString(),
      "appid": ConfigReader.getApiKey(),
      "units": "metric",
      "lang": "es"
    });

    String resultForecastWeather =
        await ServicesCurrentLocation.getForecastWeather({
      "lat": coordCitySelected.lat.toString(),
      "lon": coordCitySelected.lon.toString(),
      "appid": ConfigReader.getApiKey(),
      "units": "metric",
      "lang": "es"
    });

    Map<String, dynamic> currentWeatherMap = jsonDecode(resultCurrentWeather);
    Map<String, dynamic> forecastWeatherMap = jsonDecode(resultForecastWeather);

    if (!mounted) return;
    Provider.of<ProviderCustomCity>(context, listen: false)
        .saveCurrentLocationData(currentWeatherMap);
    Provider.of<ProviderCustomCity>(context, listen: false)
        .saveForecastLocationData(forecastWeatherMap);

    Provider.of<ProviderCustomCity>(context, listen: false)
        .isGettingLocation(false);
  }

  @override
  void initState() {
    super.initState();
    // buscarCiudad();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenTopPadding = MediaQuery.of(context).padding.top;
    const double rightPadding = 10;

    return Scaffold(
      backgroundColor: const Color(0xff232535),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // title: const Text("First Page"),
        flexibleSpace: Container(
          height: kToolbarHeight + screenTopPadding,
          color: Colors.red,
          padding: EdgeInsets.fromLTRB(
            50,
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
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: screenWidth * 0.6,
                      child: TextFormField(
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Ingresar una ciudad...',
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                        onChanged: (value) {
                          Provider.of<ProviderSearchCity>(context,
                                  listen: false)
                              .setCitySearch(value);
                        },
                        onFieldSubmitted:
                            Provider.of<ProviderSearchCity>(context)
                                        .citysearched ==
                                    ""
                                ? null
                                : (value) {
                                    searchCity();
                                  },
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  ),
                  onPressed:
                      Provider.of<ProviderSearchCity>(context).citysearched ==
                              ""
                          ? null
                          : () {
                              searchCity();
                            },
                )
              ],
            ),
          ),
        ),
      ),
      body: Provider.of<ProviderCustomCity>(context).detalle == null &&
              !Provider.of<ProviderCustomCity>(context).gettingLocation
          ? Provider.of<ProviderSearchCity>(context).searching
              ? const ShimmerBuscador()
              : ListaBuscadorCiudad(
                  onCityClicked: (int value) {
                    getCityWeather(value);
                  },
                )
          : Provider.of<ProviderCustomCity>(context).gettingLocation
              ? ShimmerDetalle(screenHeight: screenHeight)
              : DetalleCiudad(
                  screenHeight: screenHeight,
                  imageUrl: Provider.of<ProviderCustomCity>(context)
                      .getActualWeatherIcon(),
                  weatherDescription: Provider.of<ProviderCustomCity>(context)
                      .getWeatherDescription()
                      .toTitleCase(),
                  maxTemp:
                      Provider.of<ProviderCustomCity>(context).getMaxTemp(),
                  minTemp:
                      Provider.of<ProviderCustomCity>(context).getMinTemp(),
                  weatherActualTemp: Provider.of<ProviderCustomCity>(context)
                      .getWeatherActualTemp(),
                ),
    );
  }
}

class ShimmerDetalle extends StatelessWidget {
  const ShimmerDetalle({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey,
      child: Column(
        children: [
          Container(
            color: Colors.white.withOpacity(0.4),
            height: screenHeight * 0.26,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 30,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 90,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 30,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  // width: 120,
                  height: 60,
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  color: Colors.white.withOpacity(0.4),
                );
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerBuscador extends StatelessWidget {
  const ShimmerBuscador({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey,
      child: Center(
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 30,
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 2,
              height: 4,
              color: Colors.transparent,
            );
          },
          itemBuilder: (context, index) {
            return Container(
              color: Colors.white.withOpacity(0.4),
              height: 42,
            );
          },
        ),
      ),
    );
  }
}

class DetalleCiudad extends StatelessWidget {
  const DetalleCiudad(
      {Key? key,
      required this.imageUrl,
      required this.screenHeight,
      required this.weatherDescription,
      required this.weatherActualTemp,
      required this.minTemp,
      required this.maxTemp})
      : super(key: key);
  final double screenHeight;
  final String imageUrl,
      weatherDescription,
      weatherActualTemp,
      minTemp,
      maxTemp;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: const TextStyle(color: Colors.white),
      child: Center(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              height: screenHeight * 0.3,
            ),
            Text(
              weatherDescription,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                weatherActualTemp,
                style: const TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TinyDetail(
                  value: minTemp,
                  completer: 'Min',
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text('/'),
                const SizedBox(
                  width: 5,
                ),
                TinyDetail(
                  value: maxTemp,
                  completer: 'Max',
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Proximos dias"),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  var actualDate = DateTime.now().add(Duration(days: index));
                  String indexDay = actualDate.day == DateTime.now().day
                      ? "Hoy"
                      : actualDate.weekdayName()!;
                  return Container(
                    color: index % 2 == 0
                        ? Colors.grey.withOpacity(0.6)
                        : Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          indexDay,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Provider.of<ProviderCustomCity>(context)
                                  .getForecastMinTemp(index),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text('/'),
                            Text(
                              Provider.of<ProviderCustomCity>(context)
                                  .getForecastMaxTemp(index),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        CachedNetworkImage(
                          imageUrl: Provider.of<ProviderCustomCity>(context)
                              .getForecastWeatherIcon(index),
                          height: 65,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListaBuscadorCiudad extends StatefulWidget {
  const ListaBuscadorCiudad({
    required this.onCityClicked,
    Key? key,
  }) : super(key: key);

  final ValueChanged<int> onCityClicked;

  @override
  State<ListaBuscadorCiudad> createState() => _ListaBuscadorCiudadState();
}

class _ListaBuscadorCiudadState extends State<ListaBuscadorCiudad> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
        itemCount:
            Provider.of<ProviderSearchCity>(context).citiesAvailables?.length ??
                0,
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 2,
            height: 4,
            color: Colors.white.withOpacity(0.2),
          );
        },
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              widget.onCityClicked(index);
            },
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: Text(
                  Provider.of<ProviderSearchCity>(context)
                      .getCityNameByIndex(index),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
