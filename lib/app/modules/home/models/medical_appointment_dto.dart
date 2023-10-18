// ignore_for_file: public_member_api_docs, sort_constructors_first
class MedicalAppointmentDto {
  final int userId;
  final String title;
  final String date;
  final String timer;
  final String? rememberAtDate;
  final String? rememberAtTimer;
  final String? remember;

  MedicalAppointmentDto({
    required this.userId,
    required this.title,
    required this.date,
    required this.timer,
    this.rememberAtDate,
    this.rememberAtTimer,
    this.remember,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'title': title,
      'date': date,
      'timer': timer,
      'remember_date_at': rememberAtDate,
      'remember_timer_at': rememberAtTimer,
      'remember': remember,
    };
  }
}
