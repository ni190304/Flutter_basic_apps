import 'package:uuid/uuid.dart';

const uuid = Uuid();

class LoginDetails {
  LoginDetails({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
  }) : id = uuid.v4();

  final String name;
  final String email;
  final String phone;

  final String gender;
  final String id;
}
