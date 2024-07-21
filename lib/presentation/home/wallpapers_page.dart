import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterwallpaper/presentation/home/location_item.dart';
import 'package:flutterwallpaper/presentation/providers/favourite_controller.dart';
import 'package:flutterwallpaper/presentation/providers/wallpaper_list_notifier.dart';
import 'package:flutterwallpaper/presentation/widgets/wallpaper_clipper.dart';
import 'package:flutterwallpaper/presentation/windows_scroll_behaviour.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../config/theme/routes/routes.dart';

class WallaperListPage extends HookConsumerWidget {
  final int page;
  final String category;
  final ScrollController _scrollController = ScrollController();
  late FavoritesStateNotifier _favController;

  WallaperListPage({key, required this.page, required this.category});

  Future<void> init(WidgetRef ref) async {
    _favController = await ref.read(favRepositoryProvider.future);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(wallpaperListNotifierProvider(category));

    init(ref);

    // Add a listener to the ScrollController to load more items when reaching the end
    onLoadMoreListener(ref);

    return Scaffold(
      body: asyncValue.when(
        data: (wallpaperList) => LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          // Determine the number of columns based on the screen width
          int columns;
          if (constraints.maxWidth >= 1200) {
            columns = 8; // Large screens
          } else if (constraints.maxWidth >= 800) {
            columns = 6; // Medium screens
          } else if (constraints.maxWidth >= 600) {
            columns = 4; // Smaller screens
          } else {
            columns = 2; // Smallest screens
          }
          return ScrollConfiguration(
              behavior: WindowsScrollBehaviour(),
              child: MasonryGridView.count(
                controller: _scrollController,
                itemCount: (wallpaperList.length),
                crossAxisCount: columns,
                mainAxisSpacing: Device.get().isTablet ? 4 : 2,
                crossAxisSpacing: Device.get().isTablet ? 4 : 2,
                itemBuilder: (context, index) {
                  //bool isFav = _favController.isFavorite(wallpaperList[index]);
                  return LocationListItem(
                      imageUrl: wallpaperList[index].listimageUrl,
                      name: "",
                      country: "",
                      index: index,
                      category: category,
                      favController: _favController);
                },
              ));
        }),
        error: (_, __) => const Text('No wallpapers available.'),
        loading: () => Center(
            child: SpinKitSpinningLines(
                color: Theme.of(context).primaryColor, size: 250.0)),
      ),
    );
  }

  void onLoadMoreListener(WidgetRef ref) {
    // Add a listener to the ScrollController to load more items when reaching the end
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ref
            .read(wallpaperListNotifierProvider(category).notifier)
            .loadMoreItems(category);
      }
    });
  }
}
