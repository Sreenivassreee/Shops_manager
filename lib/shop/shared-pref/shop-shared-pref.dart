import 'package:shared_preferences/shared_preferences.dart';

loginSetShopLoginDetails({shopName, managerName, isLogin}) async {
  SharedPreferences p = await SharedPreferences.getInstance();
  p.setString('shop-name', shopName);
  p.setString('manager-name', managerName);
  p.setBool('is-login', isLogin);
}

logout()async{
  SharedPreferences p = await SharedPreferences.getInstance();
  p.setString('shop-name', '');
  p.setString('manager-name', '');
  p.setBool('is-login', false);
}
