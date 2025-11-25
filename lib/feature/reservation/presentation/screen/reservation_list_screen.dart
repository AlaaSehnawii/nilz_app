import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/feature/basic_data/city/presentation/cubit/city_cubit.dart';
import 'package:nilz_app/feature/basic_data/data/repository/basic_data_repository.dart';
import 'package:nilz_app/feature/reservation/presentation/screen/create_reservation_screen.dart';
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
  // ignore: unused_field
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColorManager.background,
        body: Column(
          children: [
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
                    ),
                  ),
                ],
              ),
            ),

            // SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomSearchBar(
                controller: _searchCtrl,
                onChanged: (v) => setState(() => _query = v.trim()),
              ),
            ),
            const SizedBox(height: 8),

            // LIST AREA ON A WHITE SHEET
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: BlocProvider.value(
                    value: context.read<ReservationCubit>(),
                    child: const ReservationList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// YOUR ORIGINAL BUTTONCONTAINER (unchanged)
class ButtonContainer extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final double height;
  final double width;
  final double fontSize;
  final FontWeight fontWeight;

  const ButtonContainer({
    super.key,
    required this.text,
    this.onTap,
    this.color = AppColorManager.background,
    this.textColor = AppColorManager.textAppColor,
    this.borderColor = AppColorManager.denim,
    this.height = 100,
    this.width = 200,
    this.fontSize = 30,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
