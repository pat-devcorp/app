import 'package:app/Application/State/client_register_state.dart';
import 'package:app/Domain/Model/response.dart';
import 'package:app/Infrastructure/Service/client_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

final clientRegisterProvider =
    StateNotifierProvider<ClientRegisterNotifier, ClientRegisterState>(
        (ref) => ClientRegisterNotifier(GetIt.instance<ClientService>()));

class ClientRegisterNotifier extends StateNotifier<ClientRegisterState> {
  final ClientService _clientService;

  ClientRegisterNotifier(this._clientService)
      : super(ClientRegisterState.idle);

  Future<void> registerClient(
      {required String name, required String email}) async {
    state = ClientRegisterState.loading;

    try {
      Response result =
          await _clientService.registerClient(name: name, email: email);

      if (result.success) {
        state = ClientRegisterState.registered;
      } else {
        state = ClientRegisterState.error;
      }
    } catch (e) {
      state = ClientRegisterState.error;
    }
  }
}
