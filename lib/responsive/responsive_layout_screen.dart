//Responsive design refers to a site or application design that responds to the environment in which it is viewed

import "package:flutter/material.dart";
import 'package:graffitiapp/provider/user_provider.dart';
import 'package:graffitiapp/utils/global_variables.dart';
import 'package:provider/provider.dart';




class ResponsiveLayout extends StatefulWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        // 600 can be changed to 900 if you want to display tablet screen with mobile screen layout
        
        //web screen layout
        return widget.webScreenLayout;
      }
      //mobile screen layout
      return widget.mobileScreenLayout;
    });
  }
}



