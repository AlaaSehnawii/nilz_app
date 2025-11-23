import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widget/list/generic_entity_container.dart';
import '../../../domain/entity/Payment_entity.dart';
import '../../adapter/payment_entity_adapter.dart';
import '../../cubit/payment_cubit.dart';

class PaymentContainer extends StatelessWidget {
  final PaymentEntity payment;

  const PaymentContainer({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return GenericEntityContainer<PaymentEntity, PaymentCubit>(
      entity: payment,
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
      onEdit: (ctx, id,  clientName, description, amount, paymentDueDate, status, s, cityId) {
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
    );
  }
}
