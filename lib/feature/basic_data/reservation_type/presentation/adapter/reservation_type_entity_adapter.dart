import 'package:nilz_app/core/widget/list/entity_adapter.dart';
import '../../domain/entity/Reservation_type_entity.dart';

class ReservationTypeEntityAdapter
    extends EntityAdapter<ReservationTypeEntity> {
  @override
  String? getId(ReservationTypeEntity e) => e.id;

  @override
  String? getPrimaryName(ReservationTypeEntity e) => e.name?.en;

  @override
  String? getSecondaryName(ReservationTypeEntity e) => e.name?.ar;

  @override
  String? getCityName(ReservationTypeEntity entity) => null;

  @override
  String? getCreatorName(ReservationTypeEntity entity) => null;

  @override
  String? getImageUrl(ReservationTypeEntity entity) => null;

  @override
  String? getStatus(ReservationTypeEntity entity) => null;

  @override
  String? getCityId(ReservationTypeEntity entity) => null;

  @override
  bool matchesQuery(ReservationTypeEntity entity, String query) {
    final q = query.toLowerCase();
    return (entity.name?.en ?? '').toLowerCase().contains(q) ||
        (entity.name?.ar ?? '').toLowerCase().contains(q);
  }
}
