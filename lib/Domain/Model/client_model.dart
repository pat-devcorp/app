// client_model.dart
import 'dart:convert';
import 'package:app/Domain/Model/transaction_list_model.dart';

List<ClientModel> clientModelFromJson(String str) =>
    List<ClientModel>.from(json.decode(str).map((x) => ClientModel.fromJson(x)));

String clientModelToJson(List<ClientModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClientModel {
  int? clientId;
  dynamic code;
  String name;
  String? lastname;
  String email;
  List<TransactionList>? transactionList;

  ClientModel({
    this.clientId,
    this.code,
    required this.name,
    this.lastname,
    required this.email,
    this.transactionList,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        clientId: json["clientId"],
        code: json["code"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        transactionList: json["transactionList"] != null
            ? List<TransactionList>.from(
                json["transactionList"].map((x) => TransactionList.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "code": code,
        "name": name,
        "lastname": lastname,
        "email": email,
        "transactionList": transactionList != null
            ? List<dynamic>.from(transactionList!.map((x) => x.toJson()))
            : [],
      };
}
