import 'package:physical_note/app/ui/page/find_id_complete/items/find_id_compete_item_ui_state.dart';

class FindIdCompleteArgument {
  String name;

  String phone;

  List<FindIdCompleteItemUiState> accounts;

  String passCode;

  FindIdCompleteArgument({
    required this.name,
    required this.phone,
    required this.accounts,
    required this.passCode,
  });
}
