import 'package:letsgupshup/feature/dashboard/data/model/user_model_firebase.dart';

abstract class DashboardDataSource {
  Future<List<DisplayUsers>> getUsersList();
}
