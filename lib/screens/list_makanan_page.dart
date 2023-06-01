import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail_makanan.dart';

class ListMakananPage extends StatefulWidget {
  final String category;

  const ListMakananPage({required this.category});

  @override
  _ListMakananPageState createState() => _ListMakananPageState();
}

class _ListMakananPageState extends State<ListMakananPage> {
  List makanan = [];

  @override
  void initState() {
    super.initState();
    fetchMakananByCategory();
  }

  Future<void> fetchMakananByCategory() async {
    final response = await http.get(
      Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/filter.php?c=${widget.category}'),
    );

    if (response.statusCode == 200) {
      setState(() {
        makanan = json.decode(response.body)['meals'];
      });
    }
  }

  void navigateToDetailPage(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailMakananPage(id: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Makanan'),
      ),
      body: ListView.builder(
        itemCount: makanan.length,
        itemBuilder: (context, index) {
          final makananItem = makanan[index];
          final makananGambar = makanan[index]['strMealThumb'];
          return ListTile(
            leading: Image.network(makananGambar),
            contentPadding: EdgeInsets.all(10),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              size: 17,
            ),
            title: Text(makananItem['strMeal']),
            onTap: () {
              navigateToDetailPage(makananItem['idMeal']);
            },
          );
        },
      ),
    );
  }
}
