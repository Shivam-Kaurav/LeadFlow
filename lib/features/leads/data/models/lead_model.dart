import 'package:leadflow/features/leads/domain/entities/lead_entity.dart';

class LeadModel extends Lead {
  LeadModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.status,
  });
  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      status: json['status'],
    );
  }
}
