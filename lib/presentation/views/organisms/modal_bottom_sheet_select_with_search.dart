import 'package:flutter/material.dart';

import '../style/dimensions.dart';

class ModalBottomSheetSelectWithSearch<T> extends StatefulWidget {
  final String label;
  final List<T> options;
  final T? initialValue;
  final String Function(T) displayValue;
  final void Function(T?) onChanged;
  final bool showSearch;

  const ModalBottomSheetSelectWithSearch({
    super.key,
    required this.label,
    required this.options,
    this.initialValue,
    required this.displayValue,
    required this.onChanged,
    this.showSearch = true,
  });

  @override
  State<ModalBottomSheetSelectWithSearch<T>> createState() =>
      _ModalBottomSheetSelectWithSearchState<T>();
}

class _ModalBottomSheetSelectWithSearchState<T>
    extends State<ModalBottomSheetSelectWithSearch<T>> {
  T? _selectedValue;
  List<T> _filteredOptions = [];
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    _filteredOptions = widget.options;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme =
        Theme.of(context).colorScheme;
    final kOutline = colorScheme.outline;
    final kSurface = colorScheme.surface;
    final kOnSurface = colorScheme.onSurface;
    final kOnSurfaceVariant = colorScheme.onSurfaceVariant;
    final kPrimary = colorScheme.primary;

    final kFormPadding = Dimensions.paddings.large;
    final kLayoutRadius = Dimensions.radius.xlarge;

    return InkWell(
      onTap: () {
        _showModalBottomSheet(
            context,
            kOutline,
            kSurface,
            kOnSurface,
            kOnSurfaceVariant,
            kPrimary,
            kFormPadding,
            kLayoutRadius);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: kOutline),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                _selectedValue != null
                    ? widget.displayValue(_selectedValue as T)
                    : '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: kOnSurface),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: kOnSurface),
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet(
    BuildContext context,
    Color outline,
    Color surface,
    Color onSurface,
    Color onSurfaceVariant,
    Color primary,
    double formPadding,
    double layoutRadius,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.5,
              minChildSize: 0.3,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.all(formPadding),
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(layoutRadius),
                      topRight: Radius.circular(layoutRadius),
                    ),
                  ),
                  child: Column(
                    children: [
                      if (widget.showSearch)
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  setState(() {
                                    _searchText = value;
                                    _filteredOptions = widget.options
                                        .where((option) => widget
                                            .displayValue(option)
                                            .toLowerCase()
                                            .contains(
                                                _searchText.toLowerCase()))
                                        .toList();
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  hintStyle: TextStyle(color: onSurfaceVariant),
                                  prefixIcon: Icon(Icons.search,
                                      color: onSurfaceVariant),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: outline),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: primary),
                                  ),
                                ),
                                style: TextStyle(color: onSurface),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchText = '';
                                  _filteredOptions = widget.options;
                                });
                              },
                              icon: Icon(Icons.clear, color: onSurfaceVariant),
                            ),
                          ],
                        ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: _filteredOptions.length,
                          itemBuilder: (context, index) {
                            final option = _filteredOptions[index];
                            return ListTile(
                              title: Text(widget.displayValue(option),
                                  style: TextStyle(color: onSurface)),
                              onTap: () {
                                setState(() {
                                  _selectedValue = option;
                                  widget.onChanged(option);
                                });
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
