// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserDto {
  final String name;
  final String betesType;
  final int age;
  final double weight;
  final String email;
  final String password;

  UserDto({
    required this.name,
    required this.betesType,
    required this.age,
    required this.weight,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type_betes': betesType,
      'age': age,
      'weight': weight,
      'email': email,
      'password': password,
    };
  }
}
