import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/core/widget/bar/title_app_bar.dart';
import 'package:nilz_app/feature/drawer/basic_data/data/repository/basic_data_repository.dart';
import 'package:nilz_app/feature/reservation/domain/entity/response/unit_entity.dart';
import 'package:nilz_app/feature/reservation/presentation/model/room_model.dart';
import 'package:nilz_app/feature/reservation/presentation/cubit/unit_cubit.dart';
import 'package:nilz_app/feature/reservation/presentation/cubit/unit_state.dart';
import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import 'package:nilz_app/feature/reservation/presentation/screen/unit_details_screen.dart';
import 'package:nilz_app/feature/reservation/presentation/widget/inquiry/inquiry_widget.dart';
import 'package:nilz_app/feature/reservation/presentation/widget/inquiry/unit_card.dart';

class InquiryScreen extends StatefulWidget {
  const InquiryScreen({super.key});

  @override
  State<InquiryScreen> createState() => _InquiryScreenState();
}

class _InquiryScreenState extends State<InquiryScreen> {
  bool isInquiry = true;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _unitsKey = GlobalKey();

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

    await Future.delayed(const Duration(milliseconds: 200));

    // AUTO SCROLL TO UNITS SECTION
    final renderBox =
        _unitsKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero).dy;
      _scrollController.animateTo(
        position,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
            elevation: 2,
            automaticallyImplyLeading: false,
            expandedHeight: 350,
            flexibleSpace: FlexibleSpaceBar(
              background: InquiryWidget(
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
            ),
          ),

          // SPACER so first unit isn't cut off
          const SliverToBoxAdapter(child: SizedBox(height: 12)),

          // ─────────────────────────────
          // UNIT RESULTS SECTION
          // ─────────────────────────────
          BlocBuilder<UnitCubit, UnitState>(
            builder: (context, state) {
              if (state.status == CubitStatus.loading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state.status == CubitStatus.error) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      state.error,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }

              if (state.entity.isEmpty) {
                return SliverFillRemaining(
                  child: Center(child: Text('no_units_found'.tr())),
                );
              }

              final units = state.entity;

              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final unit = units[index];
                  return UnitCard(
                    unit: unit,
                    isArabic: isArabic,
                    onTap: () {
                      context.read<UnitCubit>().getUnitDetails(
                        context,
                        unitId: unit.id!,
                        toStartTimeIso: _toIsoDayAtNine(_fromDate!),
                        toEndTimeIso: _toIsoDayAtNine(_toDate!),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<UnitCubit>(),
                            child: UnitDetailsScreen(unit: unit),
                          ),
                        ),
                      );
                    },
                  );
                }, childCount: units.length),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUnitsSection(UnitState state) {
    final bool isArabic = context.locale.languageCode == 'ar';

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

    final List<UnitEntity> units = state.entity;

    return ListView.builder(
      itemCount: units.length,
      itemBuilder: (context, index) {
        final unit = units[index];
        return UnitCard(
          unit: unit,
          isArabic: isArabic,
          onTap: () {
            final unit = state.entity[index]; // or however you access it

            final startIso = _fromDate;
            final endIso = _toDate;

            context.read<UnitCubit>().getUnitDetails(
              context,
              unitId: unit.id!,
              toStartTimeIso: startIso!.toIso8601String(),
              toEndTimeIso: endIso!.toIso8601String(),
            );

            // Option A: navigate immediately to details page and let it listen to Cubit
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<UnitCubit>(),
                  child: UnitDetailsScreen(unit: unit),
                ),
              ),
            );

            // Option B: OR wait for success in a listener and then navigate
          },
        );
      },
    );
  }
}
