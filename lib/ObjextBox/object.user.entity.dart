import 'package:objectbox/objectbox.dart';

@Entity()
class ObjectBoxUser {
  @Id()
  int id;
  String fName;
  String lName;
  int birthMonth;
  int birthDay;
  int birthYear;
  String addedAt;
  ObjectBoxUser({
    this.id = 0,
    required this.fName,
    required this.lName,
    required this.addedAt,
    required this.birthDay,
    required this.birthMonth,
    required this.birthYear,
  });
}