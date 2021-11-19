/// If you need to add some delay for your calls. Mainly used for development purposes.
Future<T> runDelayed<T>(T Function() block) => Future.delayed(const Duration(milliseconds: 200), () => block());
