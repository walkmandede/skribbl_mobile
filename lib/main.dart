import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skribbl/modules/greeting/v_greeting_page.dart';
import 'constants/app_colors.dart';
import 'constants/app_constants.dart';
import 'others/flutter_super_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Future.delayed(const Duration(seconds: 1));
  runApp(const MyApp());
  // runApp(const RestartAppWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // key: GlobalKey(),
      debugShowCheckedModeBanner: false,
      title: 'App Studio',
      navigatorObservers: [routeObserver],
      locale: const Locale('mm', 'MM'),
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        primarySwatch: MaterialColor(AppColors.black.value, const {
          050: Color.fromRGBO(29, 44, 77, .1),
          100: Color.fromRGBO(29, 44, 77, .2),
          200: Color.fromRGBO(29, 44, 77, .3),
          300: Color.fromRGBO(29, 44, 77, .4),
          400: Color.fromRGBO(29, 44, 77, .5),
          500: Color.fromRGBO(29, 44, 77, .6),
          600: Color.fromRGBO(29, 44, 77, .7),
          700: Color.fromRGBO(29, 44, 77, .8),
          800: Color.fromRGBO(29, 44, 77, .9),
          900: Color.fromRGBO(29, 44, 77, 1),
        }),
        datePickerTheme: DatePickerThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          headerBackgroundColor: AppColors.bgHardGrey,
          backgroundColor: AppColors.bgSoftGrey,
          dayStyle: TextStyle(color: AppColors.grey),
        ),
        fontFamily: 'Nunito',
        fontFamilyFallback: const ['Book'],
        textTheme: TextTheme(
          bodyMedium: AppConstants.defaultTextStyle,
          titleMedium: AppConstants.defaultTextStyle,
          labelLarge: AppConstants.defaultTextStyle,
          bodyLarge: AppConstants.defaultTextStyle,
          bodySmall: AppConstants.defaultTextStyle,
          titleLarge: AppConstants.defaultTextStyle,
          titleSmall: AppConstants.defaultTextStyle,
        ),
        useMaterial3: false,
      ),
      home: const GreetingPage(),
    );
  }
}
