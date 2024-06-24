import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app/view/set_wallpaper.dart';
import 'package:untitled1/feature/favorites/provider/favorite_provider.dart';

class FavoriteView extends ConsumerWidget {
  const FavoriteView({super.key});

  static const routeName = '/favorite';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritePhotos = ref.watch(favoriteProvider);
    final favoriteNotifier = ref.watch(favoriteProvider.notifier);

    return favoritePhotos.isEmpty
        ? const Center(child: Text('No favorite photos'))
        : MasonryGridView.builder(
            itemCount: favoritePhotos.length,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              double ht = ((index % 4 + 3) * 80);
              final photo = favoritePhotos[index];
              return GestureDetector(
                onTap: () {
                  _showImageDialog(context, photo.imageUrl, photo.id, true,
                      favoriteNotifier);
                },
                child: Padding(
                  padding: EdgeInsets.all(6.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CachedNetworkImage(
                      imageUrl: photo.imageUrl,
                      height: ht,
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                      )),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
  }

  void _showImageDialog(BuildContext context, String imageUrl, int photoId,
      bool isFavorite, FavoriteNotifier favoriteNotifier) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Consumer(
          builder: (context, ref, child) {
            final isFavorite = favoriteNotifier.isFavorite(photoId);

            return Dialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CachedNetworkImage(
                      height: 500.h,
                      width: 400.w,
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                      )),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              favoriteNotifier.removeFromFavorites(photoId);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Removed from favorites')),
                              );
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 60.h,
                              color: Colors.teal.shade300,
                              child: Center(
                                child: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SetWallpaperWidget(imageUrl)
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
