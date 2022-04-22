import 'package:wordflow/core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cardStatus_model.g.dart';

@JsonSerializable()
class CardStatus extends BaseModel {
  String? word;
  int? status;
  String playerId;

  CardStatus({this.word, this.status, this.playerId = '0'});

  factory CardStatus.fromJson(Map<String, dynamic> json) => _$CardStatusFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CardStatusToJson(this);

  @override
  fromJson(Map<String, dynamic> json) {
    return CardStatus.fromJson(json);
  }
}
