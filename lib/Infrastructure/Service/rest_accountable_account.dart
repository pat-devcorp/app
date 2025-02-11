import 'package:crypto_app/Domain/Model/accountable_account.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'rest_accountable_account.g.dart';

@RestApi(baseUrl: 'localhost:8080')
abstract class RestAccountableAccount {
  factory RestAccountableAccount(Dio dio) = _RestAccountableAccount;

  @GET('acountable_account')
  Future<List<AccountableAccount>> getAccountableAccount();
}
