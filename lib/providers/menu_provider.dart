import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/cast.dart';
import 'package:peliculas/models/credits_response.dart';
import 'package:peliculas/models/most_popular_response.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/models/now_playing_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '12b3dc31e87cdabbb966319449a518ec';
  final String _languaje = 'es-ES';

  List<Movie> onDisplayMovie = [];
  List<Movie> mostPopularMovieList = [];
  Map<int, List<Cast>> movieCast = {};

  MoviesProvider() {
    getOnDisplayMovies();
    getMostPopularMovies();
    //getActores();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _languaje, 'page': '1'});
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    onDisplayMovie = nowPlayingResponse.results;
    notifyListeners();
  }

  getMostPopularMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'language': _languaje, 'page': '1'});
    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);
    mostPopularMovieList = popularResponse.results;

    notifyListeners();
  }

  Future<List<Cast>> getActores(int movieID) async {
    var url = Uri.https(_baseUrl, '3/movie/$movieID/credits',
        {'api_key': _apiKey, 'language': _languaje, 'page': '1'});
    final response = await http.get(url);
    final actores = CreditResponse.fromJson(response.body);
    movieCast[movieID] = actores.cast;
    return actores.cast;
  }
}
