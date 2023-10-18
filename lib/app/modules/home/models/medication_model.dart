class MedicationModel {
  final int id;
  final int userId;
  final String title;
  final String timer;
  final List<int> repeatAt;
  final String? remember;

  MedicationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.timer,
    required this.repeatAt,
    this.remember,
  });

  factory MedicationModel.froMap(Map<String, dynamic> map) {
    return MedicationModel(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'],
      timer: map['timer'],
      repeatAt: map['repeat_at'] as List<int>,
      remember: map['remember'],
    );
  }

  static List<MedicationModel> listMedication(List map) {
    List<MedicationModel> list = [];
    for (var element in map) {
      list.add(MedicationModel.froMap(element));
    }
    return list;
  }
}
