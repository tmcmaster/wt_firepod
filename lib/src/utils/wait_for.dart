mixin WaitFor {
  static Future<T> twoFutures<T, A, B>(
    Future<A> f1,
    Future<B> f2,
    T Function(A r1, B r2) builder,
  ) async {
    final results = await Future.wait([f1, f2]);
    return builder(results[0] as A, results[1] as B);
  }

  static Future<T> threeFutures<T, A, B, C>(
    Future<A> f1,
    Future<B> f2,
    Future<C> f3,
    T Function(A r1, B r2, C r3) builder,
  ) async {
    final results = await Future.wait([f1, f2, f3]);
    return builder(results[0] as A, results[1] as B, results[2] as C);
  }
}
