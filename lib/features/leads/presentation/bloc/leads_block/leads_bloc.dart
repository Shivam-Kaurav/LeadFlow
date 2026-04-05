import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leadflow/features/leads/domain/entities/lead_entity.dart';
import 'package:leadflow/features/leads/domain/entities/lead_filter.dart';
import 'package:leadflow/features/leads/domain/usecases/get_leads.dart';
import 'package:leadflow/features/leads/presentation/bloc/transformers/debounce.dart';

part 'leads_event.dart';
part 'leads_state.dart';

class LeadsBloc extends Bloc<LeadsEvent, LeadsState> {
  final GetLeads getLeads;

  LeadsBloc(this.getLeads) : super(LeadsInitial()) {
    on<LoadLeadsEvent>(_onLoadLeads);
    on<LoadMoreLeadsEvent>(_onLoadMore);
    on<RefreshLeadsEvent>(_onRefresh);
    on<FilterLeadsEvent>(_onFilterLeads);
    on<ApplyAdvancedFilterEvent>(_onApplyAdvancedFilter);
    on<SearchLeadsEvent>(
      _onSearchLeads,
      transformer: debounce(Duration(milliseconds: 500)),
    );
  }

  List<Lead> allLeads = [];
  LeadFilter currentFilter = const LeadFilter();
  List<Lead> filteredLeads = [];

  int currentPage = 1;
  final int pageSize = 5;

  String selectedFilter = 'All';
  String searchQuery = '';

  ///  LOAD LEADS
  Future<void> _onLoadLeads(
    LoadLeadsEvent event,
    Emitter<LeadsState> emit,
  ) async {
    emit(LeadsLoading());

    try {
      allLeads = await getLeads();

      ///  SIMULATE LARGE DATASET (IMPORTANT FOR PAGINATION)
      allLeads = List.generate(
        10,
        (index) => allLeads,
      ).expand((e) => e).toList();

      _applyFilters();

      final paginated = filteredLeads.take(pageSize).toList();

      emit(
        LeadsLoaded(
          leads: paginated,
          hasMore: paginated.length < filteredLeads.length,
          isLoadingMore: false,
          selectedFilter: selectedFilter,
        ),
      );
    } catch (e) {
      emit(LeadsError('Failed to load leads'));
    }
  }

  ///  LOAD MORE
  void _onLoadMore(LoadMoreLeadsEvent event, Emitter<LeadsState> emit) async {
    final currentState = state;

    if (currentState is LeadsLoaded) {
      if (!currentState.hasMore || currentState.isLoadingMore) return;

      emit(currentState.copyWith(isLoadingMore: true));
      await Future.delayed(const Duration(milliseconds: 800));

      currentPage++;

      final nextItems = filteredLeads.take(currentPage * pageSize).toList();

      emit(
        currentState.copyWith(
          leads: nextItems,
          hasMore: nextItems.length < filteredLeads.length,
          isLoadingMore: false,
        ),
      );
    }
  }

  ///  REFRESH
  Future<void> _onRefresh(
    RefreshLeadsEvent event,
    Emitter<LeadsState> emit,
  ) async {
    currentPage = 1;
    add(LoadLeadsEvent());
  }

  ///  FILTER
  void _onFilterLeads(FilterLeadsEvent event, Emitter<LeadsState> emit) {
    selectedFilter = event.status;
    currentPage = 1;

    _applyFilters();

    final paginated = filteredLeads.take(pageSize).toList();

    emit(
      LeadsLoaded(
        leads: paginated,
        hasMore: paginated.length < filteredLeads.length,
        isLoadingMore: false,
        selectedFilter: selectedFilter,
      ),
    );
  }

  /// 🔥 SEARCH
  Future<void> _onSearchLeads(
    SearchLeadsEvent event,
    Emitter<LeadsState> emit,
  ) async {
    if (event.query == searchQuery) return;
    searchQuery = event.query;
    currentPage = 1;
    await Future.delayed(const Duration(milliseconds: 300));

    _applyFilters();

    final paginated = filteredLeads.take(pageSize).toList();

    emit(
      LeadsLoaded(
        leads: paginated,
        hasMore: paginated.length < filteredLeads.length,
        isLoadingMore: false,
        selectedFilter: selectedFilter,
      ),
    );
  }

  void _onApplyAdvancedFilter(
    ApplyAdvancedFilterEvent event,
    Emitter<LeadsState> emit,
  ) {
    currentFilter = event.filter;
    currentPage = 1;

    _applyFilters();

    final paginated = filteredLeads.take(pageSize).toList();

    emit(
      LeadsLoaded(
        leads: paginated,
        hasMore: paginated.length < filteredLeads.length,
        isLoadingMore: false,
        selectedFilter: selectedFilter,
      ),
    );
  }

  /// 🔥 CORE FILTER LOGIC
  void _applyFilters() {
    filteredLeads = allLeads.where((lead) {
      final matchesSearch = lead.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );

      final matchesStatus =
          currentFilter.statuses.isEmpty ||
          currentFilter.statuses.contains(lead.status);

      final matchesPriority =
          currentFilter.priority == null ||
          lead.priority == currentFilter.priority;

      final matchesAssigned =
          currentFilter.assignedUser == null ||
          lead.assignedTo == currentFilter.assignedUser;

      final matchesDate =
          (currentFilter.startDate == null ||
              !lead.createdAt.isBefore(currentFilter.startDate!)) &&
          (currentFilter.endDate == null ||
              !lead.createdAt.isAfter(currentFilter.endDate!));

      return matchesSearch &&
          matchesStatus &&
          matchesPriority &&
          matchesAssigned &&
          matchesDate;
    }).toList();
  }
}
