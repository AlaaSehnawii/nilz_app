import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/resource/icon_manager.dart';
import 'package:nilz_app/core/widget/search_bar/search_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../resource/cubit_status_manager.dart';
import '../dialog/generic_add_dialog.dart';
import 'entity_adapter.dart';
import 'entity_config.dart';
import 'generic_entity_list.dart';

class GenericListScreen<T, S, C extends Cubit<S>> extends StatefulWidget {
  final EntityConfig config;
  final EntityAdapter<T> adapter;

  final Function(
    BuildContext ctx,
    String nameAr,
    String nameEn,
    String? imageName,
    String? base64,
    String? cityId,
    bool? status,
  )
  onAdd;

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
  final bool enableImage;
  final bool enableCity;
  final bool enableStatus;

  const GenericListScreen({
    super.key,
    required this.config,
    required this.adapter,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
    required this.onFetch,
    required this.getStatus,
    required this.getError,
    required this.getItems,
    this.enableImage = false,
    this.enableCity = false,
    this.enableStatus = false,
  });

  @override
  State<GenericListScreen<T, S, C>> createState() =>
      _GenericListScreenState<T, S, C>();
}

class _GenericListScreenState<T, S, C extends Cubit<S>>
    extends State<GenericListScreen<T, S, C>> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _showErrorPopup(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(widget.config.errorTitle),
        content: Text(
          message.isEmpty ? widget.config.somethingWentWrongText : message,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ok'.tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<C, S>(
      listenWhen: (prev, curr) =>
          widget.getStatus(prev) != widget.getStatus(curr),
      listener: (context, state) async {
        if (widget.getStatus(state) == CubitStatus.error) {
          await _showErrorPopup(context, widget.getError(state));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    BackButton(onPressed: () => Navigator.pop(context)),
                    Expanded(
                      child: CustomSearchBar(
                        controller: _searchCtrl,
                        onChanged: (v) => setState(() => _query = v.trim()),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: GenericEntityList<T, S, C>(
                    query: _query,
                    adapter: widget.adapter,
                    editDialogTitle: widget.config.editDialogTitle,
                    deleteDialogTitle: widget.config.deleteDialogTitle,
                    deleteDialogMessage: widget.config.deleteDialogMessage,
                    nameArHint: widget.config.nameArHint,
                    nameEnHint: widget.config.nameEnHint,
                    pickImageText: widget.config.pickImageText,
                    noImageSelectedText: widget.config.noImageSelectedText,
                    saveText: widget.config.saveText,
                    cancelText: widget.config.cancelText,
                    deleteText: widget.config.deleteText,
                    somethingWentWrongText:
                        widget.config.somethingWentWrongText,
                    noResultsFoundText: widget.config.noResultsFoundText,
                    onEdit: widget.onEdit,
                    onDelete: widget.onDelete,
                    onFetch: widget.onFetch,
                    getStatus: widget.getStatus,
                    getError: widget.getError,
                    getItems: widget.getItems,
                    enableImage: widget.enableImage,
                    enableCity: widget.enableCity,
                    enableStatus: widget.enableStatus,
                    cityLabel: widget.config.cityLabel,
                    cityHint: widget.config.cityHint,
                    cityOptions: widget.config.cityOptions,
                    initialCityId: widget.config.initialCityId,
                    statusLabel: widget.config.statusLabel,
                    initialStatus: widget.config.initialStatus,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();

                      final input = await showGenericAddDialog(
                        context,
                        title: widget.config.addDialogTitle,
                        nameArHint: widget.config.nameArHint,
                        nameEnHint: widget.config.nameEnHint,

                        enableImage: widget.config.enableImage,
                        enableCity: widget.config.enableCity,
                        enableStatus: widget.config.enableStatus,

                        cityLabel: widget.config.cityLabel,
                        cityHint: widget.config.cityHint,
                        cityOptions: widget.config.cityOptions,
                        initialCityId: widget.config.initialCityId,

                        statusLabel: widget.config.statusLabel,
                        initialStatus: widget.config.initialStatus,

                        pickImageText: widget.config.pickImageText,
                        noImageSelectedText: widget.config.noImageSelectedText,
                        confirmText: widget.config.saveText,
                        cancelText: widget.config.cancelText,
                      );
                      if (input == null) return;

                      widget.onAdd(
                        context,
                        input.nameAr,
                        input.nameEn,
                        input.imageName,
                        input.base64,
                        input.cityId,
                        input.status,
                      );
                    },
                    backgroundColor: AppColorManager.denim,
                    child: SvgPicture.asset(
                      AppIconManager.add,
                      color: AppColorManager.background,
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
