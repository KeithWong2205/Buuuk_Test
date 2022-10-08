import 'package:buuk_test/core/api/error/failures.dart';
import 'package:bloc/bloc.dart';
import 'package:buuk_test/features/movie_list/domain/model/response_movie_list_model.dart';
import 'package:buuk_test/features/movie_list/domain/usecase/get_now_playing_list_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  final GetNowPlayingListCase? getNowPlayingListCase;

  MovieListCubit({
    this.getNowPlayingListCase,
  }) : super(MovieListInitial());

  getNowPlayingMovies(int page) async {
    Either<Failure, ResponseMovieListModel> movieListResult = await getNowPlayingListCase!.getNowPlayingMovies(page);
    movieListResult.fold(
        (l) => emit(MovieListFetchFailed()),
        (r) => emit(
              MovieListFetchSuccess(responseMovieListModel: r),
            ));
  }
}
