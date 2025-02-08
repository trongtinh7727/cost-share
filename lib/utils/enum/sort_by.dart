enum SortBy {
  HIGHEST,
  LOWEST,
  NEWEST,
  OLDEST,
}

extension SortByExtension on SortBy {
  String get name {
    switch (this) {
      case SortBy.HIGHEST:
        return 'Highest';
      case SortBy.LOWEST:
        return 'Lowest';
      case SortBy.NEWEST:
        return 'Newest';
      case SortBy.OLDEST:
        return 'Oldest';
      default:
        return 'none';
    }
  }
}
