import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_new_template/core/error/exceptions.dart';

import '../../export.dart';

const _baseUrl = 'https://test.kafiil.com/api/test/';

class Network {
  final Dio dio;
  final LocalDataSource box;
  Network({
    required this.dio,
    required this.box,
  });

  late Map<String, String?> headers;

  Future<Response> req(Future<Response> Function() requestType) async {
    headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Language':
          (await box.containsKey(kLanguage) ? await box.read(kLanguage) : 'ar'),
    };
    if (await box.containsKey(kToken)) {
      headers = {
        ...headers,
        'Authorization': '${box.read(kToken)}',
      };
    }
    try {
      final response = await requestType();
      if (response.statusCode! > 210 || response.statusCode! < 200) {
        Logger().i(response.data);
        final exception = ServerException(
            data: response.data, message: response.data.toString());
        Logger().i(exception.data);
        throw exception;
      }
      // success
      return response;
    } on DioException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  String _getParamsFromBody(dynamic body) {
    String params = '';
    for (var i = 0; i < body?.keys.length; i++) {
      params += '${List.from(body?.keys)[i]}=${List.from(body?.values)[i]}';
      if (i != body!.keys.length - 1) {
        params += '&';
      }
    }
    return params;
  }

  Future<Response> post(String endPoint, dynamic body,
      {bool isParamData = false, String? baseUrl}) async {
    return req(() {
      return dio.post(
          (baseUrl ?? _baseUrl) +
              endPoint +
              (isParamData ? _getParamsFromBody(body) : ''),
          data: isParamData ? {} : body,
          options: Options(headers: headers));
    });
  }

  Future<Response> patch(
    String endPoint,
    dynamic body,
  ) {
    return req(() {
      return dio.patch(_baseUrl + endPoint,
          data: body, options: Options(headers: headers));
    });
  }

  Future<Response> delete(
    String endPoint,
    dynamic body,
  ) {
    return req(() {
      return dio.delete(_baseUrl + endPoint,
          data: body, options: Options(headers: headers));
    });
  }

  Future<Response> get(String endPoint, dynamic body, {String? baseUrl}) {
    return req(() {
      return dio.get((baseUrl ?? _baseUrl) + endPoint,
          options: Options(headers: headers));
    });
  }

  Future<Response> uploadImage(
    String endPoint,
    Map<String, dynamic>? user,
    File file,
  ) async {
    FormData formData;
    String fileName = file.path.split('/').last;
    formData = FormData.fromMap({
      ...?user,
      'avatar': [await MultipartFile.fromFile(file.path, filename: fileName)],
    });
    Logger().i(formData.fields);
    return req(() {
      return dio.post(_baseUrl + endPoint,
          data: formData, options: Options(headers: headers));
    });
  }

  downloadFileFromUrl(String url, String savePath) async {
    await dio.download(url, savePath, onReceiveProgress: (received, total) {});
    print("File is saved to download folder.");
  }
}
