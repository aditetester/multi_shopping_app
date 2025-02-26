class Category {
  final String id;
  final String title;
  final String image;

  const Category({
    required this.id,
    required this.title,
    this.image = '',
  });
}
