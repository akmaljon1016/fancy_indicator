import 'package:example/core/utils/utils.dart';
import 'package:example/generated/assets.dart';
import 'package:example/humidity/page/humunity_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///Home Page
class HomePage extends StatefulWidget {
  ///Home Page Empty Constructor
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTabIndex = 1;

  List<Widget> pages = [
    Container(
      color: Utils.primaryColor,
    ),

     HumidityPage(),
    Container(color: Utils.primaryColor)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.primaryColor,
      body: pages[selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: selectedTabIndex,
        backgroundColor: Utils.primaryColor,
        selectedItemColor: Utils.whiteColor,
        unselectedItemColor: Utils.greyColor,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.iconsChart,
                colorFilter: ColorFilter.mode(
                    selectedTabIndex == 0
                        ? Utils.whiteColor
                        : Utils.greyDarkerColor,
                    BlendMode.srcIn),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.iconsDrop,
                  colorFilter: ColorFilter.mode(
                      selectedTabIndex == 1
                          ? Utils.whiteColor
                          : Utils.greyDarkerColor,
                      BlendMode.srcIn)),
              label: ""),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.iconsHome,
                  colorFilter: ColorFilter.mode(
                      selectedTabIndex == 2
                          ? Utils.whiteColor
                          : Utils.greyDarkerColor,
                      BlendMode.srcIn)),
              label: ""),
        ],
        onTap: (int index) {
          setState(() {
            selectedTabIndex = index;
          });
        },
      ),
    );
  }
}
