import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NavbarItem extends Equatable {
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
