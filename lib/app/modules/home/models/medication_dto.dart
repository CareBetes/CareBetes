// ignore_for_file: public_member_api_docs, sort_constructors_first
class MedicationDto {
  final int userId;
  final String title;
  final String timer;
  final List<int> repeatAt;
  final String? remember;

  MedicationDto({
    required this.userId,
    required this.title,
    required this.timer,
    required this.repeatAt,
    this.remember,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'title': title,
      'timer': timer,
      'repeat_at': repeatAt,
      'remember': remember,
    };
  }
}
