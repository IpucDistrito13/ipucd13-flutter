import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/admin/auth/domain/domain.dart';
import '../../features/admin/auth/presentation/providers/providers.dart';

final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

class GoRouterNotifier extends ChangeNotifier {
  final AuthNotifier _authNotifier;

  AuthStatus _authStatus = AuthStatus.checking;
  UsuarioAuth? _user; //Para los roles

  GoRouterNotifier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.authStatus;
      user = state.user;
    });
  }

  AuthStatus get authStatus => _authStatus;
  UsuarioAuth? get user => _user;

  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }

  set user(UsuarioAuth? value) {
    _user = value;
    notifyListeners();
  }
}
