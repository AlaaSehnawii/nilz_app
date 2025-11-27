import 'package:nilz_app/core/widget/list/entity_adapter.dart';
import '../../../../../finance/payment/domain/entity/Payment_entity.dart';

class PaymentEntityAdapter extends EntityAdapter<PaymentEntity> {
  @override
  String? getId(PaymentEntity e) => e.id;

  @override
  String? getPrimaryName(PaymentEntity e) => e.clientName;

  @override
  String? getSecondaryName(PaymentEntity e) => null;

  @override
  String? getImageUrl(PaymentEntity e) => null;

  @override
  String? getCreatorName(PaymentEntity e) => null;

  @override
  String? getCityName(PaymentEntity e) => null;

  @override
  String? getStatus(PaymentEntity e) => null;

  @override
  String? getCityId(PaymentEntity e) => null;


  @override
  bool matchesQuery(PaymentEntity entity, String query) {
    final q = query.toLowerCase();
    return (entity.clientName ?? '').toLowerCase().contains(q);
  }
}
