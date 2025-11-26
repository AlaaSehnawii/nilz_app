class RoomInfo {
  int adults;
  int children;
  List<String> childrenNames;

  RoomInfo({
    required this.adults,
    required this.children,
    List<String>? childrenNames,
  }) : childrenNames = childrenNames ?? List<String>.generate(children, (_) => '');

  RoomInfo copy() {
    return RoomInfo(
      adults: adults,
      children: children,
      childrenNames: List<String>.from(childrenNames),
    );
  }
}
