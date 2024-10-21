import 'package:consulyt_connection_between_business_and_consultants/pages/signin/googleSignIn/googleSignInService.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Function onPressed;

  Home(
    {
      required this.onPressed,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await GoogleSignInService().signOut();
        onPressed();
      },
      child: const Text('Sign out')
    );
  }

}