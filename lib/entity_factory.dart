import 'package:weifangbus/entity/startUpBasicInfo_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "StartupbasicinfoEntity") {
      return StartupbasicinfoEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}