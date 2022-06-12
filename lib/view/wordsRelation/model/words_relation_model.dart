import 'package:wordflow/core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'words_relation_model.g.dart';

@JsonSerializable()
class WordsRelation extends BaseModel {
  String? hint;
  List<String>? relatedWords;
  String? totalCount;

  WordsRelation({this.hint, this.relatedWords, this.totalCount});

  factory WordsRelation.fromJson(Map<String, dynamic> json) => _$WordsRelationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WordsRelationToJson(this);

  @override
  fromJson(Map<String, dynamic> json) {
    return WordsRelation.fromJson(json);
  }
}
