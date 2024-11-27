
import 'package:user_career_core/user_career_core.dart';

class EntityDecoder {
  EntityDecoder._();

  static T valueOf<T>(dynamic data, {required T or}) {
    if (data == null || data == '') return or;
    return data;
  }

  static T? decodeBy<T>(dynamic data, T Function(dynamic json) itemDecoder) {
    if (data == null || data == '') return null;

    try {
      return itemDecoder(data);
    } catch (e, s) {
      talker.log("EntityDecoder.decodeBy",
          logLevel: LogLevel.error, exception: e, stackTrace: s);
      return null;
    }
  }

  static List<T> decodeListBy<T>(
      dynamic data, T Function(dynamic item) itemDecoder) {
    if (data == null || data == '') return [];

    try {
      return ListDecoder(data).decodeJsonBy(itemDecoder);
    } catch (e, s) {
      talker.log("EntityDecoder.decodeListBy",
          logLevel: LogLevel.error, exception: e, stackTrace: s);
      return [];
    }
  }
}
