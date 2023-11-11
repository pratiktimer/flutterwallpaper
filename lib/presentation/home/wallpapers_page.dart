import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterwallpaper/presentation/home/wallpaper_detail.dart';
import 'package:flutterwallpaper/presentation/providers/favourite_controller.dart';
import 'package:flutterwallpaper/presentation/providers/wallpaper_list_notifier.dart';
import 'package:flutterwallpaper/presentation/widgets/wallpaper_clipper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../config/theme/routes/routes.dart';

class WallaperListPage extends HookConsumerWidget {
  final int page;
  final String category;
  final ScrollController _scrollController = ScrollController();
  //late FavoritesStateNotifier _favController;

  WallaperListPage({key, required this.page, required this.category});

  // Future<void> init(WidgetRef ref) async {
  //   _favController = await ref.read(favRepositoryProvider.future);
  //   await _favController.fetchFavorites();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(wallpaperListNotifierProvider(category));

    //init(ref);

    // Add a listener to the ScrollController to load more items when reaching the end
    onLoadMoreListener(ref);

    return Scaffold(
      body: asyncValue.when(
        data: (wallpaperList) => MasonryGridView.count(
          controller: _scrollController,
          itemCount: (wallpaperList.length),
          crossAxisCount: Device.get().isTablet ? 4 : 2,
          mainAxisSpacing: Device.get().isTablet ? 4 : 2,
          crossAxisSpacing: Device.get().isTablet ? 4 : 2,
          itemBuilder: (context, index) {
            //bool isFav = _favController.isFavorite(wallpaperList[index]);
            return Hero(
              tag: index.toString(),
              child: Material(
                child: InkWell(
                  onTap: () => {
                    // Navigate to the DetailScreen using MaterialPageRoute
                    AppRoutes.onWallpaperItemPressed(
                        context, 1, category, index)
                  },
                  child: ClipPath(
                      clipper: WallpaperTicketBothSidesClipper(),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: (wallpaperList[index].listimageUrl),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            );
          },
        ),
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
