import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/features/dashboard/categories/data/model/category_model.dart';
import 'package:furniture_app/features/dashboard/categories/view_model/category_form_cubit/category_form_cubit.dart';
import 'package:furniture_app/features/dashboard/categories/view_model/category_submission_cubit/category_submission_cubit.dart';

class SubmitCategoryButton extends StatelessWidget {
  const SubmitCategoryButton({
    super.key,
    required this.category,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final CategoryModel? category;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryFormCubit, CategoryFormState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate() &&
                (state.imageBytes != null ||
                    state.imageUrl.trim().isNotEmpty)) {
              BlocProvider.of<CategorySubmissionCubit>(context).submitCategory(
                id: category?.id ?? '',
                name: state.name,
                newImage: state.imageBytes,
                existingImageUrl: state.imageUrl,
              );
            }
          },
          child: const Text('Submit'),
        );
      },
    );
  }
}
