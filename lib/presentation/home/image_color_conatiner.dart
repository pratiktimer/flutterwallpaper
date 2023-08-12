import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterwallpaper/core/util/color_converter.dart';
import 'package:flutterwallpaper/domain/entities/image_color_category.dart';
import 'package:flutterwallpaper/presentation/home/wallpapers_page.dart';
import 'package:flutterwallpaper/presentation/providers/wallpaper_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/resources/data_state.dart';

class ImageColorConatiner extends HookConsumerWidget {
  const ImageColorConatiner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallpaperRepository = ref.watch(wallpaperRepositoryProvider);

    // Call the fetchWallpapers method to retrieve the data from the repository
    // For example, you can use FutureBuilder or StreamBuilder to handle the async operation
    return SizedBox(
      height: Device.get().isTablet ? 400 : 200,
      child: FutureBuilder<DataState<List<ImageColorCategoryEntity>>>(
        future: wallpaperRepository.fetchImageColorCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SpinKitSpinningLines(
                color: Theme.of(context).primaryColor, size: 50.0);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Use the snapshot.data to display the list of wallpapers
            if (snapshot.data?.data != null) {
              final wallpaperList = snapshot.data!.data;
              // Use the wallpaperList to build your UI
              return MasonryGridView.count(
                crossAxisCount: Device.get().isTablet ? 2 : 1,
                mainAxisSpacing: Device.get().isTablet ? 2 : 1,
                crossAxisSpacing: Device.get().isTablet ? 2 : 1,
                scrollDirection: Axis.horizontal,
                itemCount: wallpaperList?.length ?? 0,
                itemBuilder: (context, index) {
                  String? nameCategory = wallpaperList?[index].name ?? "pexels";
                  return GestureDetector(
                    onTap: () => {
                      // Navigate to the DetailScreen using MaterialPageRoute
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WallaperListPage(
                                page: 1,
                                category:
                                    wallpaperList![index].name ?? "Biker"),
                          )),
                    },
                    child: SizedBox(
                      width: 140,
                      height: 200,
                      child: ColorCardWithImage(
                        imageUrl: wallpaperList![index].defaultUrl,
                        cardColor: wallpaperList[index].hexValue.toColor() ??
                            Colors.white,
                        cardName: nameCategory,
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Text('No wallpapers available.');
            }
          }
        },
      ),
    );
  }
}

class ColorCardWithImage extends StatelessWidget {
  final String imageUrl;
  final Color cardColor;
  final String cardName;

  const ColorCardWithImage({
    super.key,
    required this.imageUrl,
    required this.cardColor,
    required this.cardName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor.withOpacity(0.5),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          // Positioned image beyond the top of the card
          Positioned(
              top:
                  -30, // Adjust the value to move the image beyond the top of the card
              left: 0,
              right: 0,
              height: 150,
              child: FadeInImage(
                placeholder: const AssetImage('images/placeholder.png'),
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              )),
          // Colored card name at the left bottom
          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                style: Theme.of(context).textTheme.bodyMedium,
                cardName,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
