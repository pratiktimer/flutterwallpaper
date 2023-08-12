import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final internetControllerProvider =
    StateNotifierProvider<InternetController, AsyncValue<bool>>((ref) {
  return InternetController();
});

class InternetController extends StateNotifier<AsyncValue<bool>> {
  InternetController() : super(const AsyncValue.loading());

  Future<void> checkConnectivity({bool isRefreshing = false}) async {
    if (isRefreshing) state = const AsyncValue.loading();
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (mounted) {
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          state = const AsyncValue.data(true);
        } else {
          state = const AsyncValue.data(false);
        }
      }
    } catch (ex) {
      state = AsyncValue.error(ex, StackTrace.current);
    }
  }
}
