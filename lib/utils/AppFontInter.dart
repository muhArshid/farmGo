// import 'package:flutter/cupertino.dart';

// class AppFontInter extends TextStyle {
//   final bool inherit;
//   final Color? color;
//   final Color ?backgroundColor;
//   final String ?fontFamily;
//   List<String> get fontFamilyFallback =>
//       _package != null && _fontFamilyFallback != null
//           ? _fontFamilyFallback
//               .map((String str) => 'packages/$_package/$str')
//               .toList()
//           : _fontFamilyFallback;
//   final List<String> _fontFamilyFallback;
//   final String _package;
//   final double? fontSize;
//   final FontWeight ?fontWeight;
//   final FontStyle ?fontStyle;
//   final double ?letterSpacing;
//   final double? wordSpacing;
//   final TextBaseline? textBaseline;
//   final double ?height;
//   final Locale ?locale;
//   final Paint ?foreground;
//   final Paint? background;
//   final TextDecoration? decoration;
//   final Color ?decorationColor;
//   final TextDecorationStyle? decorationStyle;
//   final double ?decorationThickness;
//   final String ?debugLabel;

//   AppFontInter({
//     this.inherit = true,
//     this.color,
//     this.backgroundColor,
//     this.fontSize,
//     this.fontWeight,
//     this.fontStyle,
//     this.letterSpacing,
//     this.wordSpacing,
//     this.textBaseline,
//     this.height,
//     this.locale,
//     this.foreground,
//     this.background,
//     this.decoration,
//     this.decorationColor,
//     this.decorationStyle,
//     this.decorationThickness,
//     this.debugLabel,
//     String ?fontFamily,
//     List<String> fontFamilyFallback,
//     String ?package,
//   })  : fontFamily =
//             'Inter' /*package == null ? fontFamily : 'packages/$package/$fontFamily'*/,
//         _fontFamilyFallback = fontFamilyFallback,
//         _package = package,
//         assert(inherit != null),
//         assert(
//           color == null || foreground == null,
//         ),
//         assert(
//           backgroundColor == null || background == null,
//         );
// }
