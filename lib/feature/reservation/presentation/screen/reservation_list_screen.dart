import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/core/widget/app_bar/title_app_bar.dart';
import '../cubit/reservation_cubit.dart';
import '../widget/reservation_list.dart';

class ReservationListScreen extends StatelessWidget {
  const ReservationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "reservation".tr(), showArrowBack: false),
      body: BlocProvider.value(
        value: context.read<ReservationCubit>(),
        child: const ReservationList(),
      ),
    );
  }
}
