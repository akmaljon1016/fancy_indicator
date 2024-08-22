import 'package:example/core/utils/fancy_indicator_resources.dart';
import 'package:example/core/utils/utils.dart';
import 'package:example/generated/assets.dart';
import 'package:example/home/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fancy_indicator/fancy_indicator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}
