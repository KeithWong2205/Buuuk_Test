import 'package:buuk_test/core/base/model/response_base_model.dart';
import 'package:buuk_test/features/movie_detail/domain/model/genre_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_movie_detail_model.g.dart';

@JsonSerializable()
class ResponseMovieDetailModel extends ResponseBaseModel {
  String? backdrop_path;
  String? title;
  String? overview;
  double? popularity;
  int? runtime;
  int? revenue;
  String? poster_path;
  List<GenreModel>? genres;

  ResponseMovieDetailModel({
    this.title,
    this.poster_path,
    this.backdrop_path,
    this.overview,
    this.popularity,
    this.genres,
    this.revenue,
    this.runtime,
  });

  factory ResponseMovieDetailModel.fromJson(Map<String, dynamic> json) => _$ResponseMovieDetailModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ResponseMovieDetailModelToJson(this);
}
