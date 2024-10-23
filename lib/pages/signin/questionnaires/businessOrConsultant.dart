import 'package:consulyt_connection_between_business_and_consultants/theme/Fonts.dart';
import 'package:flutter/material.dart';

class BusinessOrConsultant extends StatefulWidget {
  ThemeData themeData;
  Fonts fonts;

  BusinessOrConsultant(
    {
      super.key,
      required this.fonts,
      required this.themeData
    }
  );

  @override
  State<BusinessOrConsultant> createState() => _BusinessOrConsultantState(
    themeData: themeData,
    fonts: fonts
  );
}

class _BusinessOrConsultantState extends State<BusinessOrConsultant> {
  ThemeData themeData;
  Fonts fonts;

  _BusinessOrConsultantState(
    {
      required this.fonts,
      required this.themeData
    }
  );


  late int role;

  @override
  void initState() {
    super.initState();
    setRole(0);
  }
  void setRole(int number) {
    setState(() {
      role = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: widget.themeData.colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 0,),

          Text(
            'What is your primary role?',
            style: widget.fonts.head!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyCard(
                fonts: widget.fonts,
                text: "Business",
                icon: Icons.business,
                borderColor: role == 1 ? themeData.colorScheme.primary : Colors.grey,
                setRole: () => setRole(1),
              ),
              SizedBox(width: width/10),
              MyCard(
                fonts: widget.fonts,
                text: "Consultant ",
                icon: Icons.face,
                borderColor: role == 2 ? themeData.colorScheme.primary : Colors.grey,
                setRole: () => setRole(2),
              )
            ],
          ),

          FilledButton(
            onPressed: () {
              if(role == 0) {} else {
                //navigate
              }
            },
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(role != 0 ? themeData.colorScheme.primary : Colors.grey),
            ),
            child: Text(
              'Continue',
              style: fonts.body,
            )
          ),
          const SizedBox(height: 0,)
        ],
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  String text;
  Fonts fonts;
  IconData icon;
  Color borderColor;
  Function setRole;

  MyCard(
    {
      super.key,
      required this.fonts,
      required this.text,
      required this.icon,
      required this.borderColor,
      required this.setRole
    }
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector (
      onTap: () => setRole(),
      child: SizedBox(
        width: width/3,
        height: width/3,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: borderColor,
              width: width/150,
            )
          ),
          elevation: 15,
          child: Center(
            child: Column(
              children: [
                Icon(
                  icon,
                  size: width/4,
                ),
                Text(
                  text,
                  style: fonts.body
                )
              ],
            ),
          ),
        ),
      )
    );
  }
  
}