class Secretary {
  String? name;
  String? lastName;
  String? id;
  String? nationality;
  String? street;
  String? city;
  String? country;
  String? particulars;
  String? incDate;


  Secretary(
      this.name,
      this.lastName,
      this.id,
      this.city,
      this.country,
      this.nationality,
      this.street,
      this.particulars,
      this.incDate
      );

  Secretary.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastName = json['lastName'];
    id = json['id'];
    nationality = json['nationality'];
    street = json['street'];
    city = json['city'];
    country = json['country'];
    particulars = json['particulars'];
    incDate = json['incDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['id'] = this.id;
    data['city'] = this.city;
    data['coutry'] = this.country;
    data['nationality'] = this.nationality;
    data['street'] = this.street;
    data['particulars'] = this.particulars;
    data['incDate'] = this.incDate;
    return data;
  }
}