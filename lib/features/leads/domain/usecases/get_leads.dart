import 'package:leadflow/features/leads/domain/entities/lead_entity.dart';
import 'package:leadflow/features/leads/domain/repositories/lead_repository.dart';

class GetLeads {
  final LeadRepository repository;
  GetLeads({required this.repository});

  Future<List<Lead>> call(String status) {
    return repository.getLeads(status);
  }
}
