import 'package:app/Domain/Model/client_model.dart';
import 'package:dio/dio.dart';

class ClientService {
  final Dio _dio = Dio();
    final String _baseUrl = 'http://192.168.4.177:8080/client';

  Future<List<ClientModel>> fetchClients() async {
    try {
      final response = await _dio.get('http://192.168.4.177:8080/client');
      if (response.statusCode == 200) {
        final data = response.data;
        List<ClientModel> clients = (data as List)
            .map((item) => ClientModel.fromJson(item))
            .toList();
        return clients;
      } else {
        throw Exception('Error al cargar datos. Código: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Error en la petición: ${e.message}');
    }
  }

  Future<bool> registerClient(ClientModel client) async {
    try {
      final response = await _dio.post(
        _baseUrl,
        data: client.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      throw Exception('Error en la petición: ${e.message}');
    }
  }

  Future<void> deleteClient(int id) async {
    try {
      final response = await _dio.delete('http://192.168.4.177:8080/client/$id');
      if (response.statusCode == 200) {
        // Eliminado con éxito
        return;
      } else {
        throw Exception('Error al eliminar. Código: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Error en la petición: ${e.message}');
    }
  }

  // Método para actualizar un cliente, usando POST
  Future<void> updateClient(ClientModel client) async {
    try {
      // Ajusta el formato de datos que tu backend espera para la actualización.
      // Supongamos que envías JSON con id, name, email
      final response = await _dio.post(
        'http://192.168.4.177:8080/client',
        data: {
          'id': client.id,
          'name': client.name,
          'email': client.email,
        },
      );
      if (response.statusCode == 200) {
        // Actualización exitosa
        return;
      } else {
        throw Exception('Error al actualizar. Código: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Error en la petición: ${e.message}');
    }
  }
}
