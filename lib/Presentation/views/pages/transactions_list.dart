import 'package:app/Domain/Model/transaction_list_model.dart';
import 'package:app/Infrastructure/Service/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:app/Presentation/views/widget/body_widget.dart';
import 'package:app/Presentation/views/widget/static_table_widget.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  final TransactionService _transactionService = TransactionService();
  late Future<List<TransactionList>> _futureTransactions;

  @override
  void initState() {
    super.initState();
    _futureTransactions = _transactionService.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      body: () => Center(
        child: FutureBuilder<List<TransactionList>>(
          future: _futureTransactions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text("No hay transacciones disponibles.");
            }

            List<TransactionList> transactions = snapshot.data!;

            // Mapeo de datos obtenidos de la API a la tabla
            List<List<String>> tableData = transactions.map((transaction) {
              return [
                transaction.transactionId.toString(), // ID
                "Producto ${transaction.transactionId}", // Producto ficticio (modificar según API)
                "\$${transaction.amount?.toStringAsFixed(2)}", // Precio
                transaction.clientId.toString(), // Cliente como stock (modificar si es diferente)
              ];
            }).toList();

            return StaticTable(
              title: "Transacciones",
              columnHeaders: ["ID", "Producto", "Precio", "Cliente"],
              data: tableData,
              borderColor: Colors.deepPurple,
              borderWidth: 2,
              headerBackgroundColor: Colors.green,
              containerBackgroundColor: Colors.yellow.shade100,
              showEditColumn: true,
              showDeleteColumn: true,
              isStatic: true,
              onEdit: (index) => print("Editar ítem $index"),
              onDelete: (index) => print("Eliminar ítem $index"),
              onTapRow: (index) => print("Fila $index clickeada"),
            );
          },
        ),
      ),
    );
  }
}
