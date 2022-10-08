import 'package:buuk_test/core/api/error/failures.dart';
import 'package:buuk_test/features/movie_detail/domain/model/response_movie_detail_model.dart';
import 'package:buuk_test/features/movie_detail/domain/repository/movie_detail_repository.dart';
import 'package:dartz/dartz.dart';

class GetMovieDetailCase {
  final MovieDetailRepository? movieDetailRepository;

  GetMovieDetailCase({
    this.movieDetailRepository,
  });

  Future<Either<Failure, ResponseMovieDetailModel>> getMovieDetail(int movieId) async =>
      movieDetailRepository!.getMovieDetail(movieId);
}
