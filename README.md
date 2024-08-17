# fancy_indicator

FancyIndicator Widget
The FancyIndicator is a customizable Flutter widget that serves as a visual indicator with gradient colors, labels, and dynamic animations. It's ideal for creating interactive indicators that users can manipulate by tapping or dragging, providing an intuitive interface for selecting values.

## Showcase
<div style="display: flex; flex-direction: row;">
    <img src="https://github.com/akmaljon1016/fancy_indicator/blob/main/Screen_recording_1.gif" height="275" alt="Fancy Indicator Example 1" style="margin-right: 100px;">
    <img src="https://github.com/akmaljon1016/fancy_indicator/blob/main/Screen_recording_2.gif" height="275" alt="Fancy Indicator Example 2">
</div>

## Usage example

To use the FancyIndicator widget in your Flutter project, add the following dependency to your pubspec.yaml:
```
dependencies:
  fancy_indicator: ^1.0.0

```
Then, import the package and use the widget as shown below:

```Dart
import 'package:fancy_indicator/fancy_indicator.dart';

class ExampleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FancyIndicator(
          gradientColors: [Colors.blue, Colors.red],
          gradientColorsStops: [0.0, 1.0],
          width: 300,
          height: 100,
          onSelectedNumber: (selectedNumber) {
          },
          
          marker: [10, 20, 30],
          labelTextColor: Colors.white,
          selectedTextColor: Colors.green,
          measureItemColor: Colors.yellow,
          backgroundColor: Colors.black,
          draggableButtonColor: Colors.white,
          draggableButtonCircleColor: Colors.grey,
          draggableButtonIconsColor: Colors.red,
          draggableButtonCircleAnimateColor: Colors.blue,
          labelTextSize: 18,
          selectedTextSize: 24,
        ),
      ),
    );
  }
}

```
 
## FancyIndicator properties

FancyIndicator Properties

The FancyIndicator widget exposes several customizable properties, allowing you to tailor the appearance and behavior to fit your needs:

Required Parameters:
- `gradientColors` (List<Color>): The colors used for the gradient fill of the indicator.
- `gradientColorsStops` (List<double>): Defines the stops for the gradient colors along the indicator's length.
- `width` (double): The width of the indicator widget.
- `height` (double): The height of the indicator widget.
- `onSelectedNumber` (Function(int)): Callback function triggered when a number is selected via tapping or dragging.

Optional Parameters:
- `marker` (List<int>): A list of marker points to highlight specific values on the indicator. Default is an empty list.
- `labelTextColor` (Color): The color of the labels displayed on the indicator. Default is FancyIndicatorUtils.whiteColor.
- `selectedTextColor` (Color): The color of the selected label text. Default is FancyIndicatorUtils.blueColor.
- `measureItemColor` (Color): The color of the measurement items. Default is FancyIndicatorUtils.yellowColor.
- `backgroundColor` (Color): The background color of the indicator widget. Default is FancyIndicatorUtils.primaryColor.
- `numberAppendix` (String): A string appended to the selected number, e.g., %. Default is "%".
- `draggableButtonColor` (Color): The color of the draggable button. Default is FancyIndicatorUtils.whiteColor.
- `draggableButtonIconsColor` (Color): The color of the icons on the draggable button. Default is FancyIndicatorUtils.triangleColor.
- `draggableButtonCircleColor` (Color): The color of the circle around the draggable button. Default is FancyIndicatorUtils.greyDarkerColor.
- `draggableButtonCircleAnimateColor` (Color): The animated color of the draggable button circle. Default is FancyIndicatorUtils.greyColor.
- `labelTextSize` (double): The size of the label text. Default is 20.0.
- `selectedTextSize` (double): The size of the selected label text. Default is 30.0.

## How it Works

Interactions

The FancyIndicator widget supports the following interactions:

- Tapping: Select a value by tapping on the indicator.
- Dragging: Drag the draggable button to select a value.
- Animations: Smooth animations are triggered when interacting with the indicator, enhancing the user experience.

Callbacks

The `onSelectedNumber` callback provides the selected value, enabling you to capture user input and respond accordingly in your application

## Conclusion
The FancyIndicator widget is a powerful and customizable tool for building interactive and visually appealing indicators in Flutter applications. Its wide range of properties allows you to customize the look and feel to match your specific requirements.

