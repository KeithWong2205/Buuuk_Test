import 'package:buuk_test/core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result_movie_item_model.g.dart';

@JsonSerializable()
class ResultMovieItemModel extends BaseModel {
  int? id;
  String? poster_path;
  String? release_date;
  String? title;

  ResultMovieItemModel({
    this.title,
    this.release_date,
    this.poster_path,
  });

  factory ResultMovieItemModel.fromJson(Map<String, dynamic> json) => _$ResultMovieItemModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ResultMovieItemModelToJson(this);
}
