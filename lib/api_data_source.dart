import 'package:http/src/response.dart';

import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadList(String endpoint){
    return BaseNetwork.get("$endpoint?format=json");
  }

  Future<Map<String, dynamic>> loadDetailUser(int idDiterima){
    String id = idDiterima.toString();
    return BaseNetwork.get("users/$id");
  }
}