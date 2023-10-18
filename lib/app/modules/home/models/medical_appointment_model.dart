// ignore_for_file: public_member_api_docs, sort_constructors_first
class MedicalAppointmentModel {
  final int id;
  final String title;
  final String date;
  final String timer;
  final String? rememberAtDate;
  final String? rememberAtTimer;
  final String? remember;
  final String? dateFull;

  MedicalAppointmentModel({
    required this.id,
    required this.title,
    required this.date,
    required this.timer,
    this.rememberAtDate,
    this.rememberAtTimer,
    this.remember,
    this.dateFull,
  });

  factory MedicalAppointmentModel.froMap(Map<String, dynamic> map) {
    return MedicalAppointmentModel(
      id: map['id'],
      title: map['title'],
      date: map['date'],
      timer: map['timer'],
      rememberAtDate: map['remember_date_at'],
      rememberAtTimer: map['remember_timer_at'],
      remember: map['remember'],
      dateFull: '${map['date']} ${map['timer']}',
    );
  }

  static List<MedicalAppointmentModel> listMedication(List map) {
    List<MedicalAppointmentModel> list = [];
    for (var element in map) {
      list.add(MedicalAppointmentModel.froMap(element));
    }
    return list;
  }
}
