import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_technonews_app/read_more.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final String image;
  final String description;
  final String date;
  final String link;

  const DetailScreen({
    super.key, 
    required this.title, 
    required this.image, 
    required this.description, 
    required this.date,
    required this.link,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          alignment: Alignment.centerLeft,
          child: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ),
        backgroundColor: const Color.fromARGB(255, 1, 1, 27),
        title: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 50, 0),
          child: Center(
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(text: 'Techno ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  TextSpan(text: 'News', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 25)),
                ],
              ),
            ),
          ),
        )
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: widget.image,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title.toString().replaceAll('â', "‘").replaceAll('â', '’'),
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    widget.date.toString().replaceRange(0, 5, '').replaceRange(16, 32, ''),
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13)
                  )
                ),

                const Divider(
                  color: Colors.white,
                  indent: 0,
                  endIndent: 0,
                  height: 5,
                  thickness: 1,
                ),

                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Text(
                    widget.description.toString().replaceAll('\\n', '\\').replaceAll('\\', '').toString().replaceAll('â', "‘").replaceAll('â', '’').replaceAll('â', '-'),
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16)
                  ),
                ),
              ]
            ), 
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: OutlinedButton(
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => ReadMore(link: widget.link.toString()),
                ),
              );
            },
            child: const Text('Read More',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white)
            ),
          ),
      ),
    );
  }
}