part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool displayManualMarker;
  final List<Feature> places;
  final List<Feature> history;

  const SearchState(
      {this.displayManualMarker = false,
      this.places = const [],
      this.history = const []});

  SearchState copyWith({bool? dmm, List<Feature>? p, List<Feature>? h}) {
    return SearchState(
        displayManualMarker: dmm ?? displayManualMarker,
        places: p ?? places,
        history: h ?? history);
  }

  @override
  List<Object> get props => [displayManualMarker, places, history];
}
