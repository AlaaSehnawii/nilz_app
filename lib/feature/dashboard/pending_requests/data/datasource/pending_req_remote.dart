
import 'package:nilz_app/core/api/api_error/api_exception.dart';
import 'package:nilz_app/core/api/api_error/api_status_code.dart';
import 'package:nilz_app/core/api/api_links.dart';
import 'package:nilz_app/core/api/api_methods.dart';
import '../../domain/entity/response/pending_req_entity.dart';

abstract class PendingRequestRemote {
  Future<PendingRequestResponseEntity> pendingRequest();
}

class PendingRequestRemoteImpl extends PendingRequestRemote {
  @override
  Future<PendingRequestResponseEntity> pendingRequest() async {
    final response =
        await ApiMethods().get(url: ApiGetUrl.getPendingRequests);
    if (ApiStatusCode.success().contains(response.statusCode)) {

      return pendingRequestResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }
}
