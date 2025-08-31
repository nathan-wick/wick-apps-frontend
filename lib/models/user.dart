import '../utilities/type_converter.dart';
import 'base.dart';
import 'dashboard_configuration.dart';
import 'preferences.dart';
import 'session.dart';

class UserModel extends BaseModel {
  final int id;
  final String email;
  final String? picture;
  final String? firstName;
  final String? lastName;
  final DateTime? birthday;
  final List<SessionModel>? sessions;
  final PreferencesModel? preferences;
  final List<DashboardConfigurationModel>? dashboardConfigurations;

  UserModel({
    required this.id,
    required this.email,
    this.picture,
    this.firstName,
    this.lastName,
    this.birthday,
    this.sessions,
    this.preferences,
    this.dashboardConfigurations,
  }) : super({
         'id': id,
         'email': email,
         'picture': picture,
         'firstName': firstName,
         'lastName': lastName,
         'birthday': birthday,
         'sessions': sessions,
         'preferences': preferences,
         'dashboardConfigurations': dashboardConfigurations,
       });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<SessionModel>? sessions;
    if (json['sessions'] != null && json['sessions'] is List) {
      sessions =
          json['sessions']
              .map(
                (item) =>
                    SessionModel.fromJson(Map<String, dynamic>.from(item)),
              )
              .toList();
    }
    List<DashboardConfigurationModel>? dashboardConfigurations;
    if (json['dashboardConfigurations'] != null &&
        json['dashboardConfigurations'] is List) {
      dashboardConfigurations =
          json['dashboardConfigurations']
              .map(
                (item) => DashboardConfigurationModel.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList();
    }

    return UserModel(
      id: TypeConverter.toInt(json['id']) ?? 0,
      email: TypeConverter.describe(json['email']) ?? '',
      picture: TypeConverter.describe(json['picture']),
      firstName: TypeConverter.describe(json['firstName']),
      lastName: TypeConverter.describe(json['lastName']),
      birthday: TypeConverter.toDate(json['birthday']),
      sessions: sessions,
      preferences: PreferencesModel.fromJson(json['preferences']),
      dashboardConfigurations: dashboardConfigurations,
    );
  }
}
