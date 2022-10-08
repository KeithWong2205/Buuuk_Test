import 'package:buuk_test/core/api/error/failures.dart';
import 'package:buuk_test/features/movie_list/domain/model/response_movie_list_model.dart';
import 'package:buuk_test/features/movie_list/domain/repository/movie_list_repository.dart';
import 'package:dartz/dartz.dart';

class GetMoreMoviesCase {
  final MovieListRepository? movieListRepository;

  GetMoreMoviesCase({
    this.movieListRepository,
  });

  Future<Either<Failure, ResponseMovieListModel>> getNowPlayingMovies(int page) async =>
      movieListRepository!.getNowPlayingMovies(page);
}
