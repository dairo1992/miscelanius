import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth_android/local_auth_android.dart';

class LocalAuthPlugin {
  static final LocalAuthentication auth = LocalAuthentication();

  static availableBiometrics() async {
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
    }

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
      // Specific types of biometrics are available.
      // Use checks like this with caution!
    }
  }

  static Future<bool> canCheckBiometric() async {
    return await auth.canCheckBiometrics;
  }

  static Future<(bool, String)> authenticate({bool biometricOnly = false}) async {
    try {
      final bool didAuthenticate = await auth.authenticate(
    localizedReason: "Por favor autenticate para continuar",
    authMessages: <AuthMessages>[
      const AndroidAuthMessages(
        signInTitle: "Verificacion",
        cancelButton: "Cancelar "
      )
    ],
    options: AuthenticationOptions(
      biometricOnly: biometricOnly // en false podemos poner el PIN como otra opcion
      ));
      return(didAuthenticate, didAuthenticate ? "Autenticado correctamente" : "Cancelado por usuario");
    } on PlatformException catch (e) {
      print(e);
      if (e.code == auth_error.notEnrolled) {
        return (false, "No hay biometricos enrolados");
      }
      if (e.code == auth_error.lockedOut) {
        return (false, "Muchos intentos fallifos");
      }
      if (e.code == auth_error.notAvailable) {
        return (false, "No hay biometricos disponibles");
      }
      if (e.code == auth_error.passcodeNotSet) {
        return (false, "No hay un pin configurado");
      }
      if (e.code == auth_error.permanentlyLockedOut) {
        return (false, "Se requiere desbloquear el dispositivo");
      }
      return (false, e.toString());
    }
  }
}
