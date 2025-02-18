import 'entity/assignment_entity.dart';

abstract class AssignmentUseCase {
  List<AssignmentEntity> getFeedbacks();
}

class AssignmentUseCaseImpl implements AssignmentUseCase {
  @override
  List<AssignmentEntity> getFeedbacks() {
    return [];
  }
}
