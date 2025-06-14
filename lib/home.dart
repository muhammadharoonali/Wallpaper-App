import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginapi/setwall.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int page = 1;
  List photos = [];
  @override
  Future<void> getapi() async {
    final response = await http.get(
      Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
      headers: {
        "Authorization":
            "i5OxivpjnjrGtg2whQPUlyMpKig5ZmFcxyficsUipYZgjiacpBVRX9OH",
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      setState(() {
        photos = data['photos'];
      });
    } else {
      print('Failed to load data');
    }
  }

  Future<void> loadmore() async {
    String url = 'https://api.pexels.com/v1/curated?per_page=80=$page';
    setState(() {
      page = page + 1;
    });

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization":
            "i5OxivpjnjrGtg2whQPUlyMpKig5ZmFcxyficsUipYZgjiacpBVRX9OH",
      },
    );
    var data = jsonDecode(response.body.toString());
    setState(() {
      photos.addAll(data['photos']);
    });
  }

  @override
  void initState() {
    super.initState();
    getapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'My Wallpapers',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: photos.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => setwall(
                              imageurl: photos[index]['src']['large2x'],
                            ),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    color: const Color.fromARGB(255, 190, 142, 142),
                    child: Image.network(
                      photos[index]['src']['small'],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),

          InkWell(
            onTap: () {
              loadmore();
            },
            child: Container(
              height: 40,
              width: double.infinity,
              color: const Color.fromARGB(255, 190, 222, 31),
              child: Center(
                child: Text(
                  'Load More',
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
