part of 'get_banners_cubit.dart';

@immutable
sealed class GetBannersState {}

final class GetBannersInitial extends GetBannersState {}

final class GetBannersLoading extends GetBannersState {}

final class GetBannersSuccess extends GetBannersState {
  final List<BannerModel> banners;
  GetBannersSuccess({required this.banners});
}

final class GetBannersError extends GetBannersState {}
