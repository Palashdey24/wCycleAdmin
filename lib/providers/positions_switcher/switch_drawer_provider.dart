import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchDrawerProviderNotifier extends StateNotifier<bool> {
  SwitchDrawerProviderNotifier() : super(true);

  void onChangeDrawer(bool onDrawer) {
    state = !onDrawer;
  }
}

final swichDrawerProviders =
    StateNotifierProvider<SwitchDrawerProviderNotifier, bool>(
  (ref) {
    return SwitchDrawerProviderNotifier();
  },
);
