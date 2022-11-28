part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitial;
  final bool followUser;

  const MapState({this.isMapInitial = false, this.followUser = false});

  @override
  List<Object> get props => [isMapInitial, followUser];

  MapState copyWith({bool? imi, bool? fu}) => MapState(
        isMapInitial: imi ?? isMapInitial,
        followUser: fu ?? followUser,
      );
}
