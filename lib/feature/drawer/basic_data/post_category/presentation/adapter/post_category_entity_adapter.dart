import 'package:nilz_app/core/widget/list/entity_adapter.dart';
import '../../domain/entity/post_category_entity.dart';

class PostCategoryEntityAdapter extends EntityAdapter<CategoryEntity> {
  @override
  String? getId(CategoryEntity entity) => entity.id;

  @override
  String? getPrimaryName(CategoryEntity entity) => entity.name?.en;

  @override
  String? getSecondaryName(CategoryEntity entity) => entity.name?.ar;

  @override
  String? getImageUrl(CategoryEntity entity) => entity.image?.url;

  @override
  String? getStatus(CategoryEntity entity) => entity.status.toString();

  @override
  String? getCityName(CategoryEntity entity) => null;

  @override
  String? getCreatorName(CategoryEntity entity) => null;

  @override
  String? getCityId(CategoryEntity e) => null;

  @override
  bool matchesQuery(CategoryEntity entity, String query) {
    final q = query.toLowerCase();
    final ar = (entity.name?.ar ?? '').toLowerCase();
    final en = (entity.name?.en ?? '').toLowerCase();
    return ar.contains(q) || en.contains(q);
  }
}
