import 'package:app/Domain/Model/client_model.dart';
import 'package:dio/dio.dart';

class ClientService {
  final Dio _dio = Dio();

  Future<List<ClientModel>> fetchClients() async {
    try {
      final response = await _dio.get('http://192.168.4.177:8080/client');

      if (response.statusCode == 200) {
        final data = response.data; // dynamic

        // Convertimos cada elemento de la lista en un objeto ClientModel
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
}
