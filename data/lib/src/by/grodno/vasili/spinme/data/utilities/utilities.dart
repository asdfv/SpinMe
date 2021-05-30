Future<T> runDelayed<T>(T Function() block) => Future.delayed(const Duration(milliseconds: 200), () => block());
