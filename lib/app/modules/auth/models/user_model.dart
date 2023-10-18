// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final int id;
  final String name;
  final String betesType;
  final int age;
  final double weight;
  final String email;
  final String password;

  UserModel({
    required this.id,
    required this.name,
    required this.betesType,
    required this.age,
    required this.weight,
    required this.email,
    required this.password,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      betesType: map['type_betes'],
      age: map['age'],
      weight: map['weight'],
      email: map['email'],
      password: map['password'],
    );
  }

  firstName() => name.split(' ')[0];
}
