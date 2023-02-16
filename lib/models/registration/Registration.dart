import 'package:smart_admin_dashboard/models/registration/Director.dart';
import 'package:smart_admin_dashboard/models/registration/Secretary.dart';

class Registration {
  String? companyName;
  String? directorName;
  String? directorLastName;
  String? director1;
  String? director1_street;
  String? director1_city;
  String? director1_country;
  // al List<Director> directors;
  // al List<Secretary> secretaries;


  Registration(
        this.companyName,
        this.directorName,
        this.director1,
        this.director1_street,
        this.director1_city,
        this.director1_country,
        // this.directors,
        // this.secretaries,
      this.directorLastName,
      );

 Registration.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    directorName = json['directorName'];
    director1 = json['director1'];
    director1_street = json['director1_street'];
    director1_city = json['director1_city'];
    director1_country = json['director1_country'];
    directorLastName = json['directorLastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyName'] = this.companyName;
    data['directorName'] = this.directorName;
    data['director1'] = this.director1;
    data['director1_street'] = this.director1_street;
    data['director1_city'] = this.director1_city;
    data['director1_country'] = this.director1_country;
    data['directorLastName'] = this.directorLastName;
    return data;
  }
}



