import 'package:buuk_test/core/api/error/failures.dart';
import 'package:buuk_test/core/api/service/base/rest_service.dart';
import 'package:buuk_test/features/movie_detail/domain/model/response_movie_detail_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class MovieDetailDatasource {
  Future<Either<Failure, ResponseMovieDetailModel>> getMovieDetail(int movieId);
}

class MovieDetailDataSourceImpl extends MovieDetailDatasource {
  final RestService? restService;

  MovieDetailDataSourceImpl({
    @required this.restService,
  });

  @override
  Future<Either<Failure, ResponseMovieDetailModel>> getMovieDetail(int movieId) async {
    try {
      ResponseMovieDetailModel? responseMovieDetailModel = await restService!.getMovieDetail(movieId);
      return Right(responseMovieDetailModel);
    } on DioError catch (e) {
      if (e.response == null) {
        return Left(NoConnectionFailure(mess: 'No connection'));
      } else {
        return Left(
          ServerFailure(
            mess: e.response!.statusMessage,
            statusCode: e.response!.statusCode,
          ),
        );
      }
    }
  }
}
