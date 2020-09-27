import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:weifangbus/entity/line/route_real_time_info_entity.dart';
import 'package:weifangbus/generated/json/base/json_convert_content.dart';
import 'package:weifangbus/util/dio_util.dart';

Future main() async {
  try {
    // http://122.4.254.30:1001/BusService/Query_ByRouteID/?RouteID=17&SegmentID=35505666&UniqueIdentifier=9719068B-E389-4D60-9C53-FA57E12FE1E2&LocationPos=112.610902,37.811552&TimeStamp=20200926171641&Random=331&SignKey=afe7c92dcd527a12a4f48146ddb77b51bc214700716e5b681c872bcb8519ad3f&
    Response response;
    var uri = "/BusService/Query_ByRouteID/?RouteID=17&SegmentID=35505666&" +
        getSignString();
    print(uri);
    response = await dio.get(uri);
    print(response.data);
    // List<dynamic> list = response.data;
    var routeRealTimeInfo =
        JsonConvert.fromJsonAsT<RouteRealTimeInfoEntity>(response.data);
    routeRealTimeInfo.toJson();
    // List<RouteRealTimeInfoEntity> routeStatDataEntityList = list
    //     .map((dynamic) =>
    //         JsonConvert.fromJsonAsT<RouteRealTimeInfoEntity>(dynamic))
    //     .toList();
    // print(routeStatDataEntityList.length);
    // print(routeStatDataEntityList[0].toJson());
  } catch (e) {
    print('请求出现问题::: $e');
  }
}

/// 获取时间戳
getTimeStamp() =>
    DateFormat("yyyyMMddHHmmss").format(DateTime.now()).toString();

/// 获取随机数
getRandom() => (100 + Random().nextInt(900)).toString();

/// 生成签名密钥
getSignKey(timeStamp, random) {
  // 59485eebe12042cba33e972f77834b6b 聊城
  // 55b73c446e914785862966abf9a29416 潍坊
  final appKey = "55b73c446e914785862966abf9a29416";
  var key = utf8.encode(appKey);
  var bytes = utf8.encode(timeStamp + random);

  // HMAC-SHA256
  var hmacSha256 = Hmac(sha256, key);
  var digest = hmacSha256.convert(bytes);

  // print("HMAC digest as bytes: ${digest.bytes}");
  // print("HMAC digest as hex string: $digest");

  return digest.toString();
}

/// 获取参数
getSignString() {
  var timeStamp = getTimeStamp();
  var random = getRandom();
  return "TimeStamp=" +
      timeStamp +
      "&Random=" +
      random +
      "&SignKey=" +
      getSignKey(timeStamp, random);
}
