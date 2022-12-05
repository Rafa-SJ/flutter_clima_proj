import 'package:flutter/material.dart';

class TinyDetail extends StatelessWidget {
  const TinyDetail({
    Key? key,
    required this.value,
    required this.completer,
  }) : super(key: key);

  final String value;
  final String completer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          completer,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
