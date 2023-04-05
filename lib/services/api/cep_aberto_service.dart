import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/models/address.dart';
import 'package:virtual_store/utils/constants.dart';

class CepAbertoService {
  Future<Address> getAddressFromCep(String cep) async {
    final unMaskedCep = cep.replaceAll('.', '').replaceAll('-', '').trim();
    final endPoint = 'https://www.cepaberto.com/api/v3/cep?cep=$unMaskedCep';

    final http = Dio();

    http.options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    http.options.headers[HttpHeaders.authorizationHeader] =
        'Token token=$kTokenCepAPI';

    try {
      final response = await http.get<Map<String, dynamic>>(endPoint);

      if (response.data == null) {
        return Future.error('Erro ao buscar o cep');
      } else {
        if (response.data!.isEmpty) {
          return Future.error('Cep não encontado!');
        } else {
          final data = response.data!;

          return Address.fromJson(data);
        }
      }
    } on DioError catch (e) {
      debugPrint(e.toString());
      return Future.error('Erro ao buscar o cep');
    }
  }
}
