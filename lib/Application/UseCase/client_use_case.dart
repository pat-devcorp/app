
import 'package:app/Application/State/client_state.dart';
import 'package:app/Infrastructure/Service/client_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientUseCase extends StateNotifier<ClientState> {
  ClientUseCase() : super(ClientState.initial);

  Future<void> registerClient(
    BuildContext context, {
    required String name,
    required String lastName,
    required String dni,
    required String address,
  }) async {
    state = ClientState.loading;

    try {
      final response = await ClientService.registrar(
        context,
        name      : name,
        lastName  : lastName,
        dni       : dni,
        address   : address,
      );

      if (response.statusCode == 200) {
        state = ClientState.success;
      } else {
        state = ClientState.error;
      }
    } catch (e) {
      state = ClientState.error;
    }
  }
}

final clientProvider = StateNotifierProvider<ClientUseCase, ClientState>(
  (ref) => ClientUseCase(),
);
