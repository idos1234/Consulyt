import 'package:consulyt_connection_between_business_and_consultants/pages/signin/authService.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home(
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await Authservice().signOut();
      },
      child: const Text('Sign out')
    );
  }

}