// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cardStatus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardStatus _$CardStatusFromJson(Map<String, dynamic> json) => CardStatus(
      word: json['word'] as String?,
      status: json['status'] as int?,
      playerId: json['playerId'] as String? ?? '0',
    );

Map<String, dynamic> _$CardStatusToJson(CardStatus instance) =>
    <String, dynamic>{
      'word': instance.word,
      'status': instance.status,
      'playerId': instance.playerId,
    };
