import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:responsi_prak_mobile/screens/detail_makanan.dart';

import 'list_makanan_page.dart';

class MakananListCategory extends StatefulWidget {
  const MakananListCategory({Key? key}) : super(key: key);

  @override
  State<MakananListCategory> createState() => _MakananListCategoryState();
}

class _MakananListCategoryState extends State<MakananListCategory> {
  List categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
    );

    if (response.statusCode == 200) {
      setState(() {
        categories = json.decode(response.body)['categories'];
      });
    }
  }

  void navigateToListPage(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListMakananPage(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 700,
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index]['strCategory'];
                      final categoryImage =
                          categories[index]['strCategoryThumb'];
                      return ListTile(
                        leading: Image.network(categoryImage),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 17,
                        ),
                        title: Text(category),
                        onTap: () {
                          navigateToListPage(category);
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
