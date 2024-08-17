import 'package:example/core/utils/fancy_indicator_resources.dart';
import 'package:example/core/utils/utils.dart';
import 'package:example/generated/assets.dart';
import 'package:fancy_indicator/fancy_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HumidityPage extends StatefulWidget {
  const HumidityPage({super.key});

  @override
  State<HumidityPage> createState() => _HumidityPageState();
}

class _HumidityPageState extends State<HumidityPage> {
  final ValueNotifier<int> currentHumidity = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.primaryColor,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              FancyIndicator(
                numberAppendix: symbol[NumberAppendix.percent] ?? "%",
                gradientColors: const [
                  Color(0xFFD00D7E),
                  Color(0xFF02B3E2),
                  Color(0xFFD00D7E),
                ],
                gradientColorsStops: const [
                  0.2,
                  0.7,
                  0.9,
                ],
                width: MediaQuery.of(context).size.width / 1.8,
                height: MediaQuery.of(context).size.height,
                marker: const [20,30,40],
                onSelectedNumber: (number) {
                  currentHumidity.value = number;
                },
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "RETURN TEMPERATURE",
                      style: TextStyle(
                          color: Utils.lightGrayColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("20°C",
                        style: TextStyle(
                            color: Utils.whiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 20)),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "CURRENT HUMIDITY",
                      style: TextStyle(
                          color: Utils.lightGrayColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    ValueListenableBuilder(
                        valueListenable: currentHumidity,
                        builder: (context, value, child) {
                          print(value);
                          return Text(
                            "$value%",
                            style: const TextStyle(
                                color: Utils.whiteColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 60),
                            textAlign: TextAlign.center,
                          );
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "ABSOLUTE HUMIDITY",
                      style: TextStyle(
                          color: Utils.lightGrayColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("4gr/ft3",
                        style: TextStyle(
                            color: Utils.whiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 20)),
                    const SizedBox(
                      height: 20,
                    ),
                    SvgPicture.asset(
                      Assets.iconsAlert,
                      width: 40,
                      height: 40,
                      colorFilter: const ColorFilter.mode(
                          Utils.yellowColor, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: const TextSpan(
                            text: "\u{1F7E1}",
                            style: TextStyle(
                                color: Utils.whiteColor,
                                fontSize: 10,
                                height: 1.5),
                            children: [
                              TextSpan(
                                text:
                                    "- extreme humidity level.\nUse precaution for set-points outside of 20%-55%",
                                style: TextStyle(
                                    color: Utils.whiteColor, fontSize: 14),
                              )
                            ]),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
