import 'dart:convert';

class TranslationBookChapter {
  String? translationAbb;
  int? translation;
  int? book;
  int? chapter;

  TranslationBookChapter({
    this.translationAbb,
    this.translation,
    this.book,
    this.chapter,
  });

  TranslationBookChapter copyWith({
    String? translationAbb,
    int? translation,
    int? book,
    int? chapter,
  }) {
    return TranslationBookChapter(
      translationAbb: translationAbb ?? this.translationAbb,
      translation: translation ?? this.translation,
      book: book ?? this.book,
      chapter: chapter ?? this.chapter,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'translationAbb': translationAbb,
      'translation': translation,
      'book': book,
      'chapter': chapter,
    };
  }

  factory TranslationBookChapter.fromMap(Map<String, dynamic> map) {
    return TranslationBookChapter(
      translationAbb: map['translationAbb'],
      translation: map['translation'],
      book: map['book'],
      chapter: map['chapter'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TranslationBookChapter.fromJson(String source) =>
      TranslationBookChapter.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TranslationBookChapter(translationAbb: $translationAbb, translation: $translation, book: $book, chapter: $chapter)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TranslationBookChapter &&
        other.translationAbb == translationAbb &&
        other.translation == translation &&
        other.book == book &&
        other.chapter == chapter;
  }

  @override
  int get hashCode {
    return translationAbb.hashCode ^
        translation.hashCode ^
        book.hashCode ^
        chapter.hashCode;
  }
}
