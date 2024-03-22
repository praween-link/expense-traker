import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expense_tracker/core/color/app_colors.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonWidgets {
  CommonWidgets._();

  static Widget input(
          {String? hint,
          required TextEditingController input,
          TextInputType? keyboardType,
          TextCapitalization? textCapitalization}) =>
      TextField(
        textCapitalization: textCapitalization ?? TextCapitalization.words,
        controller: input,
        keyboardType: keyboardType ?? TextInputType.text,
        style: TextStyles.normalText(),
        decoration: InputDecoration(
          hintText: hint ?? '',
        ),
      );
  //Button
  static Widget button({required String title, required Function onClick}) =>
      GestureDetector(
        onTap: () => onClick(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.5),
                  blurRadius: 12,
                )
              ]),
          child: Text(
            title,
            style: TextStyles.buttonText(),
          ),
        ),
      );
  //
  static Widget dropdown(
          {required List<String> items,
          required String value,
          required Function(String?) onChanged}) =>
      DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          onChanged: onChanged,
          value: value,
          items: items.map((items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                items,
                style: TextStyles.normalText(),
              ),
            );
          }).toList(),
          buttonStyleData: ButtonStyleData(
            height: 44,
            width: Get.width,
            //elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
            ),
            iconSize: 20,
            iconEnabledColor: AppColors.black,
            iconDisabledColor: AppColors.black,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.white),
            offset: const Offset(-2, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(20),
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
        ),
      );
}
