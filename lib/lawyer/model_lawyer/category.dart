class CategoryDTO {
  final int id;
  final String categoryName;

  CategoryDTO({required this.id, required this.categoryName});

  factory CategoryDTO.fromJson(Map<String, dynamic> json) {
    return CategoryDTO(
      id : json['id'],
      categoryName :json['category_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    return data;
  }
}