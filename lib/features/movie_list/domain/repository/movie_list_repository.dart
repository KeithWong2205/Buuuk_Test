import 'package:buuk_test/core/api/error/failures.dart';
import 'package:buuk_test/features/movie_list/data/movie_list_data_source.dart';
import 'package:buuk_test/features/movie_list/domain/model/response_movie_list_model.dart';
import 'package:dartz/dartz.dart';

abstract class MovieListRepository {
  Future<Either<Failure, ResponseMovieListModel>> getNowPlayingMovies(int page);
}

class MovieListRepositoryImpl extends MovieListRepository {
  final MovieListDataSource? movieListDataSource;

  MovieListRepositoryImpl({
    this.movieListDataSource,
  });

  @override
  Future<Either<Failure, ResponseMovieListModel>> getNowPlayingMovies(int page) async {
    return await movieListDataSource!.getNowPlayingList(page);
  }
}
