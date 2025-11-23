import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/feature/dashboard/pending_requests/presentation/widget/pending_req_container.dart';
import '../../../../../core/resource/cubit_status_manager.dart';
import '../../domain/entity/response/pending_req_entity.dart';
import '../cubit/pending_req_cubit.dart';
import '../cubit/pending_req_state.dart';

class PendingRequestList extends StatefulWidget {
  const PendingRequestList({super.key});

  @override
  State<PendingRequestList> createState() => _PendingRequestListState();
}

class _PendingRequestListState extends State<PendingRequestList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PendingRequestCubit>().getPendingRequest(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PendingRequestCubit, PendingRequestState>(
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
          _StatItem(e),
        ].where((it) => it.data != null).toList();

        if (items.isEmpty) {
          return Center(child: Text('no_requests_found.'.tr()));
        }


        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return PendingRequestContainer(
                response: item.data!,
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
  final PendingRequestResponseEntity? data;
  _StatItem(this.data);
}
