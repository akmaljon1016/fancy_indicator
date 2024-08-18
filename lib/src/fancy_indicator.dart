import 'package:fancy_indicator/src/indicator_drawing_engine.dart';
import 'package:fancy_indicator/src/fancy_indicator_utils.dart';
import 'package:flutter/material.dart';

class FancyIndicator extends StatefulWidget {
  final List<Color> gradientColors;
  final List<double> gradientColorsStops;
  final double height;
  final double width;
  final Function(int indicatorNumber) onSelectedNumber;
  final List<int> marker;
  final Color labelTextColor;
  final Color selectedTextColor;
  final Color measureItemColor;
  final Color backgroundColor;
  final String numberAppendix;
  final Color draggableButtonColor;
  final Color draggableButtonIconsColor;
  final Color draggableButtonCircleColor;
  final Color draggableButtonCircleAnimateColor;
  final double labelTextSize;
  final double selectedTextSize;

  const FancyIndicator(
      {super.key,
      required this.gradientColors,
      required this.gradientColorsStops,
      required this.width,
      required this.height,
      required this.onSelectedNumber,
      this.marker = const [],
      this.labelTextColor = FancyIndicatorUtils.whiteColor,
      this.selectedTextColor = FancyIndicatorUtils.blueColor,
      this.measureItemColor = FancyIndicatorUtils.yellowColor,
      this.backgroundColor = FancyIndicatorUtils.primaryColor,
      this.numberAppendix = "%",
      this.draggableButtonColor = FancyIndicatorUtils.whiteColor,
      this.draggableButtonCircleColor = FancyIndicatorUtils.greyDarkerColor,
      this.draggableButtonIconsColor = FancyIndicatorUtils.triangleColor,
      this.draggableButtonCircleAnimateColor = FancyIndicatorUtils.greyColor,
      this.labelTextSize = 20,
      this.selectedTextSize = 30});

  @override
  State<FancyIndicator> createState() => _FancyIndicatorState();
}

class _FancyIndicatorState extends State<FancyIndicator>
    with SingleTickerProviderStateMixin {
  var _tapPosition = Offset.zero;
  var _dragPosition = Offset.infinite;
  var _shouldDraw = false;
  var _validPressed = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isPlaying = false;
  bool isResumed = false;
  int selectedPercent = 0;
  ///atomicVariable is declared for controlling ValueListenableBuilder
  ///when animation behaviour or status change atomicVariable is assign reverse value
  ValueNotifier<bool> atomicVariable = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    /// This i controller that responsible for draggable button  animation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500), // Duration of the animation
      vsync: this,
    );

    /// _animation is Animation object defines animation behaviour
    _animation = Tween<double>(begin: 40.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    ///This is a listener that trigger addListener every animation value change
    _animation.addListener(() {
      if (_animation.value <= 18.0 && isPlaying && isResumed == false) {
        _pauseAnimation();
      }
      atomicVariable.value = !atomicVariable.value;
    });

    ///this is callback function, when animation status change it gives status
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        isPlaying = false;
        atomicVariable.value = !atomicVariable.value;
      }
    });
  }

  ///Start draggable button animation
  void _startAnimation() {
    if (!isPlaying) {
      _controller.forward();
      isPlaying = true;
      isResumed = false;
      atomicVariable.value = !atomicVariable.value;
    }
  }

  ///Pause draggable button animation
  void _pauseAnimation() {
    if (isPlaying) {
      _controller.stop();
      isPlaying = false;
      isResumed = false;
      atomicVariable.value = !atomicVariable.value;
    }
  }

  ///Resume draggable button animation
  void _resumeAnimation() {
    if (!isPlaying) {
      _controller.forward();
      isPlaying = true;
      isResumed = true;
      atomicVariable.value = !atomicVariable.value;
    }
  }
  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.backgroundColor,
      child: GestureDetector(
        child: ValueListenableBuilder(
            valueListenable: atomicVariable,
            builder: (context, value, child) {
              return CustomPaint(
                size: Size(MediaQuery.of(context).size.width / 1.8,
                    MediaQuery.of(context).size.height),
                painter: IndicatorDrawingEngine(
                    tapPosition: _tapPosition,
                    dragPosition: _dragPosition,
                    validPressed: _validPressed,
                    onShouldDraw: (bool shouldDraw, int selectedPercent) {
                      _shouldDraw = shouldDraw;
                      this.selectedPercent = selectedPercent;
                    },
                    waveRadius: _animation.value,
                    gradientColors: widget.gradientColors,
                    gradientColorsStops: widget.gradientColorsStops,
                    marker: widget.marker,
                    labelTextColor: widget.labelTextColor,
                    selectedTextColor: widget.selectedTextColor,
                    measureItemColor: widget.measureItemColor,
                    numberAppendix: widget.numberAppendix,
                    draggableButtonColor: widget.draggableButtonColor,
                    draggableButtonIconsColor: widget.draggableButtonIconsColor,
                    draggableButtonCircleColor:
                        widget.draggableButtonCircleColor,
                    draggableButtonCircleAnimateColor:
                        widget.draggableButtonCircleAnimateColor,
                    labelTextSize: widget.labelTextSize,
                    selectedTextSize: widget.selectedTextSize),
              );
            }),

        ///When Draggable button tap down it change _validPressed =true;
        onTapDown: (details) {
          if (_shouldDraw) {
            _validPressed = true;
          }
          _tapPosition = details.localPosition;
          _startAnimation();
        },
        ///When Draggable button tap up it change _validPressed =false;
        onTapUp: (detail) {
          _tapPosition = Offset.zero;
          _validPressed = false;
          _resumeAnimation();
        },
        ///When Draggable button drag vertically it change _validPressed =true
        /// and assign new localPosition to_tapPosition;

        onVerticalDragStart: (details) {
          if (_shouldDraw) {
            _validPressed = true;
          }
          _tapPosition = details.localPosition;
        },
        ///When Draggable button finish drag end it change _validPressed =false
        /// and assign Offset.zero to_tapPosition;
        ///also  send selectedPercent  number through onSelectedCallback
        ///and resume animation function for completion and finish

        onVerticalDragEnd: (details) {
          _tapPosition = Offset.zero;
          _validPressed = false;
          widget.onSelectedNumber(selectedPercent);
          _resumeAnimation();
        },
        ///when Draggable button drags it change _validPressed=true
        ///and assign new localPosition to_tapPosition
        ///change atomicVariable to reverse value for trigger ValueListenableBuilder
        onVerticalDragUpdate: (details) {
          if (_shouldDraw) {
            _validPressed = true;
            _dragPosition = details.localPosition;
            atomicVariable.value = !atomicVariable.value;
          }
        },
      ),
    );
  }
}
