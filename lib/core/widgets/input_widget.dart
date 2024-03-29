import 'package:flutter/services.dart';
import 'package:docxform/core/constants/color_constants.dart';
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
  final int? multiLines;
  final String? kInitialValue;
  final List<TextInputFormatter>? kinputFormatters;

  InputWidget({
    this.hintText,
    this.prefixIcon,
    this.height = 48.0,
    this.topLabel = "",
    this.obscureText = false,
    required this.onSaved,
    this.keyboardType,
    this.errorText,
    this.onChanged,
    this.validator,
    this.kKey,
    this.multiLines,
    this.kController,
    this.kInitialValue,
    this.kinputFormatters,
  });
  @override
  Widget build(BuildContext context) {
    // if(this.multiLines==1){
    //   this.multiLines==null;
    // }else{
    //   this.multiLines = 1;
    // }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(this.topLabel!),
        SizedBox(height: 4.0),
        TextFormField(
          inputFormatters: this.kinputFormatters,
          initialValue: this.kInitialValue,
          controller: this.kController,
          maxLines: this.obscureText==true ?1:this.multiLines,
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
              errorStyle: TextStyle(height: 0, color: Colors.transparent),
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
                  .copyWith(color: Colors.white54),
              errorText: this.errorText),
        )
      ],
    );
  }
}
