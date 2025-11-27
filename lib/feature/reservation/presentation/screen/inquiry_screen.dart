import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/core/widget/bar/title_app_bar.dart';
import 'package:nilz_app/feature/drawer/basic_data/data/repository/basic_data_repository.dart';
import 'package:nilz_app/feature/reservation/presentation/model/room_model.dart';
import 'package:nilz_app/feature/reservation/presentation/widget/create_reservation/inquiry_widget.dart';

class InquiryScreen extends StatefulWidget {
  const InquiryScreen({super.key});

  @override
  State<InquiryScreen> createState() => _InquiryScreenState();
}

class _InquiryScreenState extends State<InquiryScreen> {

  List<dynamic> _cities = [];
  dynamic _selectedCity;

  DateTime? _fromDate;
  DateTime? _toDate;

  List<RoomInfo> _rooms = [];

  List<dynamic> _units = [];
  bool _isLoadingUnits = false;
  String? _unitsError;

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  //   Future<void> _searchUnits() async {
  //   if (_selectedCity == null || _fromDate == null || _toDate == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('please_fill_filters'.tr())),
  //     );
  //     return;
  //   }

  //   setState(() {
  //     _isLoadingUnits = true;
  //     _unitsError = null;
  //   });

  //   try {
  //     // TODO: replace with your repository that calls /unit/children

  //     final repository = context.read<BasicDataRepository>();

  //     // Example: if you create a method like "getAvailableUnits"
  //     // with body similar to what you showed:
  //     final result = await repository.getAvailableUnits(
  //       cityId: _selectedCity.id,   // adjust according to your city model
  //       fromDate: _fromDate!,
  //       toDate: _toDate!,
  //       rooms: _rooms,              // or roomConfig mapping
  //     );

  //     if (!mounted) return;

  //     result.fold(
  //       (failure) {
  //         setState(() {
  //           _isLoadingUnits = false;
  //           _unitsError = failure.message ?? 'something_went_wrong'.tr();
  //           _units = [];
  //         });
  //       },
  //       (success) {
  //         // success should be something like UnitsApiResponseEntity
  //         // with a "results" list. For now, assume:
  //         // success.data.results => List<dynamic>
  //         setState(() {
  //           _isLoadingUnits = false;
  //           _units = success.data.results; // adjust to your entity
  //         });
  //       },
  //     );
  //   } catch (e) {
  //     if (!mounted) return;
  //     setState(() {
  //       _isLoadingUnits = false;
  //       _unitsError = e.toString();
  //     });
  //   }
  // }


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
      appBar: MainAppBar(
        title: 'inquiry'.tr(),
        showArrowBack: true,
        showSuffixIcon: false,
      ),
      body: Column(
        children: [
          InquiryWidget(
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
          ),

          const SizedBox(height: 12),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: SizedBox(
          //     width: double.infinity,
          //     child: ElevatedButton(
          //       onPressed: _isLoadingUnits ? null : _searchUnits,
          //       child: Text('search'.tr()),
          //     ),
          //   ),
          // ),

          const SizedBox(height: 12),

          // 🔹 Now show the results below
          Expanded(
            child: _buildUnitsSection(),
          ),
        ],
      ),
    );
  }

    Widget _buildUnitsSection() {
    if (_isLoadingUnits) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_unitsError != null) {
      return Center(
        child: Text(
          _unitsError!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (_units.isEmpty) {
      return Center(
        child: Text('no_units_found'.tr()),
      );
    }

    return ListView.builder(
      itemCount: _units.length,
      itemBuilder: (context, index) {
        final unit = _units[index];

        // Assuming "unit" is a Map<String, dynamic> from your response
        // with structure like your JSON:
        final parent = unit['parent'];
        final unitName = unit['name']?['en'] ?? unit['name']?['ar'] ?? '';
        final parentName =
            parent?['name']?['en'] ?? parent?['name']?['ar'] ?? '';
        final price = unit['price']?.toString() ?? '';
        final address = unit['address']?.toString() ?? '';
        final coverUrl = unit['coverImage']?['url'];

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
                if (parentName.isNotEmpty)
                  Text(parentName, style: const TextStyle(fontSize: 12)),
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
              // TODO: navigate to unit details if you have a screen for it
            },
          ),
        );
      },
    );
  }

}
