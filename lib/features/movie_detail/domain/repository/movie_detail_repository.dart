import 'package:buuk_test/core/api/error/failures.dart';
import 'package:buuk_test/features/movie_detail/data/movie_detail_datasource.dart';
import 'package:buuk_test/features/movie_detail/domain/model/response_movie_detail_model.dart';
import 'package:dartz/dartz.dart';

abstract class MovieDetailRepository {
  Future<Either<Failure, ResponseMovieDetailModel>> getMovieDetail(int movieId);
}

class MovieDetailRepositoryImpl extends MovieDetailRepository {
  final MovieDetailDatasource? movieDetailDatasource;

  MovieDetailRepositoryImpl({
    this.movieDetailDatasource,
  });

  @override
  Future<Either<Failure, ResponseMovieDetailModel>> getMovieDetail(int movieId) async {
    return await movieDetailDatasource!.getMovieDetail(movieId);
  }
}
