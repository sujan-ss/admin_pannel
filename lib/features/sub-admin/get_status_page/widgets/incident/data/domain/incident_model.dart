import 'package:admin_panel/data/models/user_model.dart';

class IncidentModel {
  String id;
  String lat;
  String long;
  String description;
  String locationName;
  UserModel userModel;
  String status;
  String police;

  IncidentModel({
    required this.id,
    required this.lat,
    required this.long,
    required this.description,
    required this.locationName,
    required this.userModel,
    this.status = "pending",
    required this.police,
  });

  //generate copyWith method

  IncidentModel copyWith({
    String? id,
    String? lat,
    String? long,
    String? description,
    String? locationName,
    UserModel? userModel,
    String? status,
  }) {
    return IncidentModel(
        id: id ?? this.id,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        description: description ?? this.description,
        locationName: locationName ?? this.locationName,
        userModel: userModel ?? this.userModel,
        status: status ?? this.status,
        police: police);
  }

  factory IncidentModel.fromJson(Map<String, dynamic> json) {
    return IncidentModel(
      id: json['_id'],
      lat: json['lat'],
      long: json['long'],
      description: json['description'],
      locationName: json['locationName'],
      userModel: UserModel.fromJson(json['user']),
      status: json['status'],
      police: json['police'] ?? "none",
    );
  }
}
