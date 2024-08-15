import 'package:physical_note/app/config/constant/pain_type.dart';

/// 통증 양상 uiState.
class InjuryDetailPainSymptomUiState {
  final PainType type;
  bool isSelected;

  InjuryDetailPainSymptomUiState({required this.type, this.isSelected = false });
}