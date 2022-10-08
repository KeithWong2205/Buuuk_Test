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
