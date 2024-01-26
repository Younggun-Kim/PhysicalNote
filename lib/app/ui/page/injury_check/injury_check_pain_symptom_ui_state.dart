import 'package:physical_note/app/config/constant/pain_type.dart';

/// 통증 양상 uiState.
class InjuryCheckPainSymptomUiState {
  final PainType type;
  bool isSelected;

  InjuryCheckPainSymptomUiState({required this.type, this.isSelected = false });
}