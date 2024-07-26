import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person_model.g.dart';

@entity
@JsonSerializable()
class PersonModel {
  @primaryKey
  final String? name;
  final int? age;
  final String? address;
  final String? dateOfBirth;
  PersonModel({
    this.name,
    this.age,
    this.address,
    this.dateOfBirth,
  });
  factory PersonModel.fromJson(Map<String, dynamic> json) => _$PersonModelFromJson(json);
  Map<String, dynamic> toJson() => _$PersonModelToJson(this);
}
