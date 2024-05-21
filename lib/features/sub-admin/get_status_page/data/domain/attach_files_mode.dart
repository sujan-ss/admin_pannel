class AttachFilesModel {
  String id;
  String photoUrl;
  String audioUrl;
  String videoUrl;
  String description;
  String status = "pending";

  AttachFilesModel(
      {required this.id,
      required this.photoUrl,
      required this.audioUrl,
      required this.videoUrl,
      required this.description,
      required this.status});

  factory AttachFilesModel.fromJson(Map<String, dynamic> json) {
    return AttachFilesModel(
      id: json['_id'],
      photoUrl: json['photoUrl'],
      audioUrl: json['audioUrl'],
      videoUrl: json['videoUrl'],
      description: json['description'],
      status: json['status'],
    );
  }

  //create Copywith method
  AttachFilesModel copyWith({
    String? id,
    String? photoUrl,
    String? audioUrl,
    String? videoUrl,
    String? description,
    String? status,
  }) {
    return AttachFilesModel(
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }
}
