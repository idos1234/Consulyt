import 'package:consulyt_connection_between_business_and_consultants/pages/signIn/googleSignIn/googleSignInService.dart';
import 'package:consulyt_connection_between_business_and_consultants/theme/Fonts.dart';
import 'package:flutter/material.dart';

class GoogleSignInScreen extends StatelessWidget {
  ThemeData themeData;
  Fonts fonts;
  Function onPressed;
  
  GoogleSignInScreen( 
    {
      super.key,
      required this.fonts,
      required this.themeData,
      required this.onPressed
    }
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData.colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //google sign in button
            ElevatedButton(
              onPressed: () async {
                await GoogleSignInService().signInWithGoogle();
                onPressed();
              },
               child: Text('Google sign in', style: fonts.title!.copyWith(fontWeight: FontWeight.w600),)
            )
          ],
        ),
      ),
    );
  }

}