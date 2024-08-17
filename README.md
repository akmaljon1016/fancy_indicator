# fancy_indicator

FancyIndicator Widget
The FancyIndicator is a customizable Flutter widget that provides a visual indicator with gradient colors, labels, and a dynamic animation. It can be used to create interactive indicators for selecting a value by tapping or dragging.

## Showcase
<img src=https://github.com/akmaljon1016/fancy_indicator/blob/main/screen_record2.gif  height="275">
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
## Parameters
- gradientColors (List<Color>): A list of colors used for the gradient in the indicator.

- gradientStopColors (List<double>): A list of stops for the gradient colors.

- width (double): The width of the indicator widget.

- height (double): The height of the indicator widget.

- onSelectedNumber (Function(int)): Callback function triggered when a number is selected via dragging or tapping.

- marker (List<int>): Optional list of marker points that can be used to highlight specific values on the indicator. Default is an empty list.

- labelTextColor (Color): The color of the labels for the indicator. Default is FancyIndicatorUtils.whiteColor.

- selectedTextColor (Color): The color of the selected label text. Default is FancyIndicatorUtils.blueColor.

- measureItemColor (Color): The color used for the measurement items in the indicator. Default is FancyIndicatorUtils.yellowColor.

- backgroundColor (Color): The background color of the indicator widget. Default is FancyIndicatorUtils.primaryColor.

- numberAppendix (String): The string appended to the selected number in the indicator. Default is "%".
