import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wcycle_admin_panel/screen/home_screen.dart';

class ActPagePosProviderNotifiers extends StateNotifier<int> {
  ActPagePosProviderNotifiers() : super(0);

  void changeActivePostions(int actPos, BuildContext context) {
    state = actPos;
    context.go("/home/${HomeScreen.pages[state].pageName}");
  }
}

final actPagePosProviders =
    StateNotifierProvider<ActPagePosProviderNotifiers, int>(
  (ref) {
    return ActPagePosProviderNotifiers();
  },
);
