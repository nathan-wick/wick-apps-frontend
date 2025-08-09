import '../utilities/type_converter.dart';
import 'base.dart';
import 'dashboard_configuration.dart';
import 'preferences.dart';
import 'session.dart';

class UserModel extends BaseModel<UserModel> {
  UserModel({
    required int id,
    required String email,
    String? picture,
    String? firstName,
    String? lastName,
    DateTime? birthday,
    List<SessionModel>? sessions,
    PreferencesModel? preferences,
    List<DashboardConfigurationModel>? dashboardConfigurations,
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
