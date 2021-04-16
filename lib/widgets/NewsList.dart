import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../layout/adaptive.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  Future<List<News>> futureNews;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    futureNews = fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    
    return FutureBuilder<List<News>>(
      future: futureNews,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                    //height: isDesktop ? 250 : 200,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: isDesktop ? 5.5 : 2.5,
                    viewportFraction: isDesktop ? 0.3 : 0.7,
                    initialPage: 0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey,
                            offset: Offset(5.0, 0), // (right, bottom)
                            blurRadius: 5.0,
                            // spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          child: Stack(
                            children: <Widget>[
                              Image.network(snapshot.data[index].imageUrl,
                                  fit: BoxFit.cover, width: 1000.0),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(200, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  child: Text(
                                    snapshot.data[index].title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isDesktop ? 18.0 : 11.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  );
                },
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: snapshot.data.map((url) {
                    int index = snapshot.data.indexOf(url);
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                          ? Color.fromRGBO(0, 0, 0, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    );
                  }
                ).toList(),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );
  }
}

class News {
  int id;
  String title;
  String content;
  String imageUrl;

  News({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.imageUrl,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['titre'],
      content: json['contenu'],
      imageUrl: json['photo']['url'],
    );
  }
}

Future<List<News>> fetchNews() async {
  final response = await http.get(Uri.https("afrchavanod.herokuapp.com",
      "/actualites", {"_sort": "published_at:DESC"}));

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    // print(jsonResponse);
    List<News> newsList = [];
    for (var i = 0; i < jsonResponse.length; i++) {
      // print(jsonResponse[i]);
      newsList.add(News.fromJson(jsonResponse[i]));
    }
    return newsList;
  } else {
    throw Exception("Failed to load News");
  }
}
