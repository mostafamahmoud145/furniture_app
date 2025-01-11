import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/features/dashboard/products/view_model/product_form_cubit/product_form_cubit.dart';

class MainProductImage extends StatelessWidget {
  const MainProductImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFormCubit, ProductFormState>(
      builder: (context, state) {
        return Column(
          children: [
            /// <--- Main Image Label --->
            const Text(
              'Main Image (Required):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            /// <--- Vertical spacing --->
            const SizedBox(height: 10),

            /// <--- Main Image --->
            GestureDetector(
              onTap: () =>
                  context.read<ProductFormCubit>().pickImage(isMain: true),
              child: state.mainImage != null
                  ? Image.memory(state.mainImage!,
                      width: 150, height: 150, fit: BoxFit.cover)
                  : state.existingImageUrls.isNotEmpty
                      ? FadeInImage.assetNetwork(
                          placeholder: 'assets/icons/load.gif',
                          image: state.existingImageUrls[0],
                          height: 150,
                          width: 150,
                        )
                      : Container(
                          width: 150,
                          height: 150,
                          color: Colors.grey[300],
                          child: const Icon(Icons.add_a_photo, size: 50),
                        ),
            ),
          ],
        );
      },
    );
  }
}
