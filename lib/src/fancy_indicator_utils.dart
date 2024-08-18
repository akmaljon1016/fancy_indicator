import 'dart:ui';

class FancyIndicatorUtils {
  ///Colors
  static const primaryColor = Color(0xFF07082A);
  static const lightGrayColor = Color(0xFF4A506B);
  static const whiteColor = Color(0xFFFFFFFF);
  static const blueColor = Color(0xFF02B3E2);
  static const yellowColor = Color(0xFFFFD701);
  static const greyDarkerColor = Color(0xFF797F93);
  static const greyColor = Color(0xFFD2D6DC);
  static const waveColor = Color(0xFF05092A);
  static const triangleColor = Color(0xFF43516C);

  /// Generates and lays out a paragraph with the given text and style.
  ///
  /// This method creates a `Paragraph` object using the provided [text] and
  /// [style]. It uses a `ParagraphBuilder` to apply the text style and add the
  /// text to the paragraph. The resulting `Paragraph` is then laid out with
  /// an infinite width constraint.
  ///
  /// - [text]: The string to be displayed in the paragraph.
  /// - [style]: The `TextStyle` to apply to the text.
  ///
  /// Returns a `Paragraph` object with the specified text and style,
  /// laid out to fit within an infinite width constraint.
  static Paragraph generateParagraph(
    String text, {
    required TextStyle style,
  }) {
    final paragraph = ParagraphBuilder(ParagraphStyle());
    paragraph.pushStyle(style);
    paragraph.addText(text);
    return paragraph.build()
      ..layout(ParagraphConstraints(width: Size.infinite.width));
  }


  /// Returns a value that is constrained within the specified range.
  ///
  /// This method takes a [value] and ensures that it falls within the range
  /// defined by [min] and [max]. If the [value] is within this range, it is
  /// returned as-is. If the [value] is less than [min], [min] is returned.
  /// If the [value] is greater than [max], [max] is returned.
  ///
  /// - [value]: The value to be constrained.
  /// - [min]: The minimum boundary of the range.
  /// - [max]: The maximum boundary of the range.
  static double valueBetween(double value, double min, double max) {
    double result = 0;
    if (value >= min && value <= max) {
      result = value;
    } else if (value < min) {
      result = min;
    } else if (value > max) {
      result = max;
    }
    return result;
  }
}
