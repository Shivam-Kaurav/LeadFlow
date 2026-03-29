import 'package:leadflow/features/leads/domain/entities/lead_entity.dart';

abstract class LeadRepository {
  Future<List<Lead>> getLeads(String status);
}
