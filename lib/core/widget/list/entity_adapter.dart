
//  Adapter to extract display information from any entity type
abstract class EntityAdapter<T> {
  String? getId(T entity);
  String? getPrimaryName(T entity);
  String? getSecondaryName(T entity);
  String? getImageUrl(T entity);
  String? getCreatorName(T entity);
  String? getStatus(T entity);
  String? getCityName(T entity);
  String? getCityId(T entity);


  //  Custom filter logic for search
  bool matchesQuery(T entity, String query) {
    final q = query.toLowerCase();
    final primary = (getPrimaryName(entity) ?? '').toLowerCase();
    final secondary = (getSecondaryName(entity) ?? '').toLowerCase();
    return primary.contains(q) || secondary.contains(q);
  }
}