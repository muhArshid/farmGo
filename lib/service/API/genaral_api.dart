
// import 'package:get/get.dart';

// class GeneralAPI {
//   static Future<InitialData?> getInitialData(dynamic request) async {
//     try {
//       InitialData? initialDataResponse;
//       HttpRequestHandler requestHandler = HttpRequestHandler();

//       var isSuccess = await requestHandler.sendTokenServerRequest(
//           HttpConstants.initialData, request);
//       var resBody = requestHandler.responsebody;

//       if (isSuccess) {
//         initialDataResponse = InitialData.fromJson(resBody);
//       }
//       return initialDataResponse;
//     } catch (e) {
//       throw e;
//     }
//   }

  
// }
