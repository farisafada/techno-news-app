import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'package:flutter_technonews_app/detail_screen.dart';

void main() {
  runApp(const TechnoNewsApp());
}

class TechnoNewsApp extends StatelessWidget {
  const TechnoNewsApp({super.key});
  // This widget is the root of your application.`
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Techno News',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Techno News'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Xml2Json xml2json = Xml2Json();
  List latestUpdate = [];
  List reviewList = [];
  
  Future newsLatestUpdate()  async {
    final url = Uri.parse('https://www.notebookcheck.net/News.152.100.html');
    final response = await http.get(url); // xml data
    xml2json.parse(response.body.toString());
    var jsondata =  xml2json.toGData(); // converted json data
    var data = json.decode(jsondata);

    latestUpdate = data['rss']['channel']['item'];
    // print(latestUpdate);
  }

  Future newsReview()  async {
    final url = Uri.parse('https://www.notebookcheck.net/RSS-Feed-Notebook-Reviews.8156.0.html');
    final response = await http.get(url); // xml data
    xml2json.parse(response.body.toString());
    var jsondata =  xml2json.toGData(); // converted json data
    var data = json.decode(jsondata);

    reviewList = data['rss']['channel']['item'];
    // print(reviewList);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 1, 27),
          title: Center(
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(text: 'Techno ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  TextSpan(text: 'News', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 33, 150, 243), fontSize: 25)),
                ],
              ),
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text('News', style: TextStyle(fontSize: 12, color: Colors.white)),
              ),

              Tab(
                child: Text('Reviews', style: TextStyle(fontSize: 12)),
              ),
            ]
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: FutureBuilder(
                future: newsLatestUpdate(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                  return snapshot.connectionState == ConnectionState.waiting
                    ? const SizedBox(
                      height: 45,
                      width: 45,
                      child: CircularProgressIndicator(strokeWidth: 2.75,)
                    ) 
                    : SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding (
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [ ]
                          ),
                        ),
              
              
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10
                          ),
                          child: Container(
                                alignment: Alignment.centerLeft,
                                child: const Text('Latest Update',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  ),
                                )
                              ),
                        ), 
              
                        const Divider(
                          color: Colors.white,
                          indent: 0,
                          endIndent: 0,
                          height: 5,
                          thickness: 1,
                        ),
              
                        ListView.builder(
                          shrinkWrap: true,
                          controller: ScrollController(),
                          itemCount: latestUpdate.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
              
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 16, 18, 22),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                    color: Color.fromARGB(255, 32, 32, 32)
                                  )
                                ]
                              ),
                              
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return DetailScreen(
                                        title: latestUpdate[index]['title']['__cdata'].toString().replaceAll('â', '-').replaceAll('â¬', '€'),
                                        image: latestUpdate[index]['media\$content']['url'],
                                        description: latestUpdate[index]['description']['__cdata'],
                                        date: latestUpdate[index]['pubDate'].toString(),
                                        link: latestUpdate[index]['link']['\$t'],
                                      );
                                    }
                                  ));
                                },
                                horizontalTitleGap: 10,
                                minVerticalPadding: 10,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10
                                ),
                                title: Text(
                                  latestUpdate[index]['title']['__cdata'].toString().replaceAll('â', "‘").replaceAll('â', '’').replaceAll('â', '-').replaceAll('â¬', '€'),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis
                                ),
                                leading: CachedNetworkImage(
                                  imageUrl: latestUpdate[index]['media\$content']['url'],
                                  fit: BoxFit.cover,
                                  height: 80,
                                  width: 80
                                ),
                              ),
                              
                            );
                          }
                        )
              
                      ],
                    ),
                  );
                },
              ),
            ),


            // Page Reviews
            Center(
              child: FutureBuilder(
                future: newsReview(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                  return snapshot.connectionState == ConnectionState.waiting
                    ? const SizedBox(
                      height: 45,
                      width: 45,
                      child: CircularProgressIndicator(strokeWidth: 2.75,)
                    ) 
                    : SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding (
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [ ]
                          ),
                        ),
              
              
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10
                          ),
                          child: Container(
                                alignment: Alignment.centerLeft,
                                child: const Text('Review',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  ),
                                )
                              ),
                        ), 
              
                        const Divider(
                          color: Colors.white,
                          indent: 0,
                          endIndent: 0,
                          height: 5,
                          thickness: 1,
                        ),
              
                        ListView.builder(
                          shrinkWrap: true,
                          controller: ScrollController(),
                          itemCount: reviewList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
              
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 16, 18, 22),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                    color: Color.fromARGB(255, 32, 32, 32)
                                  )
                                ]
                              ),
                              
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return DetailScreen(
                                        title: reviewList[index]['title']['__cdata'].toString().replaceAll('â', '-').replaceAll('â¬', '€'),
                                        image: reviewList[index]['media\$content']['url'],
                                        description: reviewList[index]['description']['__cdata'],
                                        date: reviewList[index]['pubDate'].toString(),
                                        link: reviewList[index]['link']['\$t'],
                                      );
                                    }
                                  ));
                                },
                                horizontalTitleGap: 10,
                                minVerticalPadding: 10,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10
                                ),
                                title: Text(
                                  reviewList[index]['title']['__cdata'].toString().replaceAll('â', "‘").replaceAll('â', '’').replaceAll('â', '-').replaceAll('â¬', '€'),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis
                                ),
                                leading: CachedNetworkImage(
                                  imageUrl: reviewList[index]['media\$content']['url'],
                                  fit: BoxFit.cover,
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                              
                            );
                          }
                        )
              
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}
