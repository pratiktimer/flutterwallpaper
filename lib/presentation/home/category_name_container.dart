import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterwallpaper/core/resources/data_state.dart';
import 'package:flutterwallpaper/domain/entities/category_name.dart';
import 'package:flutterwallpaper/presentation/home/wallpapers_page.dart';
import 'package:flutterwallpaper/presentation/providers/wallpaper_repository_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/theme/routes/routes.dart';

class CategoryNamesContainer extends HookConsumerWidget {
  const CategoryNamesContainer({key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallpaperRepository = ref.watch(wallpaperRepositoryProvider);

    // Call the fetchWallpapers method to retrieve the data from the repository
    // For example, you can use FutureBuilder or StreamBuilder to handle the async operation
    return SizedBox(
      height: 50,
      child: FutureBuilder<DataState<List<CategoryNameEntity>>>(
        future: wallpaperRepository.fetchNameCategories(),
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
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: wallpaperList?.length ?? 0,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => {
                      // Navigate to the DetailScreen using MaterialPageRoute
                      AppRoutes.onWallpaerCategoryPressed(
                          context, 1, wallpaperList![index].categoryName)
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            4.0), // Adjust the radius as needed
                        side: const BorderSide(
                          width: 0.5, // Specify the border width
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            wallpaperList![index].categoryName,
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge),
                          ),
                        ),
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
