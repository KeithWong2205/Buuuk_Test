import 'package:buuk_test/core/base/model/response_base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_movie_detail_model.g.dart';

@JsonSerializable()
class ResponseMovieDetailModel extends ResponseBaseModel {
  ResponseMovieDetailModel();

  factory ResponseMovieDetailModel.fromJson(Map<String, dynamic> json) => _$ResponseMovieDetailModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ResponseMovieDetailModelToJson(this);
}
