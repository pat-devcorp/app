import 'package:app/Domain/Model/transaction_list_model.dart';
import 'package:dio/dio.dart';

class TransactionService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://192.168.4.177:8080/api",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<List<TransactionList>> getTransactions() async {
    try {
      final response = await _dio.get('/transaction');
      
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => TransactionList.fromJson(json)).toList();
      } else {
        throw Exception("Error en la respuesta: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error al obtener transacciones: $e");
    }
  }
}
