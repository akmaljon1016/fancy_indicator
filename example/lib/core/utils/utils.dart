import 'dart:ui';



class Utils {

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





  ///Functions

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
