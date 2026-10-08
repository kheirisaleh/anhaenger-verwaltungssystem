class AppUser {
  const AppUser({
    required this.id,
    required this.name,
    required this.isActive,
  });

  final int id;
  final String name;
  final bool isActive;
}
