class Lead {
  final String id;
  final String name;
  final String phone;
  final String status;

  final String priority;
  final String assignedTo;
  final DateTime createdAt;

  const Lead({
    required this.id,
    required this.name,
    required this.phone,
    required this.status,
    required this.priority,
    required this.assignedTo,
    required this.createdAt,
  });
}
