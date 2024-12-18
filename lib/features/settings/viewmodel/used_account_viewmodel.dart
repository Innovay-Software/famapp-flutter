import '../../../core/abstracts/inno_viewmodel.dart';
import '../model/used_account.dart';
import 'usecases/get_used_accounts.dart';
import 'usecases/save_used_accounts.dart';
import 'user_viewmodel.dart';

class UsedAccountViewmodel extends InnoViewmodel {
  static final UsedAccountViewmodel _instance = UsedAccountViewmodel._();
  factory UsedAccountViewmodel() => _instance;
  UsedAccountViewmodel._();

  final List<UsedAccount> _usedAccounts = [];
  List<UsedAccount> get usedAccounts => _usedAccounts;

  Future<bool> getUsedAccounts() async {
    final useCase = GetUsedAccounts();
    _usedAccounts.clear();
    _usedAccounts.addAll(await useCase.call());
    notifyListeners();
    return true;
  }

  Future<bool> saveUsedAccounts() async {
    final useCase = SaveUsedAccounts();
    final successful = await useCase.call(usedAccounts: _usedAccounts);
    notifyListeners();
    return successful;
  }

  Future<bool> addToUsedAccount(UsedAccount usedAccount) async {
    for (var i = 0; i < _usedAccounts.length; i++) {
      if (_usedAccounts[i].mobile == usedAccount.mobile) {
        _usedAccounts[i] = usedAccount;
        await saveUsedAccounts();
        return true;
      }
    }
    usedAccounts.insert(0, usedAccount);
    await saveUsedAccounts();
    return true;
  }

  Future<bool> moveUsedAccountToFirst(UsedAccount usedAccount) async {
    if (_usedAccounts.isEmpty || _usedAccounts.first != usedAccount) {
      _usedAccounts.remove(usedAccount);
      _usedAccounts.insert(0, usedAccount);
      await saveUsedAccounts();
      notifyListeners();
    }
    return true;
  }

  Future<bool> deleteUsedAccount(String mobile) async {
    for (var i = 0; i < _usedAccounts.length; i++) {
      if (_usedAccounts[i].mobile == mobile) {
        _usedAccounts.removeAt(i);
        break;
      }
    }
    await saveUsedAccounts();
    notifyListeners();
    return true;
  }

  Future<bool> onSelectUsedAccount(UsedAccount usedAccount) async {
    var currentLoggedInMobile = '';
    if (UserViewmodel().currentUser.isLoggedIn) {
      currentLoggedInMobile = UserViewmodel().currentUser.mobile;
    }
    if (usedAccount.mobile == currentLoggedInMobile) {
      return false;
    } else {
      await moveUsedAccountToFirst(usedAccount);
      return true;
    }
  }
}
