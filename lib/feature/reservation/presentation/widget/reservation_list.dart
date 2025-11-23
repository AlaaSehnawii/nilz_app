import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resource/cubit_status_manager.dart';
import '../../domain/entity/response/reservation_entity.dart';
import '../cubit/reservation_cubit.dart';
import '../cubit/reservation_state.dart';
import '../widget/reservation_container.dart';

class ReservationList extends StatefulWidget {
  const ReservationList({super.key});

  @override
  State<ReservationList> createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReservationCubit>().getReservation(context: context);
    });
  }

  DateTime? _parseDate(String? iso) {
    if (iso == null || iso.isEmpty) return null;
    return DateTime.tryParse(iso);
  }


  DateTime? _getSortDate(ReservationEntity r) {
    return _parseDate(r.fromDate) ?? _parseDate(r.createdAt);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationCubit, ReservationState>(
      builder: (context, state) {
        if (state.status == CubitStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == CubitStatus.error) {
          return Center(
            child: Text(
              state.error.isEmpty ? 'something_went_wrong'.tr() : state.error,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        }

        final ReservationListResponseEntity? entity = state.entity;
        final List<ReservationEntity> reservations =
            entity?.reservations ?? const [];

        if (reservations.isEmpty) {
          return Center(
            child: Text(
              'no_requests_found.'.tr(),
              style: const TextStyle(fontSize: 16),
            ),
          );
        }

        // -------- sorting by date
        final sorted = [...reservations]
          ..sort((a, b) {
            final aDate = _getSortDate(a);
            final bDate = _getSortDate(b);


            if (aDate == null && bDate == null) return 0;
            if (aDate == null) return 1;
            if (bDate == null) return -1;

            return bDate.compareTo(aDate);
          });

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ListView.builder(
            itemCount: sorted.length,
            itemBuilder: (context, index) {
              final reservation = sorted[index];
              return ReservationContainer(reservation: reservation);
            },
          ),
        );
      },
    );
  }
}
