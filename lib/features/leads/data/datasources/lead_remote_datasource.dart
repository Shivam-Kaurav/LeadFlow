import 'package:leadflow/core/network/api_endpoints.dart';
import 'package:leadflow/core/network/dio_client.dart';
import 'package:leadflow/features/leads/data/models/lead_model.dart';

abstract class LeadRemoteDatasource {
  Future<List<LeadModel>> getLeads();
}

class LeadRemoteDatasourceImpl implements LeadRemoteDatasource {
  final DioClient client;
  LeadRemoteDatasourceImpl(this.client);
  @override
  Future<List<LeadModel>> getLeads() async {
    final response = await client.get(ApiEndpoints.leads);

    final List data = response.data;

    return data.map((e) => LeadModel.fromJson(e)).toList();
  }
}
