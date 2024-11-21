import 'package:flutter_new_template/export.dart';

const kRoundedAll = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(
    Radius.circular(33.0),
  ),
);

final OutlineInputBorder kBorder = OutlineInputBorder(
  borderSide: const BorderSide(
    color: Colors.transparent,
  ),
  borderRadius: BorderRadius.circular(16),
);

final darkTheme = ThemeData(
  primaryColor: kPrimaryColor,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme().copyWith(color: kPrimaryColor),
  dividerColor: Colors.black12,
  fontFamily: 'Cairo',
  colorScheme: ColorScheme.fromSwatch(
          primarySwatch: kPrimaryColor, brightness: Brightness.dark)
      .copyWith(secondary: Colors.white)
      .copyWith(background: kDark),
);
