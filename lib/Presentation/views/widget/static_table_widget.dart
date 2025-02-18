import 'package:flutter/material.dart';

class StaticTable extends StatefulWidget {
  final String title; // ✅ Título de la tabla
  final List<String> columnHeaders; // ✅ Encabezados de la tabla
  final List<List<String>> data; // ✅ Datos de la tabla
  final Color? borderColor; // ✅ Color del borde de la tabla
  final double? borderWidth; // ✅ Grosor del borde de la tabla
  final Color? headerBackgroundColor; // ✅ Color de fondo del encabezado
  final Color? containerBackgroundColor; // ✅ Color de fondo del contenedor
  final bool isStatic; // ✅ Define si las filas son clickeables
  final bool showEditColumn; // ✅ Muestra la columna de editar
  final bool showDeleteColumn; // ✅ Muestra la columna de eliminar
  final void Function(int index)? onEdit; // ✅ Callback para editar
  final void Function(int index)? onDelete; // ✅ Callback para eliminar
  final void Function(int index)? onTapRow; // ✅ Callback cuando se toca una fila

  const StaticTable({
    Key? key,
    required this.title,
    required this.columnHeaders,
    required this.data,
    this.borderColor,
    this.borderWidth,
    this.headerBackgroundColor,
    this.containerBackgroundColor,
    this.isStatic = true,
    this.showEditColumn = false,
    this.showDeleteColumn = false,
    this.onEdit,
    this.onDelete,
    this.onTapRow,
  }) : super(key: key);

  @override
  _StaticTableState createState() => _StaticTableState();
}

class _StaticTableState extends State<StaticTable> {
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double headerFontSize = screenWidth > 600 ? 18 : 14;
    double cellFontSize = screenWidth > 600 ? 16 : 12;

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.containerBackgroundColor ?? Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 📌 TÍTULO CENTRADO
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          // 📌 TABLA DENTRO DE UNA CARD CON SCROLL HORIZONTAL Y VERTICAL
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              height: screenHeight * 0.5, // ✅ Permite scroll vertical si hay muchas filas
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.borderColor ?? Colors.blueAccent,
                  width: widget.borderWidth ?? 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Scrollbar(
                controller: _verticalScrollController, // ✅ Scroll vertical
                thumbVisibility: true,
                thickness: 6,
                radius: Radius.circular(10),
                child: SingleChildScrollView(
                  controller: _verticalScrollController,
                  scrollDirection: Axis.vertical,
                  child: Scrollbar(
                    controller: _horizontalScrollController, // ✅ Scroll horizontal
                    thumbVisibility: true,
                    thickness: 6,
                    radius: Radius.circular(10),
                    child: SingleChildScrollView(
                      controller: _horizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: screenWidth, // ✅ Asegura que la tabla crezca para activar scroll
                        ),
                        child: DataTable(
                          columnSpacing: 25,
                          headingRowColor: MaterialStateColor.resolveWith(
                            (states) =>
                                widget.headerBackgroundColor ?? Colors.blue.shade400,
                          ),
                          dataRowColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered) &&
                                  !widget.isStatic) {
                                return Colors.blue.shade100;
                              }
                              return null;
                            },
                          ),
                          border: TableBorder(
                            horizontalInside: BorderSide(
                              color: widget.borderColor ??
                                  Colors.blueAccent.withOpacity(0.5),
                              width: widget.borderWidth ?? 1.5,
                            ),
                          ),
                          columns: [
                            ...widget.columnHeaders.map((header) {
                              return DataColumn(
                                label: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    header,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: headerFontSize,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            if (widget.showEditColumn)
                              DataColumn(
                                label: Icon(Icons.edit, color: Colors.white),
                              ),
                            if (widget.showDeleteColumn)
                              DataColumn(
                                label: Icon(Icons.delete, color: Colors.white),
                              ),
                          ],
                          rows: List.generate(widget.data.length, (index) {
                            return DataRow(
                              onSelectChanged: widget.isStatic
                                  ? null
                                  : (_) {
                                      if (widget.onTapRow != null) {
                                        widget.onTapRow!(index);
                                      }
                                    },
                              cells: [
                                ...widget.data[index].map((cell) {
                                  return DataCell(
                                    GestureDetector(
                                      onTap: widget.isStatic
                                          ? null
                                          : () {
                                              if (widget.onTapRow != null) {
                                                widget.onTapRow!(index);
                                              }
                                            },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 6),
                                        child: Text(
                                          cell,
                                          style: TextStyle(
                                            fontSize: cellFontSize,
                                            color: widget.isStatic
                                                ? Colors.black87
                                                : Colors.blueAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                if (widget.showEditColumn)
                                  DataCell(
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.blue),
                                      onPressed: widget.onEdit != null
                                          ? () => widget.onEdit!(index)
                                          : null,
                                    ),
                                  ),
                                if (widget.showDeleteColumn)
                                  DataCell(
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: widget.onDelete != null
                                          ? () => widget.onDelete!(index)
                                          : null,
                                    ),
                                  ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/* 
✅ 📌 PROPIEDADES DISPONIBLES PARA StaticTable

- title: String -> Define el título de la tabla.
- columnHeaders: List<String> -> Lista de nombres de las columnas.
- data: List<List<String>> -> Lista con los datos de la tabla.
- borderColor: Color? -> Color opcional del borde de la tabla.
- borderWidth: double? -> Grosor opcional del borde.
- headerBackgroundColor: Color? -> Color de fondo del encabezado de la tabla.
- containerBackgroundColor: Color? -> Color de fondo del contenedor principal.
- isStatic: bool (default: true) -> Si es true, las filas no son clickeables.
- showEditColumn: bool (default: false) -> Si es true, muestra una columna con íconos de edición.
- showDeleteColumn: bool (default: false) -> Si es true, muestra una columna con íconos de eliminación.
- onEdit: Function(int index)? -> Callback opcional cuando se edita una fila.
- onDelete: Function(int index)? -> Callback opcional cuando se elimina una fila.
- onTapRow: Function(int index)? -> Callback opcional cuando se toca una fila.

*/

/* 
✅ 📌 EJEMPLO DE USO DE StaticTable

StaticTable(
  title: "Inventario",
  columnHeaders: ["ID", "Producto", "Precio", "Stock"],
  data: [
    ["001", "Laptop", "\$1000", "5"],
    ["002", "Mouse", "\$25", "20"],
    ["003", "Teclado", "\$45", "15"],
    ["004", "Monitor", "\$200", "8"],
    ["005", "Impresora", "\$120", "10"],
  ],
  //Estos son opcionales
  borderColor: Colors.deepPurple,
  borderWidth: 2,
  headerBackgroundColor: Colors.green,
  containerBackgroundColor: Colors.yellow.shade100, // ✅ Color del contenedor
  showEditColumn: true, // ✅ Activar edición
  showDeleteColumn: true, // ✅ Activar eliminación
  isStatic: false,
  onEdit: (index) => print("Editar ítem $index"),
  onDelete: (index) => print("Eliminar ítem $index"),
  onTapRow: (index) => print("Fila $index clickeada"),
);
*/


