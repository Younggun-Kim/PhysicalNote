/// 부상체크 몸통 타입.
enum InjuryCheckBodyType {
  upper(serverKey: "UPPER_BODY"),
  lower(serverKey: "LOWER_BODY");

  final String serverKey;

  const InjuryCheckBodyType({required this.serverKey});
}
