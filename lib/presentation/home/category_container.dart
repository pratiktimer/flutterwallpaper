import 'package:flutter/material.dart';
import 'package:flutterwallpaper/core/resources/data_state.dart';
import 'package:flutterwallpaper/domain/entities/category.dart';
import 'package:flutterwallpaper/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryContainer extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallpaperRepository = ref.watch(wallpaperRepositoryProvider);

    // Call the fetchWallpapers method to retrieve the data from the repository
    // For example, you can use FutureBuilder or StreamBuilder to handle the async operation
    return SizedBox(
      height: 500,
      child: FutureBuilder<DataState<List<CategoryeEntity>>>(
        future: wallpaperRepository.fetchCategories(),
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
              return GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: wallpaperList?.length ?? 0,
                itemBuilder: (context, index) {
                  String? nameCategory = wallpaperList?[index].name ?? "pexels";
                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Card(
                      child: Row(
                        children: [
                          Image.network(
                            wallpaperList?[index].url ?? "pexels",
                            width: 60,
                            height: 60,
                            alignment: Alignment.center,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              nameCategory,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
