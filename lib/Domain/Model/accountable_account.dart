import 'package:json_annotation/json_annotation.dart';

part 'accountable_account.g.dart';

@JsonSerializable()
class AccountableAccount {
  String accountableAccountId;
  String appUserId;

  AccountableAccount({
    required this.accountableAccountId,
    required this.appUserId,
  });

  factory AccountableAccount.fromJson(Map<String, dynamic> json) =>
      _$AccountableAccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountableAccountToJson(this);
}
