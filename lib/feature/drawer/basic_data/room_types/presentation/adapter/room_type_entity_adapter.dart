import 'package:nilz_app/core/widget/list/entity_adapter.dart';
import '../../domain/entity/room_type_entity.dart';

class RoomTypeEntityAdapter extends EntityAdapter<RoomTypeEntity> {
  @override
  String? getId(RoomTypeEntity e) => e.id;

  @override
  String? getPrimaryName(RoomTypeEntity e) => e.name?.en;

  @override
  String? getSecondaryName(RoomTypeEntity e) => e.name?.ar;

  @override
  String? getImageUrl(RoomTypeEntity e) => e.icon?.url;

  @override
  String? getCreatorName(RoomTypeEntity e) => null;

  @override
  String? getCityName(RoomTypeEntity e) => null;

  @override
  String? getStatus(RoomTypeEntity e) => null;

  @override
  String? getCityId(RoomTypeEntity e) => null;

  @override
  bool matchesQuery(RoomTypeEntity entity, String query) {
    final q = query.toLowerCase();
    return (entity.name?.en ?? '').toLowerCase().contains(q) ||
        (entity.name?.ar ?? '').toLowerCase().contains(q);
  }
}
