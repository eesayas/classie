import '../exports.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

//Color declarations according to planned UI
Color purpleColor = HexColor('9247F3');
Color purpleColorEnd = HexColor('D1B1FA');
Color logoWhite = HexColor('EEEDFA');
Color mildWhite = HexColor('D4BDE7');
Color buttonPurple = HexColor('5027B3');
Color textPurple = HexColor('6231C4');
Color hintPurple = HexColor('7F62C8');