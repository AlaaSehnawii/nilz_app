// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/widget/form_field/text_form_field/searchable_dropdown.dart';
import 'package:nilz_app/feature/auth/login/domain/entity/response/login_response_entity.dart';
import 'package:nilz_app/feature/drawer/basic_data/room_types/domain/entity/room_type_entity.dart';
import 'package:nilz_app/feature/reservation/domain/entity/response/unit_entity.dart';

class CreateReservationCard extends StatefulWidget {
  const CreateReservationCard({super.key});

  @override
  State<CreateReservationCard> createState() => _CreateReservationCardState();
}

class _CreateReservationCardState extends State<CreateReservationCard> {
  final List<UnitEntity> _places = [];
  UnitEntity? _selectedPlace;

  final List<RoomTypeEntity> _roomTypes = [];
  RoomTypeEntity? _selectedRoomType;

  final List<LoginApiResponseEntity> _users = [];
  LoginApiResponseEntity? _selectedUser;

  final List<LoginApiResponseEntity> _salesEmployees = [];
  LoginApiResponseEntity? _selectedSalesEmployee;

  @override
  void initState() {
    super.initState();
    _loadPlaces();
    _loadRoomTypes();
    _loadUsers();
    _loadSalesEmployees();
  }

  // ================== LOADERS (stubbed, fill with your repos) ==================

  Future<void> _loadPlaces() async {
    // TODO: call your repo/usecase to get hotels/places.
    // Example (pseudo):
    // final result = await context.read<SomeRepo>().getPlaces();
    // setState(() => _places = result);
  }

  Future<void> _loadRoomTypes() async {
    // TODO: load room types from your repo
  }

  Future<void> _loadUsers() async {
    // TODO: load users/clients from your repo
  }

  Future<void> _loadSalesEmployees() async {
    // TODO: load sales employees from your repo
  }

  // ================== HELPERS for SearchableDropdown ==================

  String _buildItemLabel(dynamic item, bool isArabic) {
    if (item == null) return '';

    try {
      final nameField = item.name; 
      if (nameField != null && (nameField.en != null || nameField.ar != null)) {
        final en = (nameField.en ?? '') as String;
        final ar = (nameField.ar ?? '') as String;
        if (isArabic) {
          return ar.isNotEmpty ? ar : en;
        } else {
          return en.isNotEmpty ? en : ar;
        }
      }
    } catch (_) {
      // ignore, try next patterns
    }

    try {
      // Case: user / sales employee with `fullName`
      final fullName = item.fullName as String?;
      if (fullName != null && fullName.isNotEmpty) return fullName;
    } catch (_) {}

    try {
      // Case: simple String
      if (item is String) return item;
    } catch (_) {}

    return item.toString();
  }

  bool _filterItem(dynamic item, String query, bool isArabic) {
    if (query.isEmpty) return true;
    final label = _buildItemLabel(item, isArabic).toLowerCase();
    return label.contains(query.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColorManager.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchableDropdown<UnitEntity>(
                  items: _places,
                  selectedItem: _selectedPlace,
                  titleText: 'hotel'.tr(), 
                  hintText: 'select_hotel'.tr(),
                  labelBuilder: (item) => _buildItemLabel(item, isArabic),
                  filterFn: (item, query) => _filterItem(item, query, isArabic),
                  onChanged: (place) {
                    setState(() => _selectedPlace = place);
                  },
                ),

                const SizedBox(height: 16),

                SearchableDropdown<RoomTypeEntity>(
                  items: _roomTypes,
                  selectedItem: _selectedRoomType,
                  titleText: 'room_type'.tr(),
                  hintText: 'select_room_type'.tr(),
                  labelBuilder: (item) => _buildItemLabel(item, isArabic),
                  filterFn: (item, query) => _filterItem(item, query, isArabic),
                  onChanged: (roomType) {
                    setState(() => _selectedRoomType = roomType);
                  },
                ),

                const SizedBox(height: 16),

                SearchableDropdown<LoginApiResponseEntity>(
                  items: _salesEmployees,
                  selectedItem: _selectedSalesEmployee,
                  titleText: 'sales_employee'.tr(),
                  hintText: 'select_sales_employee'.tr(),
                  labelBuilder: (item) => _buildItemLabel(item, isArabic),
                  filterFn: (item, query) => _filterItem(item, query, isArabic),
                  onChanged: (employee) {
                    setState(() => _selectedSalesEmployee = employee);
                  },
                ),

                const SizedBox(height: 16),

                SearchableDropdown<LoginApiResponseEntity>(
                  items: _users,
                  selectedItem: _selectedUser,
                  titleText: 'client'.tr(),
                  hintText: 'select_client'.tr(),
                  labelBuilder: (item) => _buildItemLabel(item, isArabic),
                  filterFn: (item, query) => _filterItem(item, query, isArabic),
                  onChanged: (user) {
                    setState(() => _selectedUser = user);
                  },
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
