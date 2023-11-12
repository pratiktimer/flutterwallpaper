import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:flutterwallpaper/presentation/providers/favourite_controller.dart';
import 'package:flutterwallpaper/presentation/widgets/wallpaper_clipper.dart';
import '../../config/theme/routes/routes.dart';

class FavListPage extends HookConsumerWidget {
  FavListPage({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesProvider = ref.watch(favRepositoryProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 4 : 2;
    final spacing = screenWidth > 600 ? 4.0 : 2.0;

    return Scaffold(
      body: favoritesProvider.when(
        data: (wallpaperList) {
          final count = wallpaperList.state.value?.length ?? 0;
          if (count == 0) {
            return _buildEmptyView();
          }

          return MasonryGridView.count(
            itemCount: count,
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: spacing,
            crossAxisSpacing: spacing,
            itemBuilder: (context, index) =>
                _buildGridItem(context, index, wallpaperList, ref),
          );
        },
        error: (_, error) => Text('Error: $error'),
        loading: () => Center(
          child: SpinKitSpinningLines(
            color: Theme.of(context).primaryColor,
            size: 250.0,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                width: 400.0,
                height: 114.0,
                margin: const EdgeInsets.only(bottom: 30),
                child: const Hero(
                    tag: "mytry",
                    child: FlareActor("assets/Broken Heart.flr",
                        animation: "Heart Break", shouldClip: false))),
            Container(
              padding: const EdgeInsets.only(bottom: 21),
              width: 250,
              child: const Text("You haven’t favorited anything yet.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "RobotoMedium",
                    fontSize: 25,
                    height: 1.2,
                  )),
            ),
            Container(
              width: 270,
              margin: const EdgeInsets.only(bottom: 114),
              child: const Text(
                  "Browse through Wallpapers and tap on the heart icon to save something in this list.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 17,
                    height: 1.5,
                  )),
            ),
          ])
    ]);
  }

  Widget _buildGridItem(
    BuildContext context,
    int index,
    FavoritesStateNotifier favoritesNotifier,
    WidgetRef ref,
  ) {
    final wallpapers = favoritesNotifier.state.value;
    if (wallpapers == null || index >= wallpapers.length) {
      return _buildEmptyView(); // or another fallback widget
    }

    return Hero(
      tag: index.toString(),
      child: Material(
        child: InkWell(
          onTap: () async {
            AppRoutes.onFavItemPressed(context, index, favoritesNotifier, ref);
          },
          child: ClipPath(
            clipper: WallpaperTicketBothSidesClipper(),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: wallpapers[index].listimageUrl,
              fit: BoxFit.cover,
              // Provide a placeholder widget
              placeholderErrorBuilder: (context, error, stackTrace) {
                return const CircularProgressIndicator(); // Customize accordingly
              },
            ),
          ),
        ),
      ),
    );
  }
}
