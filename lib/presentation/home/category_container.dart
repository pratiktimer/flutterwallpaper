import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterwallpaper/core/resources/data_state.dart';
import 'package:flutterwallpaper/domain/entities/category.dart';
import 'package:flutterwallpaper/presentation/providers/wallpaper_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../config/theme/routes/routes.dart';

class CategoryContainer extends HookConsumerWidget {
  const CategoryContainer({key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallpaperRepository = ref.watch(wallpaperRepositoryProvider);

    // Call the fetchWallpapers method to retrieve the data from the repository
    // For example, you can use FutureBuilder or StreamBuilder to handle the async operation
    return SizedBox(
      height: (MediaQuery.of(context).size.height / 2) - 50,
      child: FutureBuilder<DataState<List<CategoryeEntity>>>(
        future: wallpaperRepository.fetchCategories(),
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
              return GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: wallpaperList?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: GestureDetector(
                      onTap: () => {
                        // Navigate to the DetailScreen using MaterialPageRoute
                        AppRoutes.onWallpaerCategoryPressed(
                            context, 1, wallpaperList![index].categoryName)
                      },
                      child: Card(
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: FadeInImage.memoryNetwork(
                                width: 80,
                                placeholder: kTransparentImage,
                                image: wallpaperList![index].imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                wallpaperList![index].categoryName,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 70, crossAxisCount: 2),
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
