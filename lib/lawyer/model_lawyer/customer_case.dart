

class CustomerCaseDTO{
  int id;
  String name;
  String description;

  CustomerCaseDTO({required this.id, required this.name, required this.description});

  factory CustomerCaseDTO.fromJson(Map<String, dynamic> json) {
    return CustomerCaseDTO(
      id : json['id'],
      name : json['name'] ?? "",
      description : json['description'] ?? ""
    );
    
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }



}