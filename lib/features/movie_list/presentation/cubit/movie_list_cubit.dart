import 'package:buuk_test/core/api/error/failures.dart';
import 'package:bloc/bloc.dart';
import 'package:buuk_test/features/movie_list/domain/model/response_movie_list_model.dart';
import 'package:buuk_test/features/movie_list/domain/usecase/get_more_movies_case.dart';
import 'package:buuk_test/features/movie_list/domain/usecase/get_now_playing_list_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

part 'movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  final GetNowPlayingListCase? getNowPlayingListCase;
  final GetMoreMoviesCase? getMoreMovieCase;

  MovieListCubit({
    this.getNowPlayingListCase,
    this.getMoreMovieCase,
  }) : super(MovieListInitial());

  getNowPlayingMovies(int page) async {
    Either<Failure, ResponseMovieListModel> movieListResult = await getNowPlayingListCase!.getNowPlayingMovies(page);
    movieListResult.fold(
        (l) => emit(MovieListFetchFailed()),
        (r) => emit(
              MovieListFetchSuccess(responseMovieListModel: r),
            ));
  }

  getMoreMovies(int page) async {
    Either<Failure, ResponseMovieListModel> moreMovieListResult = await getMoreMovieCase!.getNowPlayingMovies(page);
    moreMovieListResult.fold(
      (l) => emit(MoreMovieFetchFailed()),
      (r) => emit(MoreMovieFetchSuccess(responseMovieListModel: r)),
    );
  }
}
