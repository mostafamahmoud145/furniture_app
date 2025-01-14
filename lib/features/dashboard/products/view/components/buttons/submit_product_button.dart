import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/features/products/data/models/product_model.dart';
import 'package:furniture_app/features/dashboard/products/view_model/product_form_cubit/product_form_cubit.dart';
import 'package:furniture_app/features/dashboard/products/view_model/product_submission_cubit/product_submission_cubit.dart';

class SubmitProductButton extends StatelessWidget {
  const SubmitProductButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.product,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFormCubit, ProductFormState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate() &&
                (state.mainImage != null ||
                    state.existingImageUrls.isNotEmpty)) {
              BlocProvider.of<ProductSubmissionCubit>(context).submitProduct(
                id: product?.id ?? '',
                name: state.name,
                description: state.description,
                price: state.price,
                isBestSeller: state.isBestSeller,
                productCode: state.productCode,
                categoryId: state.categoryId!,
                mainImage: state.mainImage,
                optionalImages: state.optionalImages,
                existingImageUrls: state.existingImageUrls,
                imageColors: state.imageColors,
              );
            }
          },
          child: const Text('Submit'),
        );
      },
    );
  }
}
