import 'package:bloc/bloc.dart';
import 'package:buuk_test/core/api/error/failures.dart';
import 'package:buuk_test/features/movie_detail/domain/model/response_movie_detail_model.dart';
import 'package:buuk_test/features/movie_detail/domain/usecase/get_movie_detail_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetailCase? getMovieDetailCase;

  MovieDetailCubit({
    this.getMovieDetailCase,
  }) : super(MovieDetailInitial());

  getMovieDetail(int movieId) async {
    Either<Failure, ResponseMovieDetailModel> movieDetailResult = await getMovieDetailCase!.getMovieDetail(movieId);
    movieDetailResult.fold(
      (l) => emit(MovieDetailFetchFailed()),
      (r) => emit(MovieDetailFetchSuccess(responseMovieDetailModel: r)),
    );
  }
}
