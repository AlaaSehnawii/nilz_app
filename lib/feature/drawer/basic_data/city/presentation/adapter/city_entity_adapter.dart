import '../../../../../../core/widget/list/entity_adapter.dart';
import '../../domain/entity/city_entity.dart';

class CityEntityAdapter extends EntityAdapter<CityEntity> {
  @override
  String? getId(CityEntity entity) => entity.id;

  @override
  String? getPrimaryName(CityEntity entity) => entity.name?.en;

  @override
  String? getSecondaryName(CityEntity entity) => entity.name?.ar;

  @override
  String? getImageUrl(CityEntity entity) => entity.image?.url;

  @override
  String? getCreatorName(CityEntity entity) => entity.createdBy?.fullName;

  @override
  String? getCityName(CityEntity e) => null;

  @override
  String? getStatus(CityEntity e) => null;

  @override
  String? getCityId(CityEntity e) => null;

  @override
  bool matchesQuery(CityEntity entity, String query) {
    final q = query.toLowerCase();
    final ar = (entity.name?.ar ?? '').toLowerCase();
    final en = (entity.name?.en ?? '').toLowerCase();
    return ar.contains(q) || en.contains(q);
  }
}
