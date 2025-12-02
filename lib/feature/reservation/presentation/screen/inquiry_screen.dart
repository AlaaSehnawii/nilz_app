import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/core/widget/bar/title_app_bar.dart';
import 'package:nilz_app/feature/drawer/basic_data/data/repository/basic_data_repository.dart';
import 'package:nilz_app/feature/reservation/domain/entity/response/unit_entity.dart';
import 'package:nilz_app/feature/reservation/presentation/model/room_model.dart';
import 'package:nilz_app/feature/reservation/presentation/widget/create_reservation/inquiry_widget.dart';
import 'package:nilz_app/feature/reservation/presentation/cubit/unit_cubit.dart';
import 'package:nilz_app/feature/reservation/presentation/cubit/unit_state.dart';
import 'package:nilz_app/core/resource/cubit_status_manager.dart';

class InquiryScreen extends StatefulWidget {
  const InquiryScreen({super.key});

  @override
  State<InquiryScreen> createState() => _InquiryScreenState();
}

class _InquiryScreenState extends State<InquiryScreen> {
  bool isInquiry = true;

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

  List<Map<String, dynamic>> _buildRoomConfig() {
    return _rooms.map((room) {
      final List<Map<String, dynamic>> guests = [];

      if (room.adults > 0) {
        guests.add({"age": -1, "count": room.adults});
      }

      for (final age in room.childrenAges) {
        if (age == null) continue;
        guests.add({"age": age, "count": 1});
      }

      return {"guests": guests};
    }).toList();
  }

  String _toIsoDayAtNine(DateTime date) {
    final d = DateTime(date.year, date.month, date.day, 9);
    return d.toUtc().toIso8601String();
  }

  Future<void> _searchUnits() async {
    if (_selectedCity == null || _fromDate == null || _toDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('please_fill_filters'.tr())));
      return;
    }

    final cubit = context.read<UnitCubit>();

    await cubit.getUnitChildren(
      context,
      cityId: _selectedCity.id,
      toStartTimeIso: _toIsoDayAtNine(_fromDate!),
      toEndTimeIso: _toIsoDayAtNine(_toDate!),
      roomConfig: _buildRoomConfig(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      appBar: MainAppBar(
        title: 'inquiry'.tr(),
        showArrowBack: true,
        showSuffixIcon: false,
      ),
      body: Column(
        children: [
          InquiryWidget(
            isInquiry: isInquiry,
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
            onSearch: _searchUnits,
          ),

          const SizedBox(height: 12),

          Expanded(
            child: BlocBuilder<UnitCubit, UnitState>(
              builder: (context, state) {
                return _buildUnitsSection(state);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitsSection(UnitState state) {
    if (state.status == CubitStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == CubitStatus.error) {
      return Center(
        child: Text(state.error, style: const TextStyle(color: Colors.red)),
      );
    }

    if (state.entity.isEmpty) {
      return Center(child: Text('no_units_found'.tr()));
    }

    final bool isArabic = context.locale.languageCode == 'ar';
    final List<UnitEntity> units = state.entity;

    return ListView.builder(
      itemCount: units.length,
      itemBuilder: (context, index) {
        final unit = units[index];

        final unitName = isArabic
            ? (unit.name?.ar ?? unit.name?.en ?? '')
            : (unit.name?.en ?? unit.name?.ar ?? '');

        final cityName = isArabic
            ? (unit.city?.name?.ar ?? unit.city?.name?.en ?? '')
            : (unit.city?.name?.en ?? unit.city?.name?.ar ?? '');

        final price = unit.price ?? '';
        final address = unit.address ?? '';
        final coverUrl = unit.coverImage?.url;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
          child: ListTile(
            leading: coverUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      coverUrl,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.hotel),
            title: Text(unitName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (cityName.isNotEmpty)
                  Text(cityName, style: const TextStyle(fontSize: 12)),
                if (address.isNotEmpty)
                  Text(address, style: const TextStyle(fontSize: 12)),
                if (price.isNotEmpty)
                  Text(
                    price,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
              ],
            ),
            onTap: () {
              // TODO: navigate to unit details screen
            },
          ),
        );
      },
    );
  }
}
