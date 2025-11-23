import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../resource/color_manager.dart';
import '../../resource/cubit_status_manager.dart';
import '../dialog/generic_add_dialog.dart';
import 'entity_adapter.dart';
import 'generic_entity_container.dart';

class GenericEntityList<T, S, C extends Cubit<S>> extends StatefulWidget {
  final String query;
  final EntityAdapter<T> adapter;
  final String editDialogTitle;
  final String deleteDialogTitle;
  final String deleteDialogMessage;
  final String nameArHint;
  final String nameEnHint;
  final String pickImageText;
  final String noImageSelectedText;
  final String saveText;
  final String cancelText;
  final String deleteText;
  final String somethingWentWrongText;
  final String noResultsFoundText;

  // Optional
  final bool enableImage;
  final bool enableCity;
  final bool enableStatus;

  // City Dropdown
  final String cityLabel;
  final String cityHint;
  final List<SimpleOption> cityOptions;
  final String? initialCityId;

  // status initial value
  final String statusLabel;
  final bool? initialStatus;

  final Function(
    BuildContext,
    String,
    String?,
    String?,
    String?,
    String?,
    bool?,
    bool,
      String?,
  )
  onEdit;
  final Function(BuildContext, String) onDelete;
  final Function(BuildContext) onFetch;
  final CubitStatus Function(S) getStatus;
  final String Function(S) getError;
  final List<T> Function(S) getItems;

  const GenericEntityList({
    super.key,
    this.query = '',
    required this.adapter,
    required this.editDialogTitle,
    required this.deleteDialogTitle,
    required this.deleteDialogMessage,
    required this.nameArHint,
    required this.nameEnHint,
    required this.pickImageText,
    required this.noImageSelectedText,
    required this.saveText,
    required this.cancelText,
    required this.deleteText,
    required this.somethingWentWrongText,
    required this.noResultsFoundText,
    required this.onEdit,
    required this.onDelete,
    required this.onFetch,
    required this.getStatus,
    required this.getError,
    required this.getItems,

    //Optional
    this.enableImage = false,
    this.enableCity = false,
    this.enableStatus = false,

    // city settings
    this.cityLabel = 'City',
    this.cityHint= 'Select City',
    this.cityOptions = const [],
    this.initialCityId,

    // status settings
    this.statusLabel = 'Active',
    this.initialStatus,
  });

  @override
  State<GenericEntityList<T, S, C>> createState() =>
      _GenericEntityListState<T, S, C>();
}

class _GenericEntityListState<T, S, C extends Cubit<S>>
    extends State<GenericEntityList<T, S, C>> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onFetch(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, S>(
      builder: (context, state) {
        final status = widget.getStatus(state);

        if (status == CubitStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (status == CubitStatus.error) {
          final error = widget.getError(state);
          return Center(
            child: Text(
              error.isEmpty ? widget.somethingWentWrongText : error,
              style: const TextStyle(color: AppColorManager.red, fontSize: 16),
            ),
          );
        }

        final items = widget.getItems(state);
        final q = widget.query.toLowerCase();

        final filtered = q.isEmpty
            ? items
            : items
                  .where((item) => widget.adapter.matchesQuery(item, q))
                  .toList();

        if (filtered.isEmpty) {
          return Center(child: Text(widget.noResultsFoundText));
        }

        return Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.separated(
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              return GenericEntityContainer<T, C>(
                entity: filtered[index],
                adapter: widget.adapter,
                editDialogTitle: widget.editDialogTitle,
                deleteDialogTitle: widget.deleteDialogTitle,
                deleteDialogMessage: widget.deleteDialogMessage,
                nameArHint: widget.nameArHint,
                nameEnHint: widget.nameEnHint,
                pickImageText: widget.pickImageText,
                noImageSelectedText: widget.noImageSelectedText,
                saveText: widget.saveText,
                cancelText: widget.cancelText,
                deleteText: widget.deleteText,
                onEdit: widget.onEdit,
                onDelete: widget.onDelete,
                enableImage: widget.enableImage,
                enableCity: widget.enableCity,
                enableStatus: widget.enableStatus,
                cityHint: widget.cityHint,
                cityLabel: widget.cityLabel,
                cityOptions: widget.cityOptions,
              );
            },
          ),
        );
      },
    );
  }
}
