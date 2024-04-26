class AttachFilesModel {
  String id;
  String photoUrl;
  String audioUrl;
  String videoUrl;
  String description;

  AttachFilesModel({
    required this.id,
    required this.photoUrl,
    required this.audioUrl,
    required this.videoUrl,
    required this.description,
  });

  factory AttachFilesModel.fromJson(Map<String, dynamic> json) {
    return AttachFilesModel(
      id: json['_id'],
      photoUrl: json['photoUrl'],
      audioUrl: json['audioUrl'],
      videoUrl: json['videoUrl'],
      description: json['description'],
    );
  }
}
