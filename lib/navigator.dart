import 'package:consulyt_connection_between_business_and_consultants/pages/home.dart';
import 'package:consulyt_connection_between_business_and_consultants/pages/signIn/googleSignIn/googleSignInPage.dart';
import 'package:consulyt_connection_between_business_and_consultants/pages/signin/googleSignIn/googleSignInService.dart';
import 'package:consulyt_connection_between_business_and_consultants/theme/Fonts.dart';
import 'package:consulyt_connection_between_business_and_consultants/theme/color.dart';
import 'package:consulyt_connection_between_business_and_consultants/theme/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  
  @override
  void initState() {
    super.initState();

    user = GoogleSignInService().getUser();
  }

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = createTextTheme(context, "Roboto", "Open Sans");
    MaterialTheme theme = MaterialTheme(textTheme);
    ThemeData themeData = theme.light();

    double width = MediaQuery.of(context).size.width;
    Fonts fonts = Fonts();

    if(width < 600) {
      fonts.body = textTheme.bodySmall;
      fonts.display = textTheme.displaySmall;
      fonts.head = textTheme.headlineSmall;
      fonts.lable = textTheme.labelSmall;
      fonts.title = textTheme.titleSmall;
    } else if(width < 840) {
      fonts.body = textTheme.bodyMedium;
      fonts.display = textTheme.displayMedium;
      fonts.head = textTheme.headlineMedium;
      fonts.lable = textTheme.labelMedium;
      fonts.title = textTheme.titleMedium;
    } else {
      fonts.body = textTheme.bodyLarge;
      fonts.display = textTheme.displayLarge;
      fonts.head = textTheme.headlineLarge;
      fonts.lable = textTheme.labelLarge;
      fonts.title = textTheme.titleLarge;
    }
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Consulyt",
      theme: themeData,
      home: GoogleSignInService().getUser() == null? GoogleSignInScreen(
        fonts: fonts,
        themeData: themeData,
        onPressed: () {
          setState(() {
            user = GoogleSignInService().getUser();
          });
        }
      )
      : Home(
        onPressed: () {
          setState(() {
            user = GoogleSignInService().getUser();
          });
        }
      )
    );
  }
}