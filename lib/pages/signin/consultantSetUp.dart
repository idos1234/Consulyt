import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consulyt_connection_between_business_and_consultants/data/users.dart';
import 'package:consulyt_connection_between_business_and_consultants/pages/signin/businessSetUp.dart';
import 'package:consulyt_connection_between_business_and_consultants/theme/Fonts.dart';
import 'package:flutter/material.dart';

class ConsultantSetUp extends StatefulWidget{
  ThemeData themeData;
  Fonts fonts;

  ConsultantSetUp(
    {
      super.key,
      required this.fonts,
      required this.themeData
    }
  );

  @override
  State<ConsultantSetUp> createState() => _ConsultantSetUpState();
}

class _ConsultantSetUpState extends State<ConsultantSetUp> {
  late List<int> unansweredQuestions;

  //Q1
  TextEditingController name = TextEditingController();

  //Q2
  final List<String> industries = <String>[
    'Technology',
    'Healthcare', 
    'Finance', 
    'Retail', 
    'Manufacturing', 
    'Hospitality', 
    'Real estate', 
    'Education', 
    'Marketing & Advertising', 
    'Logistics & Transportation', 
    'Other'
  ];
  String? industry;

  //Q3
  final List<String> yearsOfExperience = <String>[
    'Less than 1 year',
    '1-3 years',
    '3-5 years',
    '5+ years'
  ];
  String? years;

  //Q4
  TextEditingController qualificationsOrCertifications = TextEditingController();

  //Q5
  TextEditingController rates = TextEditingController();

  //Q6
  TextEditingController specializations = TextEditingController();

  //Q7
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();
  late final List<TextFieldLocation> locations;

  //Q8
  TextEditingController availability = TextEditingController();

  @override
  void initState() {
    super.initState();
    unansweredQuestions = List.of([1,2,3,5,6,7,8]);

    //Q2
    industry = '';

    //Q7
    locations = <TextFieldLocation>[
      TextFieldLocation(controller: city, label: 'City'),
      TextFieldLocation(controller: state, label: 'State(optional)'),
      TextFieldLocation(controller: country, label: 'Country'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var db = FirebaseFirestore.instance.collection('Consultants');

    return Scaffold(
      backgroundColor: widget.themeData.colorScheme.surface,
      body: ListView(
        padding: EdgeInsets.fromLTRB(width/10, 0, width/10, 0),
        children: [
          SizedBox(height: height/10),
      
          Text(
            'Set up',
            style: widget.fonts.display!.copyWith(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: height/7.5),
          
          //What is your name?
          Text(
            '1. What is your name?',
            style: widget.fonts.title!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          TextField(
            onChanged: (value) {
              if(name.text != '') {
                setState(() {
                  unansweredQuestions.remove(1);
                });
                
              } else {
                setState(() {
                  unansweredQuestions.add(1);
                });
              }
              unansweredQuestions.sort();
            },
            controller: name,
            cursorColor: widget.themeData.colorScheme.secondary,  
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),
                      ),  
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),   
                   ),
            ),
          ),

          SizedBox(height: height/20),

          //What are your areas of expertise?
          Text(
            '2. What are your areas of expertise?',
            style: widget.fonts.title!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          DropdownMenu<String>(
            onSelected: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                industry = value;
                if(value != '') {
                  setState(() {
                    unansweredQuestions.remove(2);
                  });
                }
              });
            },
            dropdownMenuEntries: industries.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),

          SizedBox(height: height/20),

          //How many years of experience do you have in consultancy?
          Text(
            '3. How many years of experience do you have in consultancy?',
            style: widget.fonts.title!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          DropdownMenu<String>(
            onSelected: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                years = value;
                if(value != '') {
                  setState(() {
                    unansweredQuestions.remove(3);
                  });
                }
              });
            },
            dropdownMenuEntries: yearsOfExperience.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),

          SizedBox(height: height/20),

          //Do you have any relevant qualifications or certifications?
          Text(
            '4. Do you have any relevant qualifications or certifications? (Optional)',
            style: widget.fonts.title!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          TextField(
            controller: qualificationsOrCertifications,
            cursorColor: widget.themeData.colorScheme.secondary,  
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            minLines: 1,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),
                      ),  
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),   
                   ),
            ),
          ),

          SizedBox(height: height/20),

          //What are your rates for consultancy services? (e.g., Hourly rate, Project-based pricing)
          Text(
            '5. What are your rates for consultancy services? (e.g., Hourly rate, Project-based pricing)',
            style: widget.fonts.title!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          TextField(
            onChanged: (value) {
              if(rates.text != '') {
                setState(() {
                  unansweredQuestions.remove(5);
                });
                
              } else {
                setState(() {
                  unansweredQuestions.add(5);
                });
              }
              unansweredQuestions.sort();
            },
            controller: rates,
            cursorColor: widget.themeData.colorScheme.secondary,  
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            minLines: 1,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),
                      ),  
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),   
                   ),
            ),
          ),

          SizedBox(height: height/20),

          //Do you have any specializations or niches within your areas of expertise?
          Text(
            '6. Do you have any specializations or niches within your areas of expertise?',
            style: widget.fonts.title!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          TextField(
            onChanged: (value) {
              if(specializations.text != '') {
                setState(() {
                  unansweredQuestions.remove(6);
                });
                
              } else {
                setState(() {
                  unansweredQuestions.add(6);
                });
              }
              unansweredQuestions.sort();
            },
            controller: specializations,
            cursorColor: widget.themeData.colorScheme.secondary,  
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            minLines: 1,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),
                      ),  
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),   
                   ),
            ),
          ),

          SizedBox(height: height/20),

          //Where is your business located?
          Text(
            '7. Where is your business located?',
            style: widget.fonts.title!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          for(var location in locations) TextField(
            onChanged: (value) {
              if(locations[0].controller.text != '' && locations[2].controller.text != '') {
                setState(() {
                  unansweredQuestions.remove(7);
                });
                
              } else {
                if(!unansweredQuestions.contains(7)) {
                  setState(() {
                    unansweredQuestions.add(7);
                  });
                }
              }
              unansweredQuestions.sort();
            },
            controller: location.controller,
            cursorColor: widget.themeData.colorScheme.secondary,  
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),
                      ),  
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),   
                  ),
              labelText: location.label,
              labelStyle: TextStyle(color: widget.themeData.colorScheme.secondary)
            ),
          ),

          SizedBox(height: height/20),

          //What is your general availability for consultations? (e.g., Weekdays, Weekends, Specific hours)
          Text(
            '8. What is your general availability for consultations? (e.g., Weekdays, Weekends, Specific hours)',
            style: widget.fonts.title!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          TextField(
            onChanged: (value) {
              if(availability.text != '') {
                setState(() {
                  unansweredQuestions.remove(8);
                });
                
              } else {
                setState(() {
                  unansweredQuestions.add(8);
                });
              }
              unansweredQuestions.sort();
            },
            controller: availability,
            cursorColor: widget.themeData.colorScheme.secondary,  
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            minLines: 1,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),
                      ),  
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),   
                   ),
            ),
          ),

          
          SizedBox(height: height/10),

          FilledButton(
            onPressed: () {
              if(unansweredQuestions.isNotEmpty) {} else {
                final consultant = Consultant(
                  name: name.text, 
                  industry: industry!, 
                  yearsOfExperience: years!,
                  qualificationsOrCertifications: qualificationsOrCertifications.text,
                  rates: rates.text,
                  specializations: specializations.text,
                  location: Location(city: city.text, state: state.text, country: country.text),
                  availability: availability.text
                );

                db.add(consultant.toJson());
              }
            },
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(unansweredQuestions.isEmpty ? widget.themeData.colorScheme.primary : Colors.grey),
            ),
            child: Text(
              'Continue',
              style: widget.fonts.body,
            )
          ),
          Text(
            unansweredQuestions.isNotEmpty ? 'Unanswered questions: ${unansweredQuestions.join(", ")}' : '',
            style: widget.fonts.title!.copyWith(fontWeight: FontWeight.bold, color: widget.themeData.colorScheme.error),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
