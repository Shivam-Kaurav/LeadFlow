import 'package:leadflow/features/leads/domain/entities/lead_entity.dart';

class LeadModel extends Lead {
  const LeadModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.status,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      status: _generateStatus(json['id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'phone': phone, 'status': status};
  }

  // Fake CRM Status
  static String _generateStatus(dynamic id) {
    final statuses = ['Fresh', 'Pending', 'Meeting', 'Site Visit'];

    final index =
        (id is int ? id : int.tryParse(id.toString()) ?? 0) % statuses.length;

    return statuses[index];
  }
}
