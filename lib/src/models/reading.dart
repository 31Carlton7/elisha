import 'dart:convert';

class Reading {
  String? name;
  String? snippetAddress;
  String? text;
  Reading({
    this.name,
    this.snippetAddress,
    this.text,
  });

  Reading copyWith({
    String? name,
    String? snippetAddress,
    String? text,
  }) {
    return Reading(
      name: name ?? this.name,
      snippetAddress: snippetAddress ?? this.snippetAddress,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'snippetAddress': snippetAddress,
      'text': text,
    };
  }

  factory Reading.fromMap(Map<String, dynamic> map) {
    return Reading(
      name: map['name'],
      snippetAddress: map['snippetAddress'],
      text: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Reading.fromJson(String source) =>
      Reading.fromMap(json.decode(source));

  @override
  String toString() =>
      'Reading(name: $name, snippetAddress: $snippetAddress, text: $text)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reading &&
        other.name == name &&
        other.snippetAddress == snippetAddress &&
        other.text == text;
  }

  @override
  int get hashCode => name.hashCode ^ snippetAddress.hashCode ^ text.hashCode;
}
