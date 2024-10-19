import 'dart:ffi';

class BusinessOwner {
    String businessName;
    String industry;
    String businessSize;
    Location location;
    String challenges;
    String requiredConsultancy;
    BudgetRange budgetRange;

    BusinessOwner(
    {
      required this.businessName,
      required this.industry,
      required this.businessSize,
      required this.location,
      required this.challenges,
      required this.requiredConsultancy,
      required this.budgetRange,
    }
  );

  Map<String, dynamic> toJson() => {
        'businessName': businessName,
        'industry': industry,
        'businessSize': businessSize,
        'location': location.toJson(),
        'challenges': challenges,
        'requiredConsultancy': requiredConsultancy,
        'budgetRange': budgetRange.toJson()
      };
}

class Consultant {
  String name;
  String industry;
  String yearsOfExperience;
  String qualificationsOrCertifications;
  String rates;
  List<Float> rating = List.empty(growable: true);
  String specializations;
  Location location;
  //in what days the consultant is available
  String availability;

  Consultant(
    {
      required this.name,
      required this.industry,
      required this.yearsOfExperience,
      required this.qualificationsOrCertifications,
      required this.rates,
      required this.specializations,
      required this.location,
      required this.availability
    }
  );

  Map<String, dynamic> toJson() => {
        'name': name,
        'industry': industry,
        'yearsOfExperience': yearsOfExperience,
        'qualificationsOrCertifications': qualificationsOrCertifications,
        'rates': rates,
        'rating': rating,
        'specializations': specializations,
        'location': location.toJson(),
        'availability': availability
      };

}

class Location{
    String city;
    String state;
    String country;

    Location(
      {
        required this.city,
        required this.state,
        required this.country,
      }
    );

    Map<String, dynamic> toJson() => {
      'city': city,
      'state': state,
      'country': country
    };

}

class BudgetRange {
    int min;
    int max;

    BudgetRange(
      {
        required this.min,
        required this.max
      }
    );

    Map<String, dynamic> toJson() => {
      'min': min,
      'max': max
    };
}