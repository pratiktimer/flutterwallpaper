import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterwallpaper/presentation/home/wallpaper_detail.dart';
import 'package:flutterwallpaper/presentation/providers/wallpaper_list_notifier.dart';
import 'package:flutterwallpaper/presentation/widgets/wallpaper_clipper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';

class WallaperListPage extends HookConsumerWidget {
  final int page;
  final String category;
  final ScrollController _scrollController = ScrollController();

  WallaperListPage({key, required this.page, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(wallpaperListNotifierProvider(category));

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
            return GestureDetector(
                onTap: () => {
                      // Navigate to the DetailScreen using MaterialPageRoute
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WallaperDetailPage(
                                page: page, category: category, index: index),
                          )),
                    },
                child: ClipPath(
                    clipper: WallpaperTicketBothSidesClipper(),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: (wallpaperList[index].listimageUrl),
                      fit: BoxFit.cover,
                    )));
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
