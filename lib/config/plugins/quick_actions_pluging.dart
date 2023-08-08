import 'package:miscelanius/config/router/routes.dart';
import 'package:quick_actions/quick_actions.dart';

class QuickActionsPlugins {
  static registrarActions() {
    const QuickActions quickActions = QuickActions();
    quickActions.initialize((shortcutType) {
      print(shortcutType);
      switch (shortcutType) {
        case "biometric":
          router.push('/Biometricos');
          break;
        case "compass":
          router.push('/compass');
          break;
        case "maps":
          router.push('/Controlled-map');
          break;
        case "charmander":
          router.push('/pokemons/4');
          break;
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
          type: 'biometric', localizedTitle: 'Biometrico', icon: 'finger'),
      const ShortcutItem(
          type: 'compass', localizedTitle: 'Brujula', icon: 'compass'),
      const ShortcutItem(
          type: 'maps', localizedTitle: 'Mapa', icon: 'compass'),
      const ShortcutItem(
          type: 'charmander', localizedTitle: 'Charmander', icon: 'pokemons'),
    ]);
  }
}
