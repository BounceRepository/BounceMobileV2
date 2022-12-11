import 'package:flutter/material.dart';

class NavbarItem {
  final String label;
  final String icon;
  final Widget screen;
  bool selected;

  NavbarItem({
    required this.label,
    required this.icon,
    required this.screen,
    this.selected = false,
  });

  @override
  List<Object?> get props => [label];
}
