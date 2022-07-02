import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movielist/UI/list_ui.dart';
import 'package:movielist/UI/dashboard_ui.dart';
import 'package:movielist/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginUI extends StatelessWidget {
  const LoginUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: ((context) => AuthProvider()),
        builder: (context, w) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/bglogin.jpg'), fit: BoxFit.cover)),
              child: Center(
                  child:Consumer<AuthProvider>(builder: (context, prov, w) {
                return IconButton(
                  iconSize: 220,
                  padding: EdgeInsets.only(top: 350),
                  icon: Image.asset('img/signin.png'),
                  onPressed: () {
                    prov.auth().then((user) {
                      if (user != null) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (C) => DashboardUI()));
                      }
                    });
                  },
                  // label: const Text('Login')
                );
              })),
            ),
          );
        });
  }
}
