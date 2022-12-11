class Author {
  final String name;
  final String? profilePicture;

  Author({
    required this.name,
    required this.profilePicture,
  });

  factory Author.fromMap({
    required String name,
    required String? profilePicture,
  }) {
    return Author(
      name: name,
      profilePicture: profilePicture,
    );
  }
}
