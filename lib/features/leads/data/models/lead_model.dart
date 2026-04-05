import 'package:leadflow/features/leads/domain/entities/lead_entity.dart';

class LeadModel extends Lead {
  const LeadModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.status,
    required super.priority,
    required super.assignedTo,
    required super.createdAt,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      status: _generateStatus(json['id']),
      priority: _generatePriority(json['id']),
      assignedTo: _generateUser(json['id']),
      createdAt: _generateDate(json['id']),
    );
  }

  static String _generateStatus(dynamic id) {
    final list = ['Fresh', 'Pending', 'Meeting', 'Site Visit'];
    return list[(id as int) % list.length];
  }

  static String _generatePriority(dynamic id) {
    final list = ['High', 'Medium', 'Low'];
    return list[(id as int) % list.length];
  }

  static String _generateUser(dynamic id) {
    final list = ['Shivam', 'Rahul', 'Amit', 'Neha'];
    return list[(id as int) % list.length];
  }

  static DateTime _generateDate(dynamic id) {
    return DateTime.now().subtract(Duration(days: id % 30));
  }
}
