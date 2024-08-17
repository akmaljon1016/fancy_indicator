# fancy_indicator

FancyIndicator Widget
The FancyIndicator is a customizable Flutter widget that provides a visual indicator with gradient colors, labels, and a dynamic animation. It can be used to create interactive indicators for selecting a value by tapping or dragging.

## Showcase
<img src=https://github.com/akmaljon1016/fancy_indicator/blob/main/screen_record.gif  height="275">

## Usage example
Import the package in your Dart code:

   ```yaml
   https://pub.dev/packages/fancy_indicator
   ```  
## FancyIndicator properties

```Dart

const FancyIndicator({
  Key? key,
  required List<Color> gradientColors,
  required List<double> gradientStopColors,
  required double width,
  required double height,
  required Function(int indicatorNumber) onSelectedNumber,
  List<int> marker = const [],
  Color labelTextColor = FancyIndicatorUtils.whiteColor,
  Color selectedTextColor = FancyIndicatorUtils.blueColor,
  Color measureItemColor = FancyIndicatorUtils.yellowColor,
  Color backgroundColor = FancyIndicatorUtils.primaryColor,
  String numberAppendix = "%",
})
```
