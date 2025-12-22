import 'dart:convert';

class FaqModel {
  final String type;
  final String title;
  final String content;
  final String question;
  final String answer;

  const FaqModel({
    required this.type,
    required this.title,
    required this.content,
    required this.question,
    required this.answer,
  });

  //empty model
  factory FaqModel.empty() => FaqModel(type: '', title: '', content: '', question: '', answer: '');

  /// Create an InfoModel from a Map (decoded JSON)
  factory FaqModel.fromMap(Map<String, dynamic> map) {
    return FaqModel(
      type: map['type']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      content: map['content']?.toString() ?? '',
      question: map['question']?.toString() ?? '',
      answer: map['answer']?.toString() ?? '',
    );
  }

  /// Convert the InfoModel to a Map (for encoding to JSON)
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'title': title,
      'content': content,
      'question': question,
      'answer': answer,
    };
  }

  /// Create from a JSON string
  factory FaqModel.fromJson(String source) => FaqModel.fromMap(json.decode(source));

  /// Convert to JSON string
  String toJson() => json.encode(toMap());

  /// Creates a copy with optional changed fields
  FaqModel copyWith({
    String? type,
    String? title,
    String? content,
    String? question,
    String? answer,
  }) {
    return FaqModel(
      type: type ?? this.type,
      title: title ?? this.title,
      content: content ?? this.content,
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }

  @override
  String toString() {
    return 'InfoModel(type: $type, title: $title, content: $content, question: $question, answer: $answer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FaqModel &&
        other.type == type &&
        other.title == title &&
        other.content == content &&
        other.question == question &&
        other.answer == answer;
  }

  @override
  int get hashCode {
    return type.hashCode ^ title.hashCode ^ content.hashCode ^ question.hashCode ^ answer.hashCode;
  }
}
