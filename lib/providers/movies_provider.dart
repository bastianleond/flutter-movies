
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/models.dart';

class MoviesProvider extends ChangeNotifier{

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = 'c23a82a503d34d553672eddfdd00ae44';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider(){
      getNowPlayingMovies();
      getPopularMovies();
  }

  Future<String> _getJsonData( String endpoint, [int page = 1] ) async {
    var url = Uri.https(_baseUrl, endpoint,{
      'api_key': _apiKey,
      'language': _language,
      'page': '$page'
    });

    final response = await http.get(url);
    return response.body;
  }

  getNowPlayingMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final NowPlayingResponse nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final PopularResponse popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [ ...popularMovies, ...popularResponse.results ];
    notifyListeners();
  }

  Future <List<Cast>> getMovieCast(int movieId) async {

    if ( moviesCast.containsKey(movieId) ) {
      return moviesCast[movieId]!;
    }
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final CreditsResponse creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;


  }


}