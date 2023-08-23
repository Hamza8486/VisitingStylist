import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stylish_app/util/theme.dart';



class SortedByDropDown extends StatelessWidget {
  final String hint;
  final String? value;
  final double fontSize;
  final double fontSize1;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final String fontFamily;
  final String fontFamily1;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset? offset;
  final Color hintColor;

  SortedByDropDown({
    required this.hint,
    required this.value,
    this.fontFamily  ="regular",
    this.fontFamily1  ="medium",
    required this.dropdownItems,
    required this.onChanged,
    required this.hintColor ,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.fontSize  = 13,
    this.fontSize1  = 12,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size med = MediaQuery.of(context).size;
    return DropdownButtonHideUnderline(

      child: DropdownButton2(

        isExpanded: true,
        hint: Container(
          alignment: hintAlignment,
          child: Text(
              hint,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  color: hintColor,
                  overflow: TextOverflow.ellipsis,
                  fontFamily: fontFamily,
                  fontSize: fontSize1
              )

          ),
        ),
        value: value,
        items: dropdownItems
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Container(

            alignment: valueAlignment,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                  item,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(

                    fontSize: fontSize,
                    color: AppColor.blackColor,
                    fontFamily: fontFamily1,
                  )
              ),
            ),
          ),
        ))
            .toList(),
        onChanged: onChanged,
        selectedItemBuilder: selectedItemBuilder,
        icon:  SvgPicture.asset("assets/icons/downs.svg",height: Get.height*0.01,color: AppColor.borderColorField,),
        iconSize: iconSize ?? 15,
        iconEnabledColor: iconEnabledColor,
        iconDisabledColor: iconDisabledColor,
        buttonHeight: buttonHeight ?? 40,
        buttonWidth: buttonWidth ?? 140,
        buttonPadding:
        buttonPadding ?? const EdgeInsets.only(left: 6, right: 6),
        buttonDecoration: buttonDecoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,



            ),
        buttonElevation: buttonElevation,
        itemHeight: itemHeight ?? 40,
        itemPadding: itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
        //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
        dropdownMaxHeight: dropdownHeight ??  Get.height * 0.55,
        dropdownWidth: dropdownWidth ?? med.width * 0.3,
        dropdownPadding: dropdownPadding,
        dropdownDecoration: dropdownDecoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
        dropdownElevation: dropdownElevation ?? 8,
        scrollbarRadius: scrollbarRadius ?? const Radius.circular(40),
        scrollbarThickness: scrollbarThickness,
        scrollbarAlwaysShow: scrollbarAlwaysShow,
        //Null or Offset(0, 0) will open just under the button. You can edit as you want.
        offset: offset,
        dropdownOverButton: false, //Default is false to show menu below button
      ),
    );
  }
}




Widget dropDownButtons(
    {value, onChanged, items, hinText, contentPadding,validator}) {
  return ButtonTheme(
    alignedDropdown: true,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: DropdownButtonFormField(
        menuMaxHeight: Get.height * 0.3,
        style: TextStyle(fontFamily: AppFont.regular, fontSize:  AppSizes.size_14,fontWeight: FontWeight.w500,
        color: AppColor.boldBlackColor
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          color: AppColor.greyColor,
          size: Get.height * 0.023,
        ),
        validator: validator,


        decoration: InputDecoration(
          border: InputBorder.none,



          contentPadding: contentPadding,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: AppColor.borderColorField),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: AppColor.borderColorField),
          ),
        ),
        value: value,
        hint: SizedBox(
          width: Get.width*0.5,
          child: Text(
            hinText,
            maxLines: 1,
            style: TextStyle(
                color:AppColor.greyColors,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                fontFamily: AppFont.regular,
                fontSize: AppSizes.size_13),
          ),
        ),
        isExpanded: true,
        isDense: true,
        onChanged: onChanged,
        items: items),
  );
}