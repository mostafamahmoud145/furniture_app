part of 'category_submission_cubit.dart';

abstract class CategorySubmissionState {}

class CategorySubmissionInitial extends CategorySubmissionState {}

class CategorySubmissionLoading extends CategorySubmissionState {}

class CategorySubmissionSuccess extends CategorySubmissionState {
  final String message;

  CategorySubmissionSuccess({required this.message});
}

class CategorySubmissionError extends CategorySubmissionState {
  final String message;

  CategorySubmissionError({required this.message});
}
