import 'package:dartz/dartz.dart';
import 'package:movies/models/movie_detail_model.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/models/movie_response_model.dart';
import 'package:movies/models/movie_video_model.dart';
import 'package:movies/models/movie_video_response.dart';
import '../errors/movie_error.dart';
import '../repositories/movie_repository.dart';

class MovieDetailController {
  final _repository = MovieRepository();

  MovieResponseModel movieResponseModel;
  MovieVideoResponse movieVideoResponse;
  MovieDetailModel movieDetail;
  MovieError movieError;

  List<MovieModel> get similarMovies => movieResponseModel?.movies ?? <MovieModel>[];
  int get similarMoviesCount => similarMovies.length ?? 0;

  List<MovieVideoModel> get videos => movieVideoResponse?.movieVideos ?? <MovieVideoModel>[];
  int get moviesCount => videos.length ?? 0;

  bool loading = true;

  Future<Either<MovieError, MovieDetailModel>> fetchMovieById(int id) async {

    final result = await _repository.fetchMovieById(id);
    result.fold(
      (error) => movieError = error,
      (detail) => movieDetail = detail,
    );
    return result;
  }

  Future<Either<MovieError, MovieVideoResponse>> fetchMovieVideo(int id) async {
    final result = await _repository.fetchMovieVideos(id);
    result.fold(
      (l) => movieError = l,
      (r) => movieVideoResponse = r,
    );
    return result;
  }

  Future<Either<MovieError, MovieResponseModel>> fetchSimilarMovies(int id) async {
    movieError = null;
    final result = await _repository.fetchSimilarMovies(id);
    result.fold(
      (l) => movieError = l,
      (r) => movieResponseModel = r,
    );
    return result;
  }
}
