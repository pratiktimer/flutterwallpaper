import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterwallpaper/core/resources/data_state.dart';
import 'package:flutterwallpaper/domain/entities/category_name.dart';
import 'package:flutterwallpaper/presentation/home/wallpapers_page.dart';
import 'package:flutterwallpaper/presentation/providers/wallpaper_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryNamesContainer extends HookConsumerWidget {
  const CategoryNamesContainer({super.key});

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
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            nameCategory,
                            style: Theme.of(context).textTheme.titleMedium,
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
