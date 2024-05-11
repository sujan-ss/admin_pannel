import 'package:admin_panel/features/authentication/presentation/login/presentation/login.dart';
import 'package:admin_panel/features/navigation/presentation/side_nav.dart';
import 'package:admin_panel/features/sub-admin/get_status_page/presentation/get_Status_page.dart';
import 'package:admin_panel/repository/access_token_repo.dart';
import 'package:flutter/material.dart';

class SplashRouter extends StatefulWidget {
  const SplashRouter({super.key});

  @override
  State<SplashRouter> createState() => _SplashRouterState();
}

class _SplashRouterState extends State<SplashRouter> {
  void router() async {
    final String? accessToken = await AccessTokenRepo().getAccessToken();
    final String? type = await AccessTokenRepo().getUserType();
    if (accessToken == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Login()));
    } else {
      if (type == "main") {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SideNavScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const GetStatusPage()));
      }
    }
  }

  @override
  void initState() {
    router();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
