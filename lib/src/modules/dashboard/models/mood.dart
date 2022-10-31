class Mood {
  final String id;
  final String icon;
  final String name;
  bool isSelected;

  Mood({
    required this.id,
    required this.icon,
    required this.name,
    this.isSelected = false,
  });
}
