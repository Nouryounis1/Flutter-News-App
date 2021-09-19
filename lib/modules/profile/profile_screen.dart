import 'package:flutter/material.dart';
import 'package:news_app/components/components.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          ProfileContainer(),
          ListView.builder(
            itemBuilder: (context, index) => ProfileCard(),
            shrinkWrap: true,
            itemCount: 6,
          )
        ],
      ),
    ));
  }
}
