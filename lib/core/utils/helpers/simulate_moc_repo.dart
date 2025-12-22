Future SimulateMocRepo() async {
  await Future.delayed(const Duration(milliseconds: 500));
}

List<T> generateMockList<T>({required T Function(int index) builder}) => [for (int i = 0; i < 10; i++) builder(i)];
