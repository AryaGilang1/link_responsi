import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMakananPage extends StatefulWidget {
  final String id;

  const DetailMakananPage({required this.id});

  @override
  _DetailMakananPageState createState() => _DetailMakananPageState();
}

class _DetailMakananPageState extends State<DetailMakananPage> {
  Map<String, dynamic> makananDetail = {};

  @override
  void initState() {
    super.initState();
    fetchMakananDetail();
  }

  Future<void> fetchMakananDetail() async {
    final response = await http.get(
      Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.id}'),
    );

    if (response.statusCode == 200) {
      setState(() {
        makananDetail = json.decode(response.body)['meals'][0];
      });
    }
  }

  void launchYouTubeVideo(String url) {
    // Implementasi Url Launcher untuk membuka video YouTube
  }
  final Uri _url = Uri.parse('https://flutter.dev');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Makanan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              makananDetail['strMealThumb'],
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    makananDetail['strMeal'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Category: ${makananDetail['strCategory']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Area: ${makananDetail['strArea']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Instructions: ${makananDetail['strInstructions']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: _launchUrl,
                    child: Text('Watch Video'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
