class PackageModel {
  final String title;
  final String datePosted;

  PackageModel({
    required this.title,
    required this.datePosted,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      title: json['title'],
      datePosted: json['datePosted'],
    );
  }
}
