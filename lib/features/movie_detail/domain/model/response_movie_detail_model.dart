import 'package:buuk_test/core/base/model/response_base_model.dart';
import 'package:buuk_test/features/movie_detail/domain/model/genre_model.dart';
import 'package:buuk_test/features/movie_detail/domain/model/production_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_movie_detail_model.g.dart';

@JsonSerializable()
class ResponseMovieDetailModel extends ResponseBaseModel {
  String? backdrop_path;
  String? title;
  String? overview;
  String? tagline;
  double? popularity;
  double? vote_average;
  int? runtime;
  int? revenue;
  String? poster_path;
  List<GenreModel>? genres;
  List<ProductionModel>? production_companies;

  ResponseMovieDetailModel({
    this.title,
    this.poster_path,
    this.backdrop_path,
    this.production_companies,
    this.overview,
    this.vote_average,
    this.tagline,
    this.popularity,
    this.genres,
    this.revenue,
    this.runtime,
  });

  factory ResponseMovieDetailModel.fromJson(Map<String, dynamic> json) => _$ResponseMovieDetailModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ResponseMovieDetailModelToJson(this);
}
