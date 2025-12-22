// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.themeData, this.primaryColor = const Color(0xffFFA500)});

  final ThemeData themeData;
  final Color primaryColor;

  @override
  List<Object> get props => [themeData.hashCode, primaryColor.hashCode];
}
