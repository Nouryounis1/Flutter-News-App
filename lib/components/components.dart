import 'package:buildcondition/buildcondition.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/alltrending_screen/alltrending_screen.dart';
import 'package:news_app/modules/web_view/webview_screen.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/utils/custom_clipper.dart';

Widget defaultFormField(
        {@required TextEditingController? controller,
        @required TextInputType? type,
        @required String? label,
        @required IconData? prefix,
        @required String? validateText,
        Function()? onTap,
        dynamic onChange,
        bool isClicable = true}) =>
    TextFormField(
      style: TextStyle(
        color:
            CacheHelper.getData(key: 'isDark')! ? Colors.white : Colors.black,
      ),
      controller: controller,
      onTap: onTap,
      validator: (value) {
        if (value!.isEmpty) {
          return validateText;
        }
        return null;
      },
      keyboardType: type,
      enabled: isClicable,
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.deepOrange),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: CacheHelper.getData(key: 'isDark')!
                  ? Colors.deepOrange
                  : Colors.deepOrange,
              width: 2.0),
        ),
        prefixIcon: Icon(prefix,
            color: CacheHelper.getData(key: 'isDark')!
                ? Colors.deepOrange
                : Colors.deepOrange),
      ),
    );

Widget buildArticleItem(article, context) => Material(
      child: InkWell(
        onTap: () {
          navigateTo(context, WebViewScreen(article['url']));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                        image: NetworkImage('${article['urlToImage']}'),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Container(
                  height: 120.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text('${article['title']}',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                      Text('${article['publishedAt']}',
                          style: TextStyle(
                            color: Colors.grey,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: <Widget>[
        Expanded(
            child: Divider(
          color: Colors.white,
        ))
      ]),
    );

Widget articleBuilder(list, {isSearch = false}) => Container(
      color: Colors.white,
      child: BuildCondition(
          condition: list.length > 0,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildArticleItem(list[index], context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: 10),
          fallback: (context) => isSearch
              ? Container()
              : Center(child: CircularProgressIndicator())),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

Widget DesinationalCarousel(list, context) => Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
              GestureDetector(
                onTap: () {
                  navigateTo(context, AllTrendingScreen());
                },
                child: Text(
                  'See All',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 300.0,
          child: BuildCondition(
              condition: list.length > 0,
              builder: (context) => ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      DesinationalCarouselItem(list[index], context),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 10),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator())),
        )
      ],
    );

Widget DesinationalCarouselItem(article, context) => Material(
      child: InkWell(
        onTap: () {
          navigateTo(context, WebViewScreen(article['url']));
        },
        child: Container(
          margin: EdgeInsets.all(10.0),
          width: 210.0,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                bottom: 15.0,
                child: Container(
                  height: 120.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${article['author']}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2),
                        ),
                        Text(
                          '${article['title']}',
                          maxLines: 2,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0)
                    ]),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image(
                        height: 180.0,
                        width: 180.0,
                        image: NetworkImage('${article['urlToImage']}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

Widget HeadlinesCarousel(list, context) => Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Headlines',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
              GestureDetector(
                onTap: () {
                  navigateTo(context, AllTrendingScreen());
                },
                child: Text(
                  'See All',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 300.0,
          child: BuildCondition(
              condition: list.length > 0,
              builder: (context) => ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      HeadLinesCarouselItem(list[index], context),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 10),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator())),
        )
      ],
    );

Widget HeadLinesCarouselItem(article, context) => Material(
      child: InkWell(
        onTap: () {
          navigateTo(context, WebViewScreen(article['url']));
        },
        child: Container(
          margin: EdgeInsets.all(10.0),
          width: 240.0,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                bottom: 15.0,
                child: Container(
                  height: 120.0,
                  width: 240.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${article['author']}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2),
                        ),
                        Text(
                          '${article['title']}',
                          maxLines: 2,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    height: 180.0,
                    width: 220.0,
                    image: NetworkImage('${article['urlToImage']}'),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

Widget ProfileContainer() => Container(
      height: 330.0,
      child: Stack(
        children: [
          Container(),
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: 300.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1616004667892-d348f7349d39?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80'))),
            ),
          ),
          Align(
            alignment: Alignment(0, 1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProfileAvatar(
                  'https://images.unsplash.com/photo-1620825937374-87fc7d6bddc2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1400&q=80',
                  borderWidth: 4.0,
                  radius: 80.0,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'Nour Younis',
                  style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Developer',
                  style: TextStyle(fontSize: 12.0, color: Colors.grey[700]),
                )
              ],
            ),
          ),
        ],
      ),
    );

Widget ProfileCard() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 21.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.access_time,
                  size: 40.0,
                  color: Colors.deepOrange,
                ),
              ),
              SizedBox(
                width: 24.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Joined Date',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text('18 Sep 2021',
                      style:
                          TextStyle(color: Colors.grey[700], fontSize: 12.0)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
