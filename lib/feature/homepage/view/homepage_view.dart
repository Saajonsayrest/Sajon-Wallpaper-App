import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app/view/search_widget.dart';
import 'package:untitled1/app/view/set_wallpaper.dart';
import 'package:untitled1/extensions/padding_extensions.dart';
import 'package:untitled1/feature/favorites/model/favorite_model.dart';
import 'package:untitled1/feature/favorites/provider/favorite_provider.dart';

import '../provider/homepageProvider.dart';

class HomepageView extends ConsumerWidget {
  const HomepageView({Key? key}) : super(key: key);

  static const routeName = '/homepage';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> _onSearch(String value) async {
      await ref.read(homepageProvider.notifier).getHomepage(searchQuery: value);
    }

    final asyncData = ref.watch(homepageProvider);
    final favoriteNotifier = ref.watch(favoriteProvider.notifier);

    return Column(
      children: [
        SearchButtonWidget(
          onSearch: _onSearch,
          border: 10.w,
        ).pXY(15.w, 10.h),
        Expanded(
          child: asyncData.when(
            data: (data) {
              return MasonryGridView.builder(
                shrinkWrap: true,
                itemCount: data.photos!.length,
                itemBuilder: (context, index) {
                  final photo = data.photos![index];
                  final isFavorite = favoriteNotifier.isFavorite(photo.id!);
                  double ht = ((index % 4 + 2) * 80);

                  return GestureDetector(
                    onTap: () {
                      _showImageDialog(
                        context,
                        photo.src!.portrait!,
                        photo.id!,
                        isFavorite,
                        favoriteNotifier,
                        photo.src!.original!,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(6.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: CachedNetworkImage(
                          imageUrl: photo.src!.large!,
                          height: ht,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
              );
            },
            error: (error, _) {
              return Center(child: Text(error.toString()));
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl, int photoId,
      bool isFavorite, FavoriteNotifier favoriteNotifier, String originalUrl) {
    bool _isLoading = false;
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
                              if (isFavorite) {
                                favoriteNotifier.removeFromFavorites(photoId);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Removed from favorites')),
                                );
                              } else {
                                favoriteNotifier.addToFavorites(
                                  FavoriteModel(
                                    id: photoId,
                                    imageUrl: originalUrl,
                                    isFavorite: true,
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Added to favorites')),
                                );
                              }
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
