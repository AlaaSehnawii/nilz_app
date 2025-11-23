import 'package:nilz_app/core/widget/list/entity_adapter.dart';
import '../../domain/entity/place_type_entity.dart';

class PlaceTypeEntityAdapter extends EntityAdapter<PlaceTypeEntity> {
  @override
  String? getId(PlaceTypeEntity e) => e.id;

  @override
  String? getPrimaryName(PlaceTypeEntity e) => e.name?.en;

  @override
  String? getSecondaryName(PlaceTypeEntity e) => e.name?.ar;

  @override
  String? getImageUrl(PlaceTypeEntity e) => e.icon?.url;

  @override
  String? getCreatorName(PlaceTypeEntity e) => null;

  @override
  String? getCityName(PlaceTypeEntity e) => null;

  @override
  String? getStatus(PlaceTypeEntity e) => null;

  @override
  String? getCityId(PlaceTypeEntity e) => null;

  @override
  bool matchesQuery(PlaceTypeEntity e, String query) {
    final q = query.toLowerCase();
    return (e.name?.en ?? '').toLowerCase().contains(q) ||
        (e.name?.ar ?? '').toLowerCase().contains(q);
  }
}
