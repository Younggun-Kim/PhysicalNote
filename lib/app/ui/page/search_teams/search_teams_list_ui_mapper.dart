import 'package:physical_note/app/data/teams/model/teams_response_model.dart';
import 'package:physical_note/app/ui/page/search_teams/items/search_teams_list_item_ui_state.dart';
import 'package:physical_note/app/ui/page/search_teams/search_teams.dart';

extension SearchTeamsListUiMapper on SearchTeamsController {
  
  /// 이이템 매퍼.
  SearchTeamsListItemUiState searchTeamsListItemUiStateFrom(
          TeamsResponseModel data) =>
      SearchTeamsListItemUiState(
        id: data.id,
        imageUrl: data.profile ?? "",
        clubName: data.name,
        coachName: data.coachName ?? "",
        isSelected: false,
      );
}
