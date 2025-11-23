class CourseModel {
  final String id;
  final String title;
  final String description;
  final String longDescription;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.longDescription,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: (json['id'] ?? '').toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      longDescription: json['long_description'] ?? '',
    );
  }
}
