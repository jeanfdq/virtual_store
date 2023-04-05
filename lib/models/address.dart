// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address(
      {required this.cidade,
      required this.estado,
      required this.altitude,
      required this.longitude,
      required this.bairro,
      this.complemento,
      required this.cep,
      required this.logradouro,
      required this.latitude,
      this.numero});

  Cidade cidade;
  Estado estado;
  double altitude;
  String longitude;
  String bairro;
  String? complemento;
  String cep;
  String logradouro;
  String latitude;
  String? numero;

  factory Address.empty() => Address(
        cidade: Cidade.empty(),
        estado: Estado.empty(),
        altitude: 0,
        longitude: '',
        bairro: '',
        complemento: '',
        cep: '',
        logradouro: '',
        latitude: '',
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        cidade: Cidade.fromJson(json["cidade"]),
        estado: Estado.fromJson(json["estado"]),
        altitude: json["altitude"],
        longitude: json["longitude"],
        bairro: json["bairro"],
        complemento: json["complemento"],
        cep: json["cep"],
        logradouro: json["logradouro"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "cidade": cidade.toJson(),
        "estado": estado.toJson(),
        "altitude": altitude,
        "longitude": longitude,
        "bairro": bairro,
        "complemento": complemento,
        "cep": cep,
        "logradouro": logradouro,
        "latitude": latitude,
        "numero": numero ?? '0',
      };
}

class Cidade {
  Cidade({
    required this.ibge,
    required this.nome,
    required this.ddd,
  });

  String ibge;
  String nome;
  int ddd;

  factory Cidade.empty() => Cidade(
        ibge: '',
        nome: '',
        ddd: 0,
      );

  factory Cidade.fromJson(Map<String, dynamic> json) => Cidade(
        ibge: json["ibge"],
        nome: json["nome"],
        ddd: json["ddd"],
      );

  Map<String, dynamic> toJson() => {
        "ibge": ibge,
        "nome": nome,
        "ddd": ddd,
      };
}

class Estado {
  Estado({
    required this.sigla,
  });

  String sigla;

  factory Estado.empty() => Estado(sigla: '');

  factory Estado.fromJson(Map<String, dynamic> json) => Estado(
        sigla: json["sigla"],
      );

  Map<String, dynamic> toJson() => {
        "sigla": sigla,
      };
}
