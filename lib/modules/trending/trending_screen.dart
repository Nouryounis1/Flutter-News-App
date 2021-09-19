import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/cubit/home_cubit/home_cubit.dart';
import 'package:news_app/cubit/home_cubit/home_state.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/health_screen/health_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';

class TrendingScreen extends StatelessWidget {
  List<IconData> icons = [
    FontAwesomeIcons.businessTime,
    FontAwesomeIcons.dumbbell,
    FontAwesomeIcons.atom,
    FontAwesomeIcons.heartbeat
  ];
  List<String> iconsName = ['Business', 'Sports', 'Science', 'Health'];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = HomeCubit.get(context).everythng;
          Widget buildIcon(int index) {
            return GestureDetector(
              onTap: () {
                print(index);

                if (index == 0) {
                  navigateTo(context, BusinessScreen());
                } else if (index == 1) {
                  navigateTo(context, SportsScreen());
                } else if (index == 2) {
                  navigateTo(context, ScienceScreen());
                } else if (index == 3) {
                  navigateTo(context, HealthScreen());
                }
              },
              child: Column(
                children: [
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                        color: Colors.deepOrange[100],
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Icon(icons[index],
                        size: 25.0, color: Colors.deepOrange[300]),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    iconsName[index],
                    style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            );
          }

          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Text(
                    'What would you like to find?',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: icons
                      .asMap()
                      .entries
                      .map(
                        (MapEntry map) => buildIcon(map.key),
                      )
                      .toList(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                DesinationalCarousel(list, context),
                SizedBox(
                  height: 20.0,
                ),
                HeadlinesCarousel(list, context),
              ],
            ),
          ));
        });
  }
}
