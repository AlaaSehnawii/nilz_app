import '../dialog/generic_add_dialog.dart';

class EntityConfig {
  // Existing labels
  final String addDialogTitle;
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
  final String errorTitle;

  //  optional sections for Add dialog
  final bool enableImage;
  final bool enableCity;
  final bool enableStatus;

  // city dropdown config
  final String cityLabel;
  final String cityHint;
  final List<SimpleOption> cityOptions;
  final String? initialCityId;

  // status initial value
  final String statusLabel;
  final bool? initialStatus;

  const EntityConfig({
    // required labels
    required this.addDialogTitle,
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
    required this.errorTitle,

    // optional sections
    this.enableImage = false,
    this.enableCity = false,
    this.enableStatus = false,

    // city settings
    this.cityLabel = 'City',
    this.cityHint = 'Select city',
    this.cityOptions = const [],
    this.initialCityId,

    // status settings
    this.statusLabel = 'Active',
    this.initialStatus,
  });
}
