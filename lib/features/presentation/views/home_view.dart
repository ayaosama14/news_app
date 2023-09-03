import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/features/presentation/views/other_screens/choose_category.dart';
import 'package:news_app/features/presentation/views/widgets/main_navigation_bar.dart';

// api key bdcd432edce64b73b050a35f7def53cf
class HomeView extends StatefulWidget {
  final List<String> passedParameterList;

  const HomeView({super.key, required this.passedParameterList});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: MainNavigationBar(),
      ),
    );
  }
}
