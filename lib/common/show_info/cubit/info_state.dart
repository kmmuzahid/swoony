enum InfoType { about_us, terms, privacy }

class InfoState {
  InfoState({this.isLoading = false, this.content});

  final bool isLoading;
  final String? content;

  InfoState copyWith({bool? isLoading, String? content}) {
    return InfoState(isLoading: isLoading ?? this.isLoading, content: content ?? this.content);
  }

  @override
  bool operator ==(covariant InfoState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading && other.content == content;
  }

  @override
  int get hashCode => isLoading.hashCode ^ content.hashCode;
}
