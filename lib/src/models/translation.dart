import 'dart:convert';

class Translation {
  int? id;
  String? name;
  String? abbreviation;
  String? language;

  Translation({
    this.id,
    this.name,
    this.abbreviation,
    this.language,
  });

  Translation copyWith({
    int? id,
    String? name,
    String? abbreviation,
    String? language,
  }) {
    return Translation(
      id: id ?? this.id,
      name: name ?? this.name,
      abbreviation: abbreviation ?? this.abbreviation,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'abbreviation': abbreviation,
      'language': language,
    };
  }

  factory Translation.fromMap(Map<String, dynamic> map) {
    return Translation(
      id: map['id'],
      name: map['version'],
      abbreviation: map['abbreviation'],
      language: map['language'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Translation.fromJson(String source) =>
      Translation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Version(id: $id, name: $name, abbreviation: $abbreviation, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Translation &&
        other.id == id &&
        other.name == name &&
        other.abbreviation == abbreviation &&
        other.language == language;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        abbreviation.hashCode ^
        language.hashCode;
  }
}
