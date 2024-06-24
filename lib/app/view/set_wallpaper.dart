import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:untitled1/app/view/awsome_snackbar.dart';

class SetWallpaperWidget extends StatefulWidget {
  const SetWallpaperWidget(this.imageUrl, {super.key});

  final String? imageUrl;

  @override
  _SetWallpaperWidgetState createState() => _SetWallpaperWidgetState();
}

class _SetWallpaperWidgetState extends State<SetWallpaperWidget> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          setState(() {
            _isLoading = true;
          });

          // Show the progress indicator for 2 seconds
          Timer(const Duration(seconds: 2), () async {
            int location =
                WallpaperManager.BOTH_SCREEN; // can be Home/Lock Screen
            var file = await DefaultCacheManager()
                .getSingleFile(widget.imageUrl ?? '');
            bool result = await WallpaperManager.setWallpaperFromFile(
              file.path,
              location,
            );

            setState(() {
              _isLoading = false;
            });

            if (result) {
              awsomeSnackbar(
                context,
                'Success',
                'Set as wallpaper successfully',
                ContentType.success,
              );
            } else {
              awsomeSnackbar(
                context,
                'Error',
                'Failed to set wallpaper',
                ContentType.failure,
              );
            }
            Navigator.pop(context); // Dismiss the dialog
          });
        },
        child: Container(
          height: 60.h,
          color: Colors.yellow,
          child: Center(
            child: _isLoading
                ? SizedBox(
                    height: 25.h,
                    width: 25.w,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                    ),
                  )
                : const Text('Set As Wallpaper'),
          ),
        ),
      ),
    );
  }
}
