import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leadflow/features/leads/domain/entities/lead_entity.dart';
import 'package:leadflow/features/leads/domain/usecases/get_leads.dart';

part 'leads_event.dart';
part 'leads_state.dart';

class LeadsBloc extends Bloc<LeadsEvent, LeadsState> {
  final GetLeads getLeads;
  LeadsBloc(this.getLeads) : super(LeadsInitial()) {
    on<LoadLeadsEvent>(_onLoadLeads);
    on<LoadMoreLeadsEvent>(_onLoadMore);
    on<RefreshLeadsEvent>(_onRefresh);
    on<FilterLeadsEvent>(_onFilterLeads);
    on<SearchLeadsEvent>(_onSearchLeads);
  }
  List<Lead> allLeads = [];
  List<Lead> filteredLeads = [];

  int currentPage = 1;
  final int pageSize = 5;

  String selectedFilter = 'All';
  String searchQuery = '';

  Future<void> _onLoadLeads(
    LoadLeadsEvent event,
    Emitter<LeadsState> emit,
  ) async {
    emit(LeadsLoading());

    try {
      allLeads = await getLeads();
      _applyFilters();

      final paginated = filteredLeads.take(pageSize).toList();
      emit(
        LeadsLoaded(
          leads: paginated,
          hasMore: filteredLeads.length > pageSize,
          isLoadingMore: false,
          selectedFilter: 'All',
        ),
      );
    } catch (e) {
      emit(LeadsError('Failed to load leads'));
    }
  }

  void _onLoadMore(LoadMoreLeadsEvent event, Emitter<LeadsState> emit) {
    final currentState = state;

    if (currentState is LeadsLoaded) {
      if (!currentState.hasMore || currentState.isLoadingMore) return;
      emit(currentState.copyWith(isLoadingMore: true));
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

  void _onFilterLeads(FilterLeadsEvent event, Emitter<LeadsState> emit) {
    selectedFilter = event.status;
    currentPage = 1;

    _applyFilters();

    final paginated = filteredLeads.take(pageSize).toList();

    emit(
      LeadsLoaded(
        leads: paginated,
        hasMore: filteredLeads.length > pageSize,
        isLoadingMore: false,
        selectedFilter: selectedFilter,
      ),
    );
  }

  Future<void> _onRefresh(
    RefreshLeadsEvent event,
    Emitter<LeadsState> emit,
  ) async {
    currentPage = 1;
    add(LoadLeadsEvent());
  }

  void _onSearchLeads(SearchLeadsEvent event, Emitter<LeadsState> emit) {
    searchQuery = event.query;
    currentPage = 1;

    _applyFilters();

    final paginated = filteredLeads.take(pageSize).toList();

    emit(
      LeadsLoaded(
        leads: paginated,
        hasMore: filteredLeads.length > pageSize,
        isLoadingMore: false,
        selectedFilter: selectedFilter,
      ),
    );
  }

  void _applyFilters() {
    filteredLeads = allLeads.where((lead) {
      final matchesFilter =
          selectedFilter == 'All' || lead.status == selectedFilter;

      final matchesSearch = lead.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );

      return matchesFilter && matchesSearch;
    }).toList();
  }
}
