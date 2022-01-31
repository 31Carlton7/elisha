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

import 'package:elisha/src/models/reading.dart';

class DailyReading {
  String? name;
  String? lectionary;
  DateTime? date;
  List<Reading>? readings;

  DailyReading({
    this.name,
    this.lectionary,
    this.date,
    this.readings,
  });

  DailyReading copyWith({
    String? name,
    String? lectionary,
    DateTime? date,
    List<Reading>? readings,
  }) {
    return DailyReading(
      name: name ?? this.name,
      lectionary: lectionary ?? this.lectionary,
      date: date ?? this.date,
      readings: readings ?? this.readings,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lectionary': lectionary,
      'date': date?.millisecondsSinceEpoch,
      'readings': readings?.map((x) => x.toMap()).toList(),
    };
  }

  factory DailyReading.fromMap(Map<String, dynamic> map) {
    return DailyReading(
      name: map['name'],
      lectionary: map['lectionary'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      readings: List<Reading>.from(map['readings']?.map((x) => Reading.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyReading.fromJson(String source) => DailyReading.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DailyReading(name: $name, lectionary: $lectionary, date: $date, readings: $readings)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DailyReading &&
        other.name == name &&
        other.lectionary == lectionary &&
        other.date == date &&
        listEquals(other.readings, readings);
  }

  @override
  int get hashCode {
    return name.hashCode ^ lectionary.hashCode ^ date.hashCode ^ readings.hashCode;
  }
}
