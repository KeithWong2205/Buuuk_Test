import 'package:buuk_test/core/api/error/failures.dart';
import 'package:buuk_test/core/api/service/base/rest_service.dart';
import 'package:buuk_test/features/movie_list/domain/model/response_movie_list_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class MovieListDataSource {
  Future<Either<Failure, ResponseMovieListModel>> getNowPlayingList(int page);
}

class MovieListDataSourceImpl extends MovieListDataSource {
  final RestService? restService;

  MovieListDataSourceImpl({
    @required this.restService,
  });

  @override
  Future<Either<Failure, ResponseMovieListModel>> getNowPlayingList(int page) async {
    try {
      ResponseMovieListModel? responseMovieListModel = await restService!.getNowPlayingMovies(page);
      return Right(responseMovieListModel);
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
