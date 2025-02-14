import '../../Domain/Service/response.dart';

abstract class IAuthenticationService {
  Future<Response> login({required String email, required String password});
}