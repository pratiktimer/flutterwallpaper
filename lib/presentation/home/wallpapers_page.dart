import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterwallpaper/presentation/home/wallpaper_detail.dart';
import 'package:flutterwallpaper/presentation/providers/wallpaper_list_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WallaperListPage extends HookConsumerWidget {
  final int page;
  final String category;
  final ScrollController _scrollController = ScrollController();

  WallaperListPage({super.key, required this.page, required this.category});

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
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
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
                    clipper: MovieTicketBothSidesClipper(),
                    child: FadeInImage(
                      placeholder: const AssetImage('images/placeholder.png'),
                      image: NetworkImage(wallpaperList[index].listimageUrl),
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

class MovieTicketBothSidesClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    //Arranca desde la punta topLeft
    Path path = Path();
    path.lineTo(0.0, size.height);
    //Inicio de las puntas
    double x = 0;
    //Altura inicial de las puntas
    double y = size.height;
    //Altura de control point. Por aca se va a hacer la curva
    double yControlPoint = size.height * .90;
    //El width que se va a ir corriendo por cada linea
    double increment = size.width / 40;

    while (x < size.width) {
      // La curva va a iniciar en x y terminar en x+increment.
      // Y le digo que el punto de la curva tiene que ser en x + la mitad de increment (punto de control x)
      path.quadraticBezierTo(
          x + increment / 2, yControlPoint, x + increment, y);
      x += increment;
    }

    path.lineTo(size.width, 0.0);

    while (x > 0) {
      // Vuelvo a iterar pero esta vez restando el incremento
      // Voy desde topRight a topLeft
      path.quadraticBezierTo(
          x - increment / 2, size.height * .15, x - increment, 0);
      x -= increment;
    }
    // path.lineTo(x, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) {
    return old != this;
  }
}
