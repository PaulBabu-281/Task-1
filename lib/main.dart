import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/profile_model.dart';
import 'package:task1/profile_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // getSavedProfile();
    return ChangeNotifierProvider<Profile>(
      //                                <--- Provider
      create: (context) => Profile(),
      child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: ProfileView()),
    );
  }
}
