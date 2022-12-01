import 'package:flutter/material.dart';

import '../widgets/boxdia.dart';
import '../widgets/tinydetail.dart';

///FIRST PAGE, SHOWS YOUR LOCATION WEATHER

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff70F3EB),
      appBar: AppBar(
        title: const Text("First Page"),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: const [
                Icon(Icons.location_on_rounded),
                Text('San Francisco')
              ],
            ),
            const Placeholder(
              fallbackHeight: 200,
            ),
            const Text('Cloudy'),
            const Text('28º'),
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
                  return const BoxDia(
                      date: "Today", icon: Icons.cloudy_snowing, heat: '28');
                },
                itemCount: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
