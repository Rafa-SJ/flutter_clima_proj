import 'package:flutter/material.dart';

class BoxDaily extends StatelessWidget {
  const BoxDaily({
    required this.date,
    required this.icon,
    required this.heat,
    Key? key,
  }) : super(key: key);

  final String date;
  final IconData icon;
  final String heat;

  final double separatorLenght = 5;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      elevation: 0,
      color: Colors.white.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: separatorLenght,
            ),
            const Icon(
              Icons.cloud,
              size: 60,
            ),
            SizedBox(
              height: separatorLenght,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '$heatº',
                style: const TextStyle(
                  color: Color(0xff2D305C),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
