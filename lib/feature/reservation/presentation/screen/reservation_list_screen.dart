// ignore_for_file: deprecated_member_use, unused_field

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/core/widget/button/button_container.dart';
import 'package:nilz_app/feature/drawer/basic_data/city/presentation/cubit/city_cubit.dart';
import 'package:nilz_app/feature/drawer/basic_data/data/repository/basic_data_repository.dart';
import 'package:nilz_app/feature/reservation/domain/repository/reservation_repository.dart';
import 'package:nilz_app/feature/reservation/presentation/cubit/unit_cubit.dart';
import 'package:nilz_app/feature/reservation/presentation/screen/create_reservation_screen.dart';
import 'package:nilz_app/feature/reservation/presentation/screen/inquiry_screen.dart';
import '../../../../core/injection/injection_container.dart' as di;
import '../../../../core/resource/color_manager.dart';
import '../../../../core/widget/bar/search_bar.dart';
import '../cubit/reservation_cubit.dart';
import '../widget/reservation_list.dart';

class ReservationListScreen extends StatefulWidget {
  const ReservationListScreen({super.key});

  @override
  State<ReservationListScreen> createState() => _ReservationListScreenState();
}

class _ReservationListScreenState extends State<ReservationListScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Buttons
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: ButtonContainer(
                  text: 'add_reservation'.tr(),
                  fontSize: 15,
                  height: 48,
                  color: AppColorManager.denim,
                  textColor: AppColorManager.background,
                  fontWeight: FontWeight.w600,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MultiRepositoryProvider(
                          providers: [
                            RepositoryProvider(
                              create: (_) => di.sl<BasicDataRepository>(),
                            ),
                            RepositoryProvider(
                              create: (_) => di.sl<ReservationRepository>(),
                            ),
                          ],
                          child: MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (_) => di.sl<ReservationCubit>(),
                              ),
                              BlocProvider(
                                create: (_) => di.sl<CityCubit>(),
                              ),
                            ],
                            child: const CreateReservationScreen(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ButtonContainer(
                  text: 'inquiry'.tr(),
                  fontSize: 15,
                  height: 48,
                  textColor: AppColorManager.denim,
                  fontWeight: FontWeight.w600,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MultiRepositoryProvider(
                          providers: [
                            RepositoryProvider(
                              create: (_) => di.sl<BasicDataRepository>(),
                            ),
                            RepositoryProvider(
                              create: (_) => di.sl<ReservationRepository>(),
                            ),
                          ],
                          child: MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (_) => di.sl<ReservationCubit>(),
                              ),
                              BlocProvider(
                                create: (_) => di.sl<CityCubit>(),
                              ),
                              BlocProvider(
                                create: (_) => di.sl<UnitCubit>(),
                              ),
                            ],
                            child: const InquiryScreen(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomSearchBar(
            controller: _searchCtrl,
            onChanged: (v) => setState(() => _query = v.trim()),
          ),
        ),
        const SizedBox(height: 8),

        // List
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 8),
              child: ReservationList(),
            ),
          ),
        ),
      ],
    );
  }
}
