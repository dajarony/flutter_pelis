import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_pelis/models/credits_response.dart';
import 'package:flutter_pelis/models/movie.dart';
import 'package:flutter_pelis/models/now_playing.dart';
import 'package:flutter_pelis/models/popular_response.dart';
import 'package:http/http.dart' as http;

class MovieProviders extends ChangeNotifier {
  String _ApiKey = '5d3ee809172367e6f19c5b3c9fb326f7';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';
  List<Movie> OndisplayMovie = [];
  List<Movie> PopularMovies = [];
  Map<int, List<Cast>> movieCast = {};
  int _popularpage = 0;
  MovieProviders() {
    print('MovieProviders inicializado');

    this.getOndisplayMovie();
    this.getPopularMovie();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint,
        {'api_key': _ApiKey, 'language': _language, 'page': '$page'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOndisplayMovie() async {
    final jasondata = await this._getJsonData('/3/movie/now_playing');

    final nowplayingresponse = Nowplayingresponse.fromJson(jasondata);

    this.OndisplayMovie = nowplayingresponse.results;
    notifyListeners();
  }

  getPopularMovie() async {
    _popularpage++;
    final jasondata = await this._getJsonData('/3/movie/popular', _popularpage);
    final popularresponse = Popularresponse.fromJson(jasondata);

    PopularMovies = [...PopularMovies, ...popularresponse.results];
    print(PopularMovies[0].title);
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) {
      return movieCast[movieId]!;
    }
    print('pidiendo info al servidor para el movieId $movieId');
    final jasondata = await this._getJsonData('/3/movie/$movieId/credits');
    final creditsresponse = CreditsResponse.fromJson(jasondata);

    movieCast[movieId] = creditsresponse.cast;
    return creditsresponse.cast;
  }
}
