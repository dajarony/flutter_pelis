// To parse this JSON data, do
//
//     final nowplayingresponse = nowplayingresponseFromMap(jsonString);

import 'dart:convert';

import 'movie.dart';

class Nowplayingresponse {
  Nowplayingresponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Dates dates;
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory Nowplayingresponse.fromJson(String str) =>
      Nowplayingresponse.fromMap(json.decode(str));

  factory Nowplayingresponse.fromMap(Map<String, dynamic> json) =>
      Nowplayingresponse(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Dates {
  Dates({
    required this.maximum,
    required this.minimum,
  });

  DateTime maximum;
  DateTime minimum;

  factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

  factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );
}
