import 'package:flutter/material.dart';
import 'package:flutterwallpaper/core/util/color_converter.dart';
import 'package:flutterwallpaper/domain/entities/image_color_category.dart';
import 'package:flutterwallpaper/main.dart';
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
      height: 200,
      child: FutureBuilder<DataState<List<ImageColorCategoryEntity>>>(
        future: wallpaperRepository.fetchImageColorCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Use the snapshot.data to display the list of wallpapers
            if (snapshot.data?.data != null) {
              final wallpaperList = snapshot.data!.data;
              // Use the wallpaperList to build your UI
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: wallpaperList?.length ?? 0,
                itemBuilder: (context, index) {
                  String? nameCategory = wallpaperList?[index].name ?? "pexels";
                  return Container(
                    width: 140,
                    height: 200,
                    child: ColorCardWithImage(
                      imageUrl: wallpaperList?[index].imageUrl ?? "",
                      cardColor: wallpaperList?[index].hexValue.toColor() ??
                          Colors.white,
                      cardName: nameCategory,
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

  ColorCardWithImage({
    required this.imageUrl,
    required this.cardColor,
    required this.cardName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor.withOpacity(0.6),
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
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          // Colored card name at the left bottom
          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                cardName,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
