import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/core/widget/bar/title_app_bar.dart';
import 'package:nilz_app/core/widget/date_picker/date_picker_field.dart';
import 'package:nilz_app/core/widget/form_field/text_form_field.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/widget/form_field/text_form_field/searchable_dropdown.dart';
import 'package:nilz_app/feature/basic_data/data/repository/basic_data_repository.dart';
import 'package:nilz_app/feature/reservation/presentation/model/room_model.dart';
import 'package:nilz_app/feature/reservation/presentation/widget/room_settings_field.dart';

class CreateReservationScreen extends StatefulWidget {
  const CreateReservationScreen({super.key});

  @override
  State<CreateReservationScreen> createState() =>
      _CreateReservationScreenState();
}

class _CreateReservationScreenState extends State<CreateReservationScreen> {
  List<dynamic> _cities = [];
  dynamic _selectedCity;

  DateTime? _fromDate;
  DateTime? _toDate;

  List<RoomInfo> _rooms = [];

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    final repository = context.read<BasicDataRepository>();
    final result = await repository.getCity();

    if (!mounted) return;

    setState(() {
      result.fold(
        (failure) => _cities = [],
        (success) => _cities = success.cities,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: AppColorManager.background,
      appBar: MainAppBar(
        title: 'add_reservation'.tr(),
        showArrowBack: true,
        showSuffixIcon: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: SearchableDropdown<dynamic>(
              items: _cities,
              selectedItem: _selectedCity,
              titleText: "city".tr(),
              hintText: "select_city".tr(),
              labelBuilder: (city) {
                final en = city.name?.en ?? '';
                final ar = city.name?.ar ?? '';
                if (isArabic) {
                  return ar.isNotEmpty ? ar : en;
                } else {
                  return en.isNotEmpty ? en : ar;
                }
              },
              filterFn: (city, query) {
                if (query.isEmpty) return true;
                final q = query.toLowerCase();
                final en = (city.name?.en ?? '').toLowerCase();
                final ar = (city.name?.ar ?? '').toLowerCase();
                return en.contains(q) || ar.contains(q);
              },
              onChanged: (city) {
                setState(() => _selectedCity = city);
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: DatePickerField(
                    hint: 'arrive_date'.tr(),
                    label: 'arrive_date'.tr(),
                    value: _fromDate,
                    onChanged: (date) {
                      setState(() {
                        _fromDate = date;
                        if (_toDate != null &&
                            _fromDate != null &&
                            _toDate!.isBefore(_fromDate!)) {
                          _toDate = null;
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DatePickerField(
                    hint: 'leave_date'.tr(),
                    label: 'leave_date'.tr(),
                    value: _toDate,
                    onChanged: (date) {
                      setState(() {
                        _toDate = date;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: RoomSettingsField(
              rooms: _rooms,
              onChanged: (rooms) {
                setState(() {
                  _rooms = rooms;
                });
              },
            ),
          ),

          const Divider(),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                color: AppColorManager.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      MyTextFormField(),
                      MyTextFormField(),
                      MyTextFormField(),
                      MyTextFormField(),
                      MyTextFormField(),
                      MyTextFormField(),
                    ],
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
