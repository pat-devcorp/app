import '../../Domain/Except/invalid_argument.dart';
import '../../Domain/Model/client.dart';

class FactoryClient {
  static Client create({
    required String name,
    required String lastName,
    required String dni,
    required String address,
  }) {
    if (name.isEmpty || lastName.isEmpty || dni.isEmpty || address.isEmpty) {
      throw InvalidArgument('Todos los campos son obligatorios');
    }

    if (dni.length < 7 || dni.length > 8) {
      throw InvalidArgument('DNI debe tener 7 u 8 dígitos');
    }

    return Client(
      name      : name,
      lastName  : lastName,
      dni       : dni,
      address   : address,
    );
  }

  static Client fromJson(Map<String, dynamic> json) => Client(
        name      : json['name'     ] as String,
        lastName  : json['lastName' ] as String,
        dni       : json['dni'      ] as String,
        address   : json['address  '] as String,
      );

  static Map<String, dynamic> toJson(Client instance) => <String, dynamic>{
        'name'     : instance.name,
        'apellido' : instance.lastName,
        'dni'      : instance.dni,
        'address'  : instance.address,
      };
}
