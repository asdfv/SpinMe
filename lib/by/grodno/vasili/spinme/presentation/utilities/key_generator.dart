/// Interface for generating keys with the prefix.
abstract class KeyGenerator {
  String generate(String prefix);
}

/// Class for generating keys with the prefix and increasing number at the end.
/// To start numeration over just create a new instance.
class IncreasingNumbersKeyGenerator extends KeyGenerator {
  var _counter = 1;

  @override
  String generate(String prefix) => prefix + (_counter++).toString();
}
