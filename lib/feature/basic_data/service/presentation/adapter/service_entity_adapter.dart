import '../../../../../core/widget/list/entity_adapter.dart';
import '../../domain/entity/service_entity.dart';

class ServiceEntityAdapter extends EntityAdapter<ServiceEntity> {
  @override
  String? getId(ServiceEntity entity) => entity.id;

  @override
  String? getPrimaryName(ServiceEntity entity) => entity.title?.en;

  @override
  String? getSecondaryName(ServiceEntity entity) => entity.title?.ar;

  @override
  String? getImageUrl(ServiceEntity entity) => entity.image?.url;

  @override
  String? getCreatorName(ServiceEntity entity) => entity.image?.url;

  @override
  String? getCityName(ServiceEntity entity) => entity.city?.name?.en;

  @override
  String? getCityId(ServiceEntity entity) => entity.city?.id;
  
  @override
  String? getStatus(ServiceEntity entity) => entity.status?.toString();
  
  

  @override
  bool matchesQuery(ServiceEntity entity, String query) {
    final q = query.toLowerCase();
    final ar = (entity.title?.ar ?? '').toLowerCase();
    final en = (entity.title?.en ?? '').toLowerCase();
    return ar.contains(q) || en.contains(q);
  }
}
