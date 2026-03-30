import 'package:leadflow/features/leads/data/datasources/lead_remote_datasource.dart';
import 'package:leadflow/features/leads/domain/entities/lead_entity.dart';
import 'package:leadflow/features/leads/domain/repositories/lead_repository.dart';

class LeadRepositoryImpl implements LeadRepository {
  final LeadRemoteDatasource remoteDataSource;
  LeadRepositoryImpl(this.remoteDataSource);
  @override
  Future<List<Lead>> getLeads() async {
    return await remoteDataSource.getLeads();
  }
}
