import 'environment.dart';

class Config {

  static late final Environment environment;

  static  bool get isProd => environment == Environment.prod;
  Config._();
}