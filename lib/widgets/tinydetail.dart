import 'package:flutter/material.dart';

class TinyDetail extends StatelessWidget {
  const TinyDetail({
    Key? key,
    required this.icon,
    required this.value,
    required this.completer,
  }) : super(key: key);

  final IconData icon;
  final num value;
  final String completer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Text(value.toString()),
        Text(completer),
      ],
    );
  }
}
