import 'package:flutter/services.dart';
import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final double? height;
  final String? topLabel;
  final bool? obscureText;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Key? kKey;
  final TextEditingController? kController;
  final String? kInitialValue;
  final TextInputFormatter? filteringTextInputFormatter;

  InputWidget({
    this.hintText,
    this.prefixIcon,
    this.height,
    this.topLabel = "",
    this.obscureText = false,
    required this.onSaved,
    this.keyboardType,
    this.errorText,
    this.onChanged,
    this.validator,
    this.kKey,
    this.kController,
    this.kInitialValue,
    this.filteringTextInputFormatter
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(this.topLabel!),
        SizedBox(height: 4.0),
        Container(
          height: this.height!= null? this.height: 50,
          decoration: BoxDecoration(
            // color: ligh,
            //color: Theme.of(context).buttonColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: TextFormField(
            initialValue: this.kInitialValue,
            controller: this.kController,
            key: this.kKey,
            keyboardType: this.keyboardType,
            onSaved: this.onSaved,
            onChanged: this.onChanged,
            validator: this.validator,
            obscureText: this.obscureText!,
            decoration: InputDecoration(
                prefixIcon: this.prefixIcon,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(74, 77, 84, 0.2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  //gapPadding: 16,
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).errorColor,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  //gapPaddings: 16,
                  borderSide: BorderSide(
                    color: Theme.of(context).errorColor,
                  ),
                ),
                hintText: this.hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w400),
                errorText: this.errorText),
            inputFormatters: <TextInputFormatter>[
              this.filteringTextInputFormatter != null ? this.filteringTextInputFormatter!: FilteringTextInputFormatter.singleLineFormatter,
            ],
          ),
        )
      ],
    );
  }
}
