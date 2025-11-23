import 'package:nilz_app/core/widget/list/entity_adapter.dart';
import '../../domain/entity/bed_type_entity.dart';

class BedTypeEntityAdapter extends EntityAdapter<BedTypeEntity> {
  @override
  String? getId(BedTypeEntity e) => e.id;

  @override
  String? getPrimaryName(BedTypeEntity e) => e.name?.en;

  @override
  String? getSecondaryName(BedTypeEntity e) => e.name?.ar;

  @override
  String? getImageUrl(BedTypeEntity e) => e.icon?.url;

  @override
  String? getCreatorName(BedTypeEntity e) => null;

  @override
  String? getCityName(BedTypeEntity e) => null;

  @override
  String? getStatus(BedTypeEntity e) => null;

  @override
  String? getCityId(BedTypeEntity e) => null;

  @override
  bool matchesQuery(BedTypeEntity e, String query) {
    final q = query.toLowerCase();
    return (e.name?.en ?? '').toLowerCase().contains(q) ||
        (e.name?.ar ?? '').toLowerCase().contains(q);
  }

}
