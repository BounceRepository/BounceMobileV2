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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'icon': icon,
      'name': name,
    };
  }

  factory Mood.fromJson(Map<String, dynamic> json) {
    return Mood(
      id: json['id'] as String,
      icon: json['icon'] as String,
      name: json['name'] as String,
    );
  }
}
