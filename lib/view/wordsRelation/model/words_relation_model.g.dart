// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'words_relation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordsRelation _$WordsRelationFromJson(Map<String, dynamic> json) =>
    WordsRelation(
      hint: json['hint'] as String?,
      relatedWords: (json['relatedWords'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      totalCount: json['totalCount'] as String?,
    );

Map<String, dynamic> _$WordsRelationToJson(WordsRelation instance) =>
    <String, dynamic>{
      'hint': instance.hint,
      'relatedWords': instance.relatedWords,
      'totalCount': instance.totalCount,
    };
