import 'package:flutter/material.dart';
import 'package:info_bank/src/LoginPage.dart';
import 'package:info_bank/src/constants/text_Strings.dart';
import 'package:info_bank/src/utils/theme/theme.dart';
import 'package:info_bank/src/screen/user_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InfoBank',
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: UserScreen(),
    );
  }
}
