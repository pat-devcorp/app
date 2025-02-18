// client_model.dart
import 'dart:convert';

List<ClientModel> welcomeFromJson(String str) =>
    List<ClientModel>.from(json.decode(str).map((x) => ClientModel.fromJson(x)));

String welcomeToJson(List<ClientModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClientModel {
  int ? id;
  String name;
  String email;
  String lastname;

  ClientModel({
    this.id,
    required this.name,
    required this.email,
    required this.lastname,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        lastname: json["lastname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "lastname": lastname,
      };
}
