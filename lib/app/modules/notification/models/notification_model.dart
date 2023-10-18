// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationModel {
  final int id;
  final String? title;
  final String? body;
  final String? payload;
  final String? schedule;
  final List<int>? days;

  NotificationModel({
    required this.id,
    this.title,
    this.body,
    this.payload,
    this.schedule,
    this.days,
  });
}
