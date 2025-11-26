import 'package:nilz_app/core/widget/list/entity_adapter.dart';
import '../../domain/entity/unit_type_entity.dart';

class UnitTypeEntityAdapter extends EntityAdapter<UnitTypeEntity> {
  @override
  String? getId(UnitTypeEntity e) => e.id;

  @override
  String? getPrimaryName(UnitTypeEntity e) => e.name?.en;

  @override
  String? getSecondaryName(UnitTypeEntity e) => e.name?.ar;

  @override
  String? getImageUrl(UnitTypeEntity e) => e.icon?.url;

  @override
  String? getCreatorName(UnitTypeEntity e) => null;

  @override
  String? getCityName(UnitTypeEntity e) => null;

  @override
  String? getStatus(UnitTypeEntity e) => null;

  @override
  String? getCityId(UnitTypeEntity e) => null;


  @override
  bool matchesQuery(UnitTypeEntity entity, String query) {
    final q = query.toLowerCase();
    return (entity.name?.en ?? '').toLowerCase().contains(q) ||
        (entity.name?.ar ?? '').toLowerCase().contains(q);
  }
}
