class RoomInfo {
  int adults;
  int children;
  List<int?> childrenAges;

  RoomInfo({
    required this.adults,
    required this.children,
    List<int?>? childrenAges,
  }) : childrenAges = childrenAges ?? [];

  RoomInfo copy() {
    return RoomInfo(
      adults: adults,
      children: children,
      childrenAges: List<int?>.from(childrenAges),
    );
  }
}
