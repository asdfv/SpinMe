/// Converts string to enum.
/// [values] - enum values to parse.
/// Returns null if nothing found.
/// Ignores case.
extension EnumFromString on String {
  T? enumFromString<T>(Iterable<T> values) {
    return values.firstWhere((type) => type.toString().split(".").last.toLowerCase() == this.toLowerCase(),
        orElse: null);
  }
}
