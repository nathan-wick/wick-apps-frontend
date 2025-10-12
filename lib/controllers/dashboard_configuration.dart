import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/dashboard_configuration.dart';
import '../models/paginated_response.dart';
import '../providers/user.dart';
import 'base.dart';

class WickControllerDashboardConfiguration
    extends WickControllerBase<WickModelDashboardConfiguration> {
  WickControllerDashboardConfiguration()
    : super(WickModelDashboardConfiguration.fromJson);

  /// Given the dashboard's name, gets the configuration for the current user.
  Future<WickModelDashboardConfiguration?> getConfigurationForCurrentUser(
    BuildContext context,
    String dashboard,
  ) async {
    final int? userId =
        (await Provider.of<WickProviderUser>(
          context,
          listen: false,
        ).getValue(context))?.id;
    if (userId == null) return null;
    final WickModelPaginatedResponse<WickModelDashboardConfiguration>?
    response = await get(
      context,
      pageSize: 1,
      where: "userId = $userId AND dashboard = '$dashboard",
    );
    return response == null
        ? null
        : response.instances.isNotEmpty
        ? response.instances[0]
        : null;
  }
}
