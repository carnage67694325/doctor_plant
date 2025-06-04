class FeedbackModel {
  String? appUser;
  dynamic plantImage;
  String? description;

  FeedbackModel({this.appUser, this.plantImage, this.description});

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        appUser: json['appUser'] as String?,
        plantImage: json['plantImage'] as dynamic,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'appUser': appUser,
        'plantImage': plantImage,
        'description': description,
      };
}
