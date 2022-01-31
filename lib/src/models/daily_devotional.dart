/*
Elisha iOS & Android App
Copyright (C) 2022 Carlton Aikins

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'dart:convert';

import 'package:flutter/foundation.dart';

class DailyDevotional {
  String title;
  DateTime date;
  List<DailyDevotionalSection> sections;

  DailyDevotional({
    required this.title,
    required this.date,
    required this.sections,
  });

  DailyDevotional copyWith({
    String? title,
    DateTime? date,
    List<DailyDevotionalSection>? sections,
  }) {
    return DailyDevotional(
      title: title ?? this.title,
      date: date ?? this.date,
      sections: sections ?? this.sections,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date.millisecondsSinceEpoch,
      'sections': sections.map((x) => x.toMap()).toList(),
    };
  }

  factory DailyDevotional.fromMap(Map<String, dynamic> map) {
    return DailyDevotional(
      title: map['title'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      sections: List<DailyDevotionalSection>.from(map['sections']?.map((x) => DailyDevotionalSection.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyDevotional.fromJson(String source) => DailyDevotional.fromMap(json.decode(source));

  @override
  String toString() => 'DailyDevotional(title: $title, date: $date, sections: $sections)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DailyDevotional &&
        other.title == title &&
        other.date == date &&
        listEquals(other.sections, sections);
  }

  @override
  int get hashCode => title.hashCode ^ date.hashCode ^ sections.hashCode;
}

class DailyDevotionalSection {
  String title;
  String? subtitle;
  String content;

  DailyDevotionalSection({
    required this.title,
    this.subtitle,
    required this.content,
  });

  DailyDevotionalSection copyWith({
    String? title,
    String? subtitle,
    String? content,
  }) {
    return DailyDevotionalSection(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'content': content,
    };
  }

  factory DailyDevotionalSection.fromMap(Map<String, dynamic> map) {
    return DailyDevotionalSection(
      title: map['title'] ?? '',
      subtitle: map['subtitle'],
      content: map['content'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyDevotionalSection.fromJson(String source) => DailyDevotionalSection.fromMap(json.decode(source));

  @override
  String toString() => 'DailyDevotionalSection(title: $title, subtitle: $subtitle, content: $content)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DailyDevotionalSection &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.content == content;
  }

  @override
  int get hashCode => title.hashCode ^ subtitle.hashCode ^ content.hashCode;
}
