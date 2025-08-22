class DjModel {
  final String id;
  final String? description;
  final String name;

  DjModel({
    required this.id,
    required this.description,
    required this.name,
  });

  factory DjModel.fromJson(Map<String, dynamic> json) {
    return DjModel(
      id: json['id'].toString(),
      description: json['description'],
      name: json['user']['name'], // جلب اسم الـ DJ من داخل user
    );
  }

  static List<DjModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => DjModel.fromJson(json)).toList();
  }
}
