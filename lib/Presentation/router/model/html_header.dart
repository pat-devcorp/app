class HTMLHeader {
  final bool indexed;
  final int title;
  final int description;
  final int keywords;

  const HTMLHeader({
    this.indexed = false,
    this.title = -1,
    this.description = -1,
    this.keywords = -1,
  });
}