import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterwallpaper/config/theme/routes/routes.dart';
import 'package:flutterwallpaper/core/resources/data_state.dart';
import 'package:flutterwallpaper/core/util/color_converter.dart';
import 'package:flutterwallpaper/presentation/home/wallpapers_page.dart';
import 'package:flutterwallpaper/presentation/providers/wallpaper_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/color_category.dart';

class ColorsConatiner extends HookConsumerWidget {
  const ColorsConatiner({key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallpaperRepository = ref.watch(wallpaperRepositoryProvider);

    // Call the fetchWallpapers method to retrieve the data from the repository
    // For example, you can use FutureBuilder or StreamBuilder to handle the async operation
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Device.get().isTablet ? 140 : 70,
      child: FutureBuilder<DataState<List<ColorCategoryEntity>>>(
        future: wallpaperRepository.fetchColorCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitSpinningLines(
                  color: Theme.of(context).primaryColor, size: 50.0),
            );
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
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: wallpaperList?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => {
                        // Navigate to the DetailScreen using MaterialPageRoute
                        AppRoutes.onWallpaerCategoryPressed(
                            context, 1, wallpaperList![index].categoryName)
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: wallpaperList?[index].hexValue.toColor(),
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
                        ),
                        width: 60,
                        height: 60,
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
