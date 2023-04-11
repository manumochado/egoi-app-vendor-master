import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/dio/dio_client.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';

class OrderListRepo {
  final DioClient dioClient;
  OrderListRepo({@required this.dioClient});

  Future<ApiResponse> getOrderList() async {
    try {
      final response = await dioClient.get(AppConstants.ORDER_LIST_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderDetails(String orderID) async {
    try {
      final response =
          await dioClient.get(AppConstants.ORDER_DETAILS + orderID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> orderStatus(int orderID, String status) async {
    print(
        'update order status ====>${orderID.toString()} =======>${status.toString()}');
    try {
      Response response = await dioClient.post(
        '${AppConstants.UPDATE_ORDER_STATUS}$orderID',
        data: {'_method': 'put', 'order_status': status},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderStatusList(String type) async {
    try {
      List<String> addressTypeList = [];
      List<String> addressTypeListSpanish = [];
      if (type == 'admin') {
        addressTypeList = [
          'Selecciona el estado del pedido',
          AppConstants.PENDING == 'pending' ? 'Pendiente' : '',
          AppConstants.CONFIRMED == 'confirmed' ? 'Confirmado' : '',
          AppConstants.PROCESSING == 'processing' ? 'Procesando' : '',
        ];
        addressTypeListSpanish = [
          'Selecciona el estado del pedido',
          AppConstants.PENDING,
          AppConstants.CONFIRMED,
          AppConstants.PROCESSING
        ];
      } else {
        addressTypeList = [
          'Selecciona el estado del pedido',
          AppConstants.PENDING == 'pending' ? 'Pendiente' : '',
          AppConstants.CONFIRMED == 'confirmed' ? 'Confirmado' : '',
          AppConstants.PROCESSING == 'processing' ? 'Procesando' : '',
          AppConstants.OUT_FOR_DELIVERY == 'out_for_delivery'
              ? 'En camino'
              : '',
          AppConstants.DELIVERED == 'delivered' ? 'Entregado' : '',
          AppConstants.RETURNED == 'returned' ? 'Devuelto' : '',
          AppConstants.FAILED == 'failed' ? 'Fallido' : '',
          AppConstants.CANCELLED == 'canceled' ? 'Cancelado' : '',
        ];

        addressTypeListSpanish = [
          'Selecciona el estado del pedido',
          AppConstants.PENDING,
          AppConstants.CONFIRMED,
          AppConstants.PROCESSING,
          AppConstants.OUT_FOR_DELIVERY,
          AppConstants.DELIVERED,
          AppConstants.RETURNED,
          AppConstants.FAILED,
          AppConstants.CANCELLED,
        ];
      }

      Response response = Response(
          requestOptions: RequestOptions(path: ''),
          data: addressTypeList,
          statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
