// import 'package:arkam/core/api/api_service.dart';
//
// import '../../../../core/api/end_points.dart';
// import '../../../../core/errors/failures.dart';
// import 'package:arkam/core/utils/app_assets.dart';
// import 'package:dartz/dartz.dart';
//
// import '../../domain/entities/get_map_params.dart';
// import '../models/booking_model.dart';
// import '../models/response_real_esate_map.dart';
//
// class RealEstateRemoteDataSource {
//   ApiService apiService;
//   RealEstateRemoteDataSource({required this.apiService});
//
//   Future<PagedEstateMapResult> getRealEstateMap({required GetMapsParams params}) async {
//     final response = await apiService.post(endPoint: EndPoints.getMaps, data: params.toJson());
//     return PagedEstateMapResult.fromJson(response);
//   }
// }
