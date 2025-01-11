part of 'banner_submission_cubit.dart';

abstract class BannerSubmissionState {}

class BannerSubmissionInitial extends BannerSubmissionState {}

class BannerSubmissionLoading extends BannerSubmissionState {}

class BannerSubmissionSuccess extends BannerSubmissionState {
  final String message;

  BannerSubmissionSuccess({required this.message});
}

class BannerSubmissionError extends BannerSubmissionState {
  final String message;

  BannerSubmissionError({required this.message});
}
