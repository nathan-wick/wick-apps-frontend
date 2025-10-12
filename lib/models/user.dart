import '../utilities/type_converter.dart';
import 'base.dart';

class WickModelUser extends WickModelBase<WickModelUser> {
  final int id;
  final String email;
  final String? picture;
  final String? firstName;
  final String? lastName;
  final DateTime? birthday;

  WickModelUser({
    required this.id,
    required this.email,
    this.picture,
    this.firstName,
    this.lastName,
    this.birthday,
  }) : super({
         'id': id,
         'email': email,
         'picture': picture,
         'firstName': firstName,
         'lastName': lastName,
         'birthday': birthday,
       });

  factory WickModelUser.fromJson(Map<String, dynamic> json) {
    return WickModelUser(
      id: WickUtilityTypeConverter.toInt(json['id']) ?? 0,
      email: WickUtilityTypeConverter.describe(json['email']) ?? '',
      picture: WickUtilityTypeConverter.describe(json['picture']),
      firstName: WickUtilityTypeConverter.describe(json['firstName']),
      lastName: WickUtilityTypeConverter.describe(json['lastName']),
      birthday: WickUtilityTypeConverter.toDate(json['birthday']),
    );
  }

  @override
  WickModelUser newInstance(Map<String, dynamic> newAttributes) =>
      WickModelUser.fromJson(newAttributes);
}
