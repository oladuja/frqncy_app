import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String emailAddress;
  final String imageUrl;

  UserModel({
    required this.id,
    required this.firstName,
    required this.imageUrl,
    required this.lastName,
    required this.emailAddress,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
