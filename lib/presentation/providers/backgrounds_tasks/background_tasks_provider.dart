import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelanius/config/config.dart';
import 'package:workmanager/workmanager.dart';

class BackgrounFetchNotifier extends StateNotifier<bool?> {
  final String processKeyName;

  BackgrounFetchNotifier({required this.processKeyName}) : super(false) {
    checkCurrentStatus();
  }

  checkCurrentStatus() async {
    state = await SharePreferencesPlugin.getBool(processKeyName) ?? false;
  }

  toggleProcess() {
    if (state == true) {
      deactiveProcess();
    } else {
      activateProcess();
    }
  }

  activateProcess() async {
    //la primera vez se ejecuta de inmediato
    await Workmanager().registerPeriodicTask(processKeyName, processKeyName,
        frequency: const Duration(seconds: 10),
        constraints: Constraints(networkType: NetworkType.connected),
        tag: processKeyName); //automaticamente lo cambiara a 15 min
    await SharePreferencesPlugin.setBool(processKeyName, true);
    state = true;
  }

  deactiveProcess() async {
    await Workmanager().cancelByTag(processKeyName);
    await SharePreferencesPlugin.setBool(processKeyName, false);
    state = false;
  }
}

final backgrounPokemonFetchProvider =
    StateNotifierProvider<BackgrounFetchNotifier, bool?>((ref) {
  return BackgrounFetchNotifier(processKeyName: fetchPeriodicBackgroundTaskKey);
});
