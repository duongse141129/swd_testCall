class DocumentDTO {
  int id;
  String name;
  String description;
  int categoryId;

  DocumentDTO({
    required this.id, 
    required this.name, 
    required this.description, 
    required this.categoryId});

  factory DocumentDTO.fromJson(Map<String, dynamic> json) {
    return DocumentDTO(
      id : json['id'],
      name : json['name'],
      description : json['description'],
      categoryId : json['category_id'],
    );
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    return data;
  }
}
