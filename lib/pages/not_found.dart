import 'package:flutter/cupertino.dart';
import 'package:wick_apps/widgets/button.dart';

import '../utilities/style_constants.dart';
import 'base.dart';

class WickPageNotFound extends StatelessWidget {
  const WickPageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return WickPageBase(
      title: 'Page Not Found',
      content: [
        Center(
          child: Column(
            children: [
              // TODO Add the route to this message
              Text("The page you're looking for doesn't exist."),
              SizedBox(height: WickUtilityStyleConstants.contentGapSize),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TODO Only display if we know their previous route
                  WickWidgetButton(
                    message: 'Go Back',
                    onPressed:
                        () => {
                          // TODO Go back to the previous page
                        },
                  ),
                  SizedBox(width: WickUtilityStyleConstants.contentGapSize),
                  WickWidgetButton(
                    message: 'Go Home',
                    onPressed:
                        () => {
                          // TODO Go to the default page
                        },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
