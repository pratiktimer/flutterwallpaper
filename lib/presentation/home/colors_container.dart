import 'package:flutter/material.dart';
import 'package:flutterwallpaper/core/resources/data_state.dart';
import 'package:flutterwallpaper/core/util/color_converter.dart';
import 'package:flutterwallpaper/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/color_category.dart';

class ColorsConatiner extends HookConsumerWidget {
  const ColorsConatiner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallpaperRepository = ref.watch(wallpaperRepositoryProvider);

    // Call the fetchWallpapers method to retrieve the data from the repository
    // For example, you can use FutureBuilder or StreamBuilder to handle the async operation
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: FutureBuilder<DataState<List<ColorCategoryEntity>>>(
        future: wallpaperRepository.fetchColorCategories(),
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
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: wallpaperList?.length ?? 0,
                itemBuilder: (context, index) {
                  String? imageUrl = wallpaperList?[index].name ?? "pexels";
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: wallpaperList?[index].hexValue.toColor(),
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                      width: 60,
                      height: 60,
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
