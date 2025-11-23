


import 'dart:convert';

import 'package:nilz_app/core/api/api_error/api_exception.dart';
import 'package:nilz_app/core/api/api_error/api_status_code.dart';
import 'package:nilz_app/core/api/api_links.dart';
import 'package:nilz_app/core/api/api_methods.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/domain/entity/response/res_statistics_entity.dart';

abstract class ResStatisticsRemote {
  Future<ResStatisticsResponseEntity> resStatistics();
}

class ResStatisticsRemoteImpl extends ResStatisticsRemote {
  @override
  Future<ResStatisticsResponseEntity> resStatistics() async {
    final response =
        await ApiMethods().get(url: ApiGetUrl.getResStatistics);
    print("sosooooooooooooolllllllllResStatistics");
    print(response.statusCode);
    print(response.body);
    if (ApiStatusCode.success().contains(response.statusCode)) {
      final decoded = json.decode(response.body);
      final apiResponse = ResStatisticsApiResponseEntity.fromJson(decoded);

      return apiResponse.data ?? ResStatisticsResponseEntity();
    } else {
      throw ApiServerException(response: response);
    }
  }
}
