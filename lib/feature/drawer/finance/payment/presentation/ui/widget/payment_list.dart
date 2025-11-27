import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/feature/drawer/finance/payment/domain/entity/payment_entity.dart';
import '../../../../../../../core/widget/list/generic_entity_list.dart';
import '../../adapter/payment_entity_adapter.dart';
import '../../cubit/payment_cubit.dart';
import '../../cubit/payment_state.dart';

class PaymentList extends StatelessWidget {
  final String query;

  const PaymentList({super.key, this.query = ''});

  @override
  Widget build(BuildContext context) {
    return GenericEntityList<PaymentEntity, PaymentState, PaymentCubit>(
      query: query,
      adapter: PaymentEntityAdapter(),
      editDialogTitle: 'edit_Payment'.tr(),
      deleteDialogTitle: 'delete_Payment'.tr(),
      deleteDialogMessage: 'are_you_sure_to_delete'.tr(),
      nameArHint: 'arabic_name'.tr(),
      nameEnHint: 'english_name'.tr(),
      pickImageText: 'pick_image'.tr(),
      noImageSelectedText: 'no_image_selected'.tr(),
      saveText: 'save'.tr(),
      cancelText: 'cancel'.tr(),
      deleteText: 'delete'.tr(),
      somethingWentWrongText: 'something_went_wrong'.tr(),
      noResultsFoundText: 'no_results_found'.tr(),
      onEdit: (ctx, id, clientName, description, amount, paymentDueDate, status, s, cityId) {
        ctx.read<PaymentCubit>().editPayment(
          ctx,
          id: id,
          clientName: clientName,
          description: description,
          amount: amount,
          paymentDueDate: paymentDueDate,
          status: status.toString(),
        );
      },
      onDelete: (ctx, id) {
        ctx.read<PaymentCubit>().deletePayment(ctx, id);
      },
      onFetch: (ctx) {
        ctx.read<PaymentCubit>().getPayment(context: ctx);
      },
      getStatus: (state) => state.status,
      getError: (state) => state.error,
      getItems: (state) => state.entity.payments,
    );
  }
}
