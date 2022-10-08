part of 'movie_detail_cubit.dart';

@immutable
abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailFetchFailed extends MovieDetailState {
  MovieDetailFetchFailed();
  List<Object> get props => [];
}

class MovieDetailFetchSuccess extends MovieDetailState {
  final ResponseMovieDetailModel responseMovieDetailModel;

  MovieDetailFetchSuccess({
    required this.responseMovieDetailModel,
  });

  List<Object> get props => [responseMovieDetailModel];
}
