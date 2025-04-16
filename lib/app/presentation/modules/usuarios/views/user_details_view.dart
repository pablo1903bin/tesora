import 'package:flutter/material.dart';

import '../../../global/widgets/custom_app_bar.dart';
import '../../../mixin/controllers_mixin.dart';
import '../../../routes/route_path.dart';
import '../../menu/views/drawer_widget.dart';

class UserDetailsScreen extends StatelessWidget with ControllersMixin {
  const UserDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {


    return const Scaffold(
      appBar: CustomAppBar(
        title: RoutePath.userDetails,
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Nombre:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Email:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 60),

            //uso del controller user

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
