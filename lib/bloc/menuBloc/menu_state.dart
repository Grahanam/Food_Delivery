part of 'menu_bloc.dart';

@immutable
abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object?> get props => [];
}

final class MenuInitial extends MenuState {}

final class MenuLoading extends MenuState {}

final class MenuSuccess extends MenuState {
  final List data;

  const MenuSuccess({required this.data});
}

final class MenuFailure extends MenuState {
  final String error;
  const MenuFailure(this.error);
}
