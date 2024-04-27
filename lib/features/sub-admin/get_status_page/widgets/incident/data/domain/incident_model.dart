import 'package:admin_panel/data/models/user_model.dart';

class IncidentModel {
  String id;
  String lat;
  String long;
  String description;
  String locationName;
  UserModel userModel;

  IncidentModel({
    required this.id,
    required this.lat,
    required this.long,
    required this.description,
    required this.locationName,
    required this.userModel,
  });

  factory IncidentModel.fromJson(Map<String, dynamic> json) {
    return IncidentModel(
      id: json['_id'],
      lat: json['lat'],
      long: json['long'],
      description: json['description'],
      locationName: json['locationName'],
      userModel: UserModel.fromJson(json['user']),
    );
  }
}
