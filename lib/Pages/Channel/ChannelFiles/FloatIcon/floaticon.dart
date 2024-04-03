import 'package:flutter/material.dart';

class FloatIcon extends StatelessWidget {
  final Icon icon;
  const FloatIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(20)),
        child: icon);
  }
}
