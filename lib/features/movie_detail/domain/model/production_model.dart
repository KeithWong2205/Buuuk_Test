import 'package:buuk_test/core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'production_model.g.dart';

@JsonSerializable()
class ProductionModel extends BaseModel {
  String? logo_path;
  String? name;
  ProductionModel({
    this.logo_path,
    this.name,
  });

  factory ProductionModel.fromJson(Map<String, dynamic> json) => _$ProductionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProductionModelToJson(this);
}
