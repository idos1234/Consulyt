import 'package:consulyt_connection_between_business_and_consultants/pages/signin/authService.dart';
import 'package:consulyt_connection_between_business_and_consultants/theme/Fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  ThemeData themeData;
  Fonts fonts;
  
  SignInScreen( 
    {
      super.key,
      required this.fonts,
      required this.themeData,
    }
  );

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  void signUserIn() async {
    showDialog(context: context, builder: (context) {
      return Center(
        child: CircularProgressIndicator()
      );
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        var snackBar = SnackBar(content: Text('No user found for that email.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'wrong-password') {
        var snackBar = SnackBar(content: Text('Wrong password provided for that user.\nTry changing your password or sign in with google.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: widget.themeData.colorScheme.surface,
      body: Center(
        child: ListView(
          padding: EdgeInsets.fromLTRB(width/10, 0, width/10, 0),
          children: [
            SizedBox(height: height/10),

            Text('Welcome back!', style: widget.fonts.head, textAlign: TextAlign.center,),
            
            SizedBox(height: height/7.5),

            //email and password
            for(var i in [0,1])
            Column(
              children: [
                if(i == 1) SizedBox(height: height/50),
                TextField(
                  maxLines: 1,
                  minLines: 1,
                  textInputAction: i == 0 ? TextInputAction.next : TextInputAction.done,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),
                    ),
                    hintText: i == 0 ? 'Email' : 'Password',
                    hintStyle: widget.fonts.lable
                  ),
                  controller: i == 0 ? email : password
                  ),
              ],
            ),

            SizedBox(height: height/100),

            //forgot password
            Text(
              'Forgot password?',
              style: widget.fonts.lable,
              textAlign: TextAlign.right,
            ),

            SizedBox(height: height/25),

            //sign in button
            FilledButton(
              onPressed: () => signUserIn(),
              style: FilledButton.styleFrom(
                minimumSize: Size(width*8/10, height/15),
                backgroundColor: widget.themeData.colorScheme.primary,
              ),
              child: Text(
                'Sign in',
                style: widget.fonts.title!.copyWith(fontWeight: FontWeight.bold),
              )
            ),
            
            SizedBox(height: height/20),

            //continue with
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: height/20),

            //google sign in buttom
            GoogleSignInButton(fonts: widget.fonts)
          ],
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  Fonts fonts;

  GoogleSignInButton(
    {
      super.key,
      required this.fonts,
    }
  );

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;


    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 10
      ),
      onPressed: () async {
        await Authservice().signInWithGoogle();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: height/15,
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