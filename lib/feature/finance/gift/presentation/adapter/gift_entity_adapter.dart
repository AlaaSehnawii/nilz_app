import 'package:nilz_app/core/widget/list/entity_adapter.dart';
import '../../domain/entity/gift_entity.dart';

class GiftEntityAdapter extends EntityAdapter<GiftEntity> {
  @override
  String? getId(GiftEntity e) => e.id;

  @override
  String? getPrimaryName(GiftEntity e) => e.name?.en;

  @override
  String? getSecondaryName(GiftEntity e) => e.name?.ar;

  @override
  String? getImageUrl(GiftEntity e) => e.image?.url;

  @override
  String? getCreatorName(GiftEntity e) => null;

  @override
  String? getCityName(GiftEntity e) => null;

  @override
  String? getStatus(GiftEntity e) => null;

  @override
  String? getCityId(GiftEntity e) => null;


  @override
  bool matchesQuery(GiftEntity entity, String query) {
    final q = query.toLowerCase();
    return (entity.name?.en ?? '').toLowerCase().contains(q) ||
        (entity.name?.ar ?? '').toLowerCase().contains(q);
  }
}
