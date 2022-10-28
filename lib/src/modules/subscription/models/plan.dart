import 'package:flutter/material.dart';

class Plan {
  final String label;
  final double amount;
  final Color color;
  final List<String> packages;

  Plan({
    required this.label,
    required this.amount,
    required this.color,
    required this.packages,
  });
}
