import 'dart:ui';

extension ColorParsing on String? {
  Color? toColor() {
    if (this == null) {
      return null;
    }

    String colorString = this!;
    // Remove the "#" symbol if present
    if (colorString.startsWith('#')) {
      colorString = colorString.substring(1);
    }

    // Ensure the color string is in the correct format (6 hex digits)
    if (colorString.length != 6) {
      throw ArgumentError(
          'Invalid color string format. Expected format: #RRGGBB');
    }

    // Parse the color components from the string
    int red = int.parse(colorString.substring(0, 2), radix: 16);
    int green = int.parse(colorString.substring(2, 4), radix: 16);
    int blue = int.parse(colorString.substring(4, 6), radix: 16);

    // Create and return the Color object
    return Color.fromARGB(255, red, green, blue);
  }
}
