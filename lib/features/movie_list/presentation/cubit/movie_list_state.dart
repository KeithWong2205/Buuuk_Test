part of 'movie_list_cubit.dart';

@immutable
abstract class MovieListState {}

class MovieListInitial extends MovieListState {}

class MovieListFetchFailed extends MovieListState {
  MovieListFetchFailed();

  List<Object> get props => [];
}

class MovieListFetchSuccess extends MovieListState {
  final ResponseMovieListModel responseMovieListModel;

  MovieListFetchSuccess({
    required this.responseMovieListModel,
  });

  List<Object> get props => [responseMovieListModel];
}

class MoreMovieFetchFailed extends MovieListState {
  MoreMovieFetchFailed();

  List<Object> get props => [];
}

class MoreMovieFetchSuccess extends MovieListState {
  final ResponseMovieListModel responseMovieListModel;

  MoreMovieFetchSuccess({
    required this.responseMovieListModel,
  });

  List<Object> get props => [responseMovieListModel];
}
