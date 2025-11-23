import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/presentation/cubit/res_statistics_cubit.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/presentation/cubit/res_statistics_state.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/presentation/widget/res_statistics_container.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/domain/entity/response/res_statistics_entity.dart';
import '../../../../../core/resource/cubit_status_manager.dart';

class ResStatisticsList extends StatefulWidget {
  const ResStatisticsList({super.key});

  @override
  State<ResStatisticsList> createState() => _ResStatisticsListState();
}

class _ResStatisticsListState extends State<ResStatisticsList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ResStatisticsCubit>().getResStatistics(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResStatisticsCubit, ResStatisticsState>(
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


        final e = state.entity;

        final items = <_StatItem>[
          _StatItem('total_reservations'. tr(), e.reservation),
          _StatItem('pending_reservations'.tr(), e.pending),
          _StatItem('accepted_reservations'.tr(), e.approved),
          _StatItem('total_customers'.tr(), e.clients),
          _StatItem('rejected_reservations'.tr(), e.rejected),
          _StatItem('client_cancellations'.tr(), e.cancelledByClient),
          _StatItem('supervisor_cancellations'.tr(), e.cancelledByAdmin),
          _StatItem('clients_with_accepted_bookings'.tr(), e.approvedClients),
          _StatItem('new_accepted_customers'.tr(), e.approvedNewClients),
        ].where((it) => it.data != null).toList();

        if (items.isEmpty) {
          return Center(child: Text('no_statistics_found.'.tr()));
        }


        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return ResStatisticsContainer(
                title: item.title,
                data: item.data!,
              );
            },
          ),
        );
      },
    );
  }
}

// Helper data holder
class _StatItem {
  final String title;
  final ResStatisticsCategoryEntity? data;
  _StatItem(this.title, this.data);
}
