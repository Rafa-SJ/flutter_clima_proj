import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BoxDaily extends StatelessWidget {
  const BoxDaily({
    required this.date,
    required this.imageUrl,
    required this.min,
    required this.max,
    Key? key,
  }) : super(key: key);

  final String date;
  final String imageUrl;
  final String min;
  final String max;

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
                // color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: separatorLenght,
            ),
            CachedNetworkImage(
              imageUrl: imageUrl,
              height: 60,
            ),
            SizedBox(
              height: separatorLenght,
            ),
            SizedBox(
              width: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    min,
                    style: const TextStyle(
                      color: Color(0xff2D305C),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('/'),
                  Text(
                    max,
                    style: const TextStyle(
                      color: Color(0xff2D305C),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
