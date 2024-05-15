import '../firebase_constants/firebase_constants.dart';
import '../models/user_model.dart';
import '../services/shared_preferences.dart';

UserModel? userModel;

Future<void> getUserData({
  required String id,
  required String password,
}) async {
  var data = await usersFirestore.doc(id).get();
  userModel = UserModel.fromJson(data.data());
  setSharedPreferences('username', userModel?.username);
  setSharedPreferences('email', userModel?.email);
  setSharedPreferences('password', password);
  setSharedPreferences('image', userModel?.image);
}
