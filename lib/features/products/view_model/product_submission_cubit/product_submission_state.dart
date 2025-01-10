part of 'product_submission_cubit.dart';


@immutable
abstract class ProductSubmissionState {}

class ProductSubmissionInitial extends ProductSubmissionState {}

class ProductSubmissionLoading extends ProductSubmissionState {}

class ProductSubmissionSuccess extends ProductSubmissionState {
  final String message;

  ProductSubmissionSuccess({required this.message});
}

class ProductSubmissionError extends ProductSubmissionState {
  final String message;

  ProductSubmissionError({required this.message});
}
