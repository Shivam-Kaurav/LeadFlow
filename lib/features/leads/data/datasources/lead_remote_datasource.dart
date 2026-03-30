import 'package:leadflow/features/leads/data/models/lead_model.dart';

abstract class LeadRemoteDatasource {
  Future<List<LeadModel>> getLeads();
}

class LeadRemoteDatasourceImpl implements LeadRemoteDatasource {
  @override
  Future<List<LeadModel>> getLeads() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      LeadModel(id: '1', name: 'Shivam', phone: '9999999999', status: 'Fresh'),
      LeadModel(id: '2', name: 'Rahul', phone: '8888888888', status: 'Pending'),
      LeadModel(id: '3', name: 'Amit', phone: '7777777777', status: 'Meeting'),
    ];
  }
}
