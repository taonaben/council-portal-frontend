import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';



@JsonSerializable()
class NotificationModel {
  String? id;
  String? title;
  String? description;
  bool? isRead;
  String? date;
  String? type;

  NotificationModel({
    this.id,
    this.title,
    this.description,
    this.type,
    this.isRead,
    this.date,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
