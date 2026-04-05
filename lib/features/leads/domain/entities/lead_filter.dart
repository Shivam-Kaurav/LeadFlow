class LeadFilter {
  final List<String> statuses;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? assignedUser;
  final String? priority;

  const LeadFilter({
    this.statuses = const [],
    this.startDate,
    this.endDate,
    this.assignedUser,
    this.priority,
  });

  LeadFilter copyWith({
    List<String>? statuses,
    DateTime? startDate,
    DateTime? endDate,
    String? assignedUser,
    String? priority,
  }) {
    return LeadFilter(
      statuses: statuses ?? this.statuses,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      assignedUser: assignedUser ?? this.assignedUser,
      priority: priority ?? this.priority,
    );
  }
}
