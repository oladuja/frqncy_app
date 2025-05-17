// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  firstName: json['firstName'] as String,
  imageUrl: json['imageUrl'] as String,
  lastName: json['lastName'] as String,
  emailAddress: json['emailAddress'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'emailAddress': instance.emailAddress,
  'imageUrl': instance.imageUrl,
};
