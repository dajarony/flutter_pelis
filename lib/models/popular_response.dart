// To parse this JSON data, do
//
//     final popularresponse = popularresponseFromMap(jsonString);

import 'dart:convert';

import 'movie.dart';

class Popularresponse {
  Popularresponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory Popularresponse.fromJson(String str) =>
      Popularresponse.fromMap(json.decode(str));

  factory Popularresponse.fromMap(Map<String, dynamic> json) => Popularresponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
