import '../utilities/type_converter.dart';
import 'base.dart';
import 'dashboard_configuration.dart';
import 'preferences.dart';
import 'session.dart';

class WickModelUser extends WickModelBase {
  final int id;
  final String email;
  final String? picture;
  final String? firstName;
  final String? lastName;
  final DateTime? birthday;
  final List<WickModelSession>? sessions;
  final WickModelPreferences? preferences;
  final List<WickModelDashboardConfiguration>? dashboardConfigurations;

  WickModelUser({
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

  factory WickModelUser.fromJson(Map<String, dynamic> json) {
    List<WickModelSession>? sessions;
    if (json['sessions'] != null && json['sessions'] is List) {
      sessions =
          json['sessions']
              .map(
                (item) =>
                    WickModelSession.fromJson(Map<String, dynamic>.from(item)),
              )
              .toList();
    }
    List<WickModelDashboardConfiguration>? dashboardConfigurations;
    if (json['dashboardConfigurations'] != null &&
        json['dashboardConfigurations'] is List) {
      dashboardConfigurations =
          json['dashboardConfigurations']
              .map(
                (item) => WickModelDashboardConfiguration.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList();
    }

    return WickModelUser(
      id: WickUtilityTypeConverter.toInt(json['id']) ?? 0,
      email: WickUtilityTypeConverter.describe(json['email']) ?? '',
      picture: WickUtilityTypeConverter.describe(json['picture']),
      firstName: WickUtilityTypeConverter.describe(json['firstName']),
      lastName: WickUtilityTypeConverter.describe(json['lastName']),
      birthday: WickUtilityTypeConverter.toDate(json['birthday']),
      sessions: sessions,
      preferences: WickModelPreferences.fromJson(json['preferences']),
      dashboardConfigurations: dashboardConfigurations,
    );
  }
}
