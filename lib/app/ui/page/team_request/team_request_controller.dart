import 'package:physical_note/app/utils/getx/base_controller.dart';
import 'package:physical_note/app/utils/sns/logout.dart';

class TeamRequestController extends BaseController {
  void logout() {
    Logout.logout();
  }
}
