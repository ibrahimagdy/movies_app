import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants.dart';
import '../../core/network_layer/api_manger.dart';
import '../../model/details_model.dart';
import '../../model/movie_model.dart';

class HomeViewModel extends ChangeNotifier {
  DetailsModel? _selectedMovie;
  List<MovieModel> _popularMovies = [];
  List<MovieModel> _newReleaseMovies = [];
  List<MovieModel> _recommendMovies = [];
  List<MovieModel> _similarMovies = [];

  DetailsModel? get selectedMovie => _selectedMovie;

  List<MovieModel> get popularMovies => _popularMovies;

  List<MovieModel> get newReleaseMovies => _newReleaseMovies;

  List<MovieModel> get recommendMovies => _recommendMovies;

  List<MovieModel> get similarMovies => _similarMovies;

  Future<void> toggleFavorite(MovieModel movie) async {
    movie.isFavorite = !movie.isFavorite!;
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteMovieIds = _popularMovies
        .where((movie) => movie.isFavorite == true)
        .map((movie) => movie.id.toString())
        .toList();
    prefs.setStringList('favoriteMovies', favoriteMovieIds);
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favoriteMovieIds =
        prefs.getStringList('favoriteMovies') ?? [];

    for (var movie in _popularMovies) {
      if (favoriteMovieIds.contains(movie.id.toString())) {
        movie.isFavorite = true;
      } else {
        movie.isFavorite = false;
      }
    }
    notifyListeners();
  }

  // Call this method when initializing the HomeViewModel
  Future<void> init() async {
    await getPopularMovies();
    await _loadFavorites();
  }

  getPopularMovies() async {
    try {
      var response = await ApiManager.fetchPopular();
      _popularMovies = response.results!;

      for (int i = 0; i < _popularMovies.length; i++) {
        for (int j = 0; j < Constants.favoriteMovies.length; j++) {
          if (_popularMovies[i].id == Constants.favoriteMovies[j].id) {
            _popularMovies[i].isFavorite = true;
            break;
          }
        }
      }

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  getNewReleasesMovies() async {
    try {
      var response = await ApiManager.fetchNewReleases();
      _newReleaseMovies = response.results!;

      for (int i = 0; i < _newReleaseMovies.length; i++) {
        for (int j = 0; j < Constants.favoriteMovies.length; j++) {
          if (_newReleaseMovies[i].id == Constants.favoriteMovies[j].id) {
            _newReleaseMovies[i].isFavorite = true;
            break;
          }
        }
      }

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  getRecommendMovies() async {
    try {
      var response = await ApiManager.fetchRecommend();
      _recommendMovies = response.results!;

      for (int i = 0; i < _recommendMovies.length; i++) {
        for (int j = 0; j < Constants.favoriteMovies.length; j++) {
          if (_recommendMovies[i].id == Constants.favoriteMovies[j].id) {
            _recommendMovies[i].isFavorite = true;
            break;
          }
        }
      }

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  getSimilarMovies(int? movieId) async {
    try {
      var response = await ApiManager.fetchSimilar(movieId!);
      _similarMovies = response.results!;

      for (int i = 0; i < _similarMovies.length; i++) {
        for (int j = 0; j < Constants.favoriteMovies.length; j++) {
          if (_similarMovies[i].id == Constants.favoriteMovies[j].id) {
            _similarMovies[i].isFavorite = true;
            break;
          }
        }
      }

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  getMovieDetails(MovieModel model) async {
    _selectedMovie = await ApiManager.fetchDetails(model.id!);

    for (int i = 0; i < Constants.favoriteMovies.length; i++) {
      if (_selectedMovie!.id == Constants.favoriteMovies[i].id) {
        _selectedMovie!.isFavorite = true;
        break;
      }
    }
    notifyListeners();
  }
}
