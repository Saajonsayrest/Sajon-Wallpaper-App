import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/feature/dashboard/provider/favorite_provider.dart';

class FavoriteView extends ConsumerWidget {
  const FavoriteView({super.key});

  static const routeName = '/favorite';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritePhotos = ref.watch(favoriteProvider);
    final favoriteNotifier = ref.watch(favoriteProvider.notifier);

    return favoritePhotos.isEmpty
        ? const Center(child: Text('No favorite photos'))
        : GridView.builder(
            itemCount: favoritePhotos.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemBuilder: (context, index) {
              final photo = favoritePhotos[index];
              return GestureDetector(
                onTap: () {
                  _showImageDialog(context, photo.imageUrl, photo.id, true,
                      favoriteNotifier);
                },
                child: CachedNetworkImage(
                  imageUrl: photo.imageUrl,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
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
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
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
                        Expanded(
                          child: Container(
                            height: 60.h,
                            color: Colors.yellow,
                            child: const Center(
                              child: Text('Set As Wallpaper'),
                            ),
                          ),
                        ),
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
