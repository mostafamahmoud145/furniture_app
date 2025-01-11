import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/features/dashboard/products/view_model/product_form_cubit/product_form_cubit.dart';

class OptionalImagesWidget extends StatelessWidget {
  const OptionalImagesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFormCubit, ProductFormState>(
      builder: (context, state) {
        return Column(
          children: [
            /// <--- Optional Images Label --->
            const Text(
              'Optional Images:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            /// <--- Vertical spacing --->
            const SizedBox(height: 10),

            /// <--- Optional Images --->
            Wrap(
              spacing: 10,
              children: List.generate(3, (index) {
                final imageUrl = index + 1 < state.existingImageUrls.length
                    ? state.existingImageUrls[index + 1]
                    : null;

                final optionalImage = state.optionalImages[index];

                return GestureDetector(
                  onTap: () => context
                      .read<ProductFormCubit>()
                      .pickImage(isMain: false, index: index),
                  child: optionalImage != null
                      ? Image.memory(optionalImage,
                          width: 100, height: 100, fit: BoxFit.cover)
                      : imageUrl != null
                          ? FadeInImage.assetNetwork(
                              placeholder: 'assets/icons/load.gif',
                              image: imageUrl,
                              height: 100,
                              width: 100,
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: const Icon(Icons.add_a_photo, size: 30),
                            ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
