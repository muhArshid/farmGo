import 'package:farmapp/constants.dart';
import 'package:farmapp/responsive.dart';
import 'package:farmapp/views/Dashboard/compodent/header.dart';
import 'package:farmapp/views/Dashboard/compodent/my_fields.dart';
import 'package:flutter/cupertino.dart';

class DashboradScreen extends StatefulWidget {
  const DashboradScreen({Key? key}) : super(key: key);

  @override
  _DashboradScreenState createState() => _DashboradScreenState();
}

class _DashboradScreenState extends State<DashboradScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MyFiles(),
                      SizedBox(height: defaultPadding),
                      //   RecentFiles(),
                      // if (Responsive.isMobile(context))
                      //   SizedBox(height: defaultPadding),
                      // if (Responsive.isMobile(context)) StarageDetails(),
                    ],
                  ),
                ),
                // if (!Responsive.isMobile(context))
                //   SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                // if (!Responsive.isMobile(context))
                //   Expanded(
                //     flex: 2,
                //     child: StarageDetails(),
                //   ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
