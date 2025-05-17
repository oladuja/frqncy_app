import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String name;
  final String emailAddress;
  final String imageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.emailAddress,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
