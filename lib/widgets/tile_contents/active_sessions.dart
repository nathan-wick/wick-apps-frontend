import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/session.dart';
import '../../enums/order_direction.dart';
import '../../models/paginated_response.dart';
import '../../models/session.dart';
import '../../models/user.dart';
import '../../providers/user.dart';
import '../loading_indicator.dart';
import '../table.dart';

class WickWidgetTileContentActiveSessions extends StatelessWidget {
  const WickWidgetTileContentActiveSessions({super.key});

  @override
  Widget build(BuildContext context) {
    final WickModelUser? user = Provider.of<WickProviderUser>(context).value;
    if (user == null) {
      return const WickWidgetLoadingIndicator();
    }
    return FutureBuilder<WickModelPaginatedResponse<WickModelSession>?>(
      future: WickControllerSession().get(
        context,
        orderBy: 'started',
        orderDirection: WickEnumOrderDirection.descending,
        where:
            'userId = ${user.id} AND expires > ${DateTime.now().toIso8601String()}',
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const WickWidgetLoadingIndicator();
        }
        final List<WickModelSession> sessions = snapshot.data?.instances ?? [];
        return WickWidgetTable(data: sessions);
      },
    );
  }
}
