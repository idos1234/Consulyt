import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consulyt_connection_between_business_and_consultants/data/users.dart';
import 'package:flutter/material.dart';
import '../../theme/Fonts.dart';

class BusinessSetUp extends StatefulWidget {
  ThemeData themeData;
  Fonts fonts;

  BusinessSetUp(
    {
      super.key,
      required this.fonts,
      required this.themeData
    }
  );

  @override
  State<BusinessSetUp> createState() => _BusinessSetUpState();
}
class TextFieldLocation {
  TextEditingController controller;
  String label;

  TextFieldLocation(
    {
      required this.controller,
      required this.label
    }
  );
}
class _BusinessSetUpState extends State<BusinessSetUp> {
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
  final List<String> sizes = <String>[
    'Small (1–10 employees)',
    'Medium (11–50 employees)',
    'Large (51+ employees)'
  ];
  String? size;

  //Q4
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();
  late final List<TextFieldLocation> locations;

  //Q5
  TextEditingController challenges = TextEditingController();

  //Q6
  final List<String> requiredConsultancies  = <String>[
    'Management',
    'Financial', 
    'Marketing', 
    'Human Resources', 
    'IT and Digital Transformation', 
    'Legal', 
    'Operations and Process', 
    'Sales', 
    'Risk Management and Business Continuity', 
    'Sustainability and Environmental', 
    'Other'
  ];
  String? requiredConsultancy;

  //Q7
  TextEditingController min = TextEditingController();
  TextEditingController max = TextEditingController();

  late bool wrongRange;

  late Function onRangeChange;

  @override
  void initState() {
    super.initState();
    unansweredQuestions = List.of([1,2,3,4,5,6,7]);

    //Q2
    industry = '';

    //Q4
    locations = <TextFieldLocation>[
      TextFieldLocation(controller: city, label: 'City'),
      TextFieldLocation(controller: state, label: 'State(optional)'),
      TextFieldLocation(controller: country, label: 'Country'),
    ];

    //Q6
    requiredConsultancy = '';

    //Q7
    wrongRange = false;

    onRangeChange = () {
      if(min.text != '' && max.text != '') {
          if(int.parse(max.text) >= int.parse(min.text)) {
            setState(() {
              unansweredQuestions.remove(7);
              wrongRange = false;
            });
          } else {
            setState(() {
              wrongRange = true;
            });
          }
          
        } else {
          if(!unansweredQuestions.contains(7)) {
            setState(() {
              unansweredQuestions.add(7);
            });
          }
        }
      unansweredQuestions.sort();
    };
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var db = FirebaseFirestore.instance.collection('Business');


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

          //What is the name of your business?
          Text(
            '1. What is the name of your business?',
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

          //Which industry does your business operate in?
          Text(
            '2. Which industry does your business operate in?',
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

          //What is the size of your business?
          Text(
            '3. What is the size of your business?',
            style: widget.fonts.title!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          DropdownMenu<String>(
            onSelected: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                size = value;
                if(value != '') {
                  setState(() {
                    unansweredQuestions.remove(3);
                  });
                }
              });
            },
            dropdownMenuEntries: sizes.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),

          SizedBox(height: height/20),
          
          //Where is your business located?
          Text(
            '4. Where is your business located?',
            style: widget.fonts.title!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          for(var location in locations) TextField(
            onChanged: (value) {
              if(locations[0].controller.text != '' && locations[2].controller.text != '') {
                setState(() {
                  unansweredQuestions.remove(4);
                });
                
              } else {
                if(!unansweredQuestions.contains(4)) {
                  setState(() {
                    unansweredQuestions.add(4);
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

          //What specific challenges are you currently facing in your business?
          Text(
            '5. What specific challenges are you currently facing in your business?',
            style: widget.fonts.title!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          TextField(
            onChanged: (value) {
              if(challenges.text != '') {
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
            controller: challenges,
            cursorColor: widget.themeData.colorScheme.secondary,  
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            minLines: 1,
            maxLines: 2,
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

          //What type of consultancy are you looking for?
          Text(
            '6. What type of consultancy are you looking for?',
            style: widget.fonts.title!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          DropdownMenu<String>(
            onSelected: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                requiredConsultancy = value;
                if(value != '') {
                  setState(() {
                    unansweredQuestions.remove(6);
                  });
                }
              });
            },
            dropdownMenuEntries: industries.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),

          SizedBox(height: height/20),

          //What is your budget range for consultancy services?
          Text(
            '7. What is your budget range for consultancy services?',
            style: widget.fonts.title!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) => onRangeChange(),
                  controller: min,
                  cursorColor: widget.themeData.colorScheme.secondary,  
                  
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(      
                                borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),
                                ),  
                        focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),   
                            ),
                        prefix: const Text(
                                "\$",
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                              ),
                        labelText: 'Min'
                  ),
                ),
              ),
              SizedBox(width: width/10,),
              Expanded(
                child: TextField(
                  onChanged: (value) => onRangeChange(),
                  controller: max,
                  cursorColor: widget.themeData.colorScheme.secondary,  
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(      
                                borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),
                                ),  
                        focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: widget.themeData.colorScheme.secondary),   
                            ),
                        prefix: const Text(
                                "\$",
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                              ),
                        labelText: 'Max'
                  ),
                ),
              ),
            ],
          ),  
          Text(
            wrongRange ? 'Min budget can not be less than max budget' : '' ,
            style: widget.fonts.title!.copyWith(fontWeight: FontWeight.bold, color: widget.themeData.colorScheme.error),
            textAlign: TextAlign.left,
          ),

          SizedBox(height: height/10),

          FilledButton(
            onPressed: () {
              if(unansweredQuestions.isNotEmpty) {} else {
                final owner = BusinessOwner(
                  businessName: name.text, 
                  industry: industry!, 
                  businessSize: size!, 
                  location: Location(city: city.text, state: state.text, country: country.text), 
                  challenges: challenges.text, 
                  requiredConsultancy: requiredConsultancy!, 
                  budgetRange: BudgetRange(min: int.parse(min.text), max: int.parse(max.text))
                );

                final j = owner.toJson();
                db.add(j);
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