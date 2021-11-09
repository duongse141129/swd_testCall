class CustomerDTO{

  int id;
  String name;
  String address;
  String location;
  String phoneNumber;
  String email;
  String sex;
  String dateOfBirth;
  int status;
  String dateOfBirthFormatted;

  CustomerDTO(
      {required this.id,
      required this.name,
      required this.address,
      required this.location,
      required this.phoneNumber,
      required this.email,
      required this.sex,
      required this.dateOfBirth,
      required this.status,
      required this.dateOfBirthFormatted});

  /*factory CustomerDTO.fromJson(Map<String, dynamic> json) {
    return CustomerDTO(
      id : json['id'],
      name : json['name'],
      address : json['address'],
      location :json['location'],
      phoneNumber : json['phone_number'],
      email : json['email'],
      sex : json['sex'],
      dateOfBirth : json['date_of_birth'],
      status : json['status'],
      dateOfBirthFormatted : json['date_of_birth_formatted'],
    );
    
  }*/
  CustomerDTO.fromJson(Map<String, dynamic> json)
    : id = json['id'],
    name = json['name'],
    address = json['address'],
    location = json['location'],
    phoneNumber = json['phone_number'],
    email = json['email'],
    sex = json['sex'],
    dateOfBirth = json['date_of_birth'],
    status = json['status'],
    dateOfBirthFormatted = json['date_of_birth_formatted'];
  
     

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['location'] = this.location;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['sex'] = this.sex;
    data['date_of_birth'] = this.dateOfBirth;
    data['status'] = this.status;
    data['date_of_birth_formatted'] = this.dateOfBirthFormatted;
    return data;
  }
}