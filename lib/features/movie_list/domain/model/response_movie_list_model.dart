import 'package:buuk_test/core/base/model/response_base_model.dart';
import 'package:buuk_test/features/movie_list/domain/model/result_movie_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_movie_list_model.g.dart';

@JsonSerializable()
class ResponseMovieListModel extends ResponseBaseModel {
  int? page;
  List<ResultMovieItemModel>? results;

  ResponseMovieListModel({
    this.page,
    this.results,
  });

  factory ResponseMovieListModel.fromJson(Map<String, dynamic> json) => _$ResponseMovieListModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ResponseMovieListModelToJson(this);
}
