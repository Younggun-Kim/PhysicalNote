/// 부상 체크 방향 타입.
enum InjuryCheckDirectionType {
  front(serverKey: 'FRONT'),
  back(serverKey: 'BACK');

  final String serverKey;

  const InjuryCheckDirectionType({required this.serverKey});
}
