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

final lightTheme = ThemeData(
  primaryColor: kPrimaryColor,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme().copyWith(color: kPrimaryColor),
  dividerColor: Colors.white54,
  textTheme: Typography.blackCupertino.copyWith(
    titleLarge: TextStyle(
        color: kGreyColor, fontSize: 18.sp, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(color: kTextGreyColor, fontSize: 14.sp),
    titleSmall: TextStyle(color: kTextGreyColor, fontSize: 12.sp),
    bodySmall: TextStyle(color: kBlack, fontSize: 11.sp),
    labelSmall: TextStyle(
      color: kGreyShade.shade500,
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      color: kGreyShade.shade900,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),
  ),
  fontFamily: 'Cairo',
  colorScheme: ColorScheme.fromSwatch(primarySwatch: kPrimaryColor)
      .copyWith(secondary: kPrimaryColor)
      .copyWith(background: kBGGreyColor),
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
      .copyWith(background: const Color(0xFF212121)),
);
