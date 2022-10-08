import 'package:buuk_test/core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genre_model.g.dart';

@JsonSerializable()
class GenreModel extends BaseModel {
  String? name;

  GenreModel({
    this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) => _$GenreModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GenreModelToJson(this);
}
