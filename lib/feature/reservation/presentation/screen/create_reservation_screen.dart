import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/widget/bar/title_app_bar.dart';
import 'package:nilz_app/core/widget/form_field/text_form_field/text_form_field.dart';
import 'package:nilz_app/feature/drawer/basic_data/data/repository/basic_data_repository.dart';
import 'package:nilz_app/feature/reservation/presentation/model/room_model.dart';
import 'package:nilz_app/feature/reservation/presentation/widget/create_reservation/inquiry_widget.dart';

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
          /// Reuse the same header widget as Inquiry,
          /// but hide the search button (isInquiry: false).
          InquiryWidget(
            isInquiry: false,
            cities: _cities,
            selectedCity: _selectedCity,
            isArabic: isArabic,
            fromDate: _fromDate,
            toDate: _toDate,
            rooms: _rooms,
            onCityChanged: (city) {
              setState(() => _selectedCity = city);
            },
            onFromDateChanged: (date) {
              setState(() {
                _fromDate = date;
                if (_toDate != null &&
                    _fromDate != null &&
                    _toDate!.isBefore(_fromDate!)) {
                  _toDate = null;
                }
              });
            },
            onToDateChanged: (date) {
              setState(() {
                _toDate = date;
              });
            },
            onRoomsChanged: (rooms) {
              setState(() {
                _rooms = rooms;
              });
            },
            onSearch: () {}, // required param, but unused when isInquiry == false
          ),

          // Rest of the reservation form
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                color: AppColorManager.white,
                child: const SingleChildScrollView(
                  child: Column(
                    children: [
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
