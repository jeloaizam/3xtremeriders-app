/// Shared filter state for the Search screen (spots/riders/events tabs).
///
/// A single query drives all three tabs (only the active tab's provider is
/// actually watched) — see `SearchScreen`. `sportIdsKey` is a sorted
/// comma-joined string (e.g. `"1,3"`) rather than a `Set<int>`/`List<int>`:
/// plain Dart collections use identity equality, so a fresh `{...}` literal
/// on every rebuild would never compare equal to the previous one and
/// defeat each search provider family's caching (constant refetch loops
/// even when the actual filter didn't change).
typedef SearchQuery = ({
  String? q,
  String sportIdsKey,
  int? difficulty,
  String? bestSeason,
  String? hazardLevel,
  double? lat,
  double? lng,
  double? radiusKm,
});

List<int> searchQuerySportIds(String sportIdsKey) {
  return sportIdsKey.isEmpty
      ? const []
      : sportIdsKey.split(',').map(int.parse).toList();
}
