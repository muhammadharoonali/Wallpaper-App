import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class setwall extends StatefulWidget {
  var imageurl;
  setwall({super.key, required this.imageurl});

  @override
  State<setwall> createState() => _setwallState();
}

class _setwallState extends State<setwall> {
  Future<void> setwallpaper() async {
    int locations = WallpaperManager.BOTH_SCREEN;
    var files = await DefaultCacheManager().getSingleFile(widget.imageurl);
    bool result = await WallpaperManager.setWallpaperFromFile(
      files.path,
      locations,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imageurl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          InkWell(
            onTap: () {
              setwallpaper();
            },
            child: Container(
              height: 40,
              width: double.infinity,
              color: const Color.fromARGB(255, 72, 222, 31),
              child: Center(
                child: Text(
                  'Set Wallpaper',
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
