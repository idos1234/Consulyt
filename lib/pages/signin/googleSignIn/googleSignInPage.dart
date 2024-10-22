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
            GoogleSignInButton(fonts: fonts, onPressed: onPressed)
          ],
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  Fonts fonts;
  Function onPressed;

  GoogleSignInButton(
    {
      super.key,
      required this.fonts,
      required this.onPressed
    }
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return ElevatedButton(
              onPressed: () async {
                await GoogleSignInService().signInWithGoogle();
                onPressed();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: width/5,
                    child: Image.network(
                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                        fit:BoxFit.cover
                    )               
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Sign-in with Google',
                    style: fonts.title,
                    )
                ],
              )
            );
  }

}