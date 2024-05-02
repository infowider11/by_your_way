import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../constants/my_colors.dart';
import '../functions/print_function.dart';
import 'custom_text.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final String? text;
  final bool isLabel;
  final Color labelColor;
  final List<T> items;
   T? selectedItem;
  final String hint;
  final BoxBorder? border;
  final void Function(T? value)? onChanged;
  final double margin;
  final double labelFontSize;
  final String itemMapKey;
  final Color fieldColor;
  final double borderRadius;
  final CrossAxisAlignment crossAxisAlignment;
  final String? Function(T?)? validator;
   CustomDropdownButton({Key? key,
    this.margin = 0,
    this.labelFontSize = 15,
    this.validator,
     this.text,
    this.selectedItem,
    this.labelColor =Colors.black,
    required this.items,
    required this.hint,
    this.onChanged,
    this.border,
     this.borderRadius = 30,
    this.isLabel = true,
    this.itemMapKey = 'name',
    this.fieldColor=Colors.transparent,
    this.crossAxisAlignment = CrossAxisAlignment.start

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [


        if(text!=null)
        Text(text!, style: TextStyle(fontSize: labelFontSize, color: labelColor, fontFamily: 'bold'),),
        Container(
          height: 60,
          margin: EdgeInsets.symmetric(vertical: margin),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius)
          ),
          // decoration: BoxDecoration(
          //     // color: Color(0xFEF0F0F0),
          //     color: Colors.transparent,
          //     // border: Border.all(color: Color(0xFEF0F0F0)),
          //     border: Border.all(color: MyColors.bordercolor),
          //     borderRadius: BorderRadius.circular(borderRadius)),
          // padding: EdgeInsets.only(left: 16, top: 0),
          child:  DropdownSearch<T>(
            validator: validator,

            // popupBackgroundColor: Colors.transparent,
            // popupElevation: 0,
            // // dro
            // dropdownSearchDecoration: InputDecoration.collapsed(
            //
            //     hintText: '  $hint',
            //     hintStyle: TextStyle(color: Color(0xFF999999), fontFamily: 'light')
            // ),
            // mode: Mode.MENU,

            popupProps: PopupProps.modalBottomSheet(
              fit: FlexFit.loose,
              showSelectedItems: false,
              title: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SubHeadingText('$hint',),
              ),
              // title: Container(
              //   color: Colors.transparent,
              //   height: 100,
              // ),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                // labelText: "Menu mode",
                // hintText: "$hint",
                labelText: hint,
                // alignLabelWithHint: true,

                floatingLabelBehavior: FloatingLabelBehavior.auto,
                // labelText: "$hint",
                hintStyle: TextStyle(color: Color(0xFF999999), fontFamily: 'light'),
                // border: InputBorder.none,
                border:OutlineInputBorder(
                  // borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide(color: MyColors.blackColor50,width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  // borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide(color: MyColors.blackColor50),
                ),
                focusedBorder: OutlineInputBorder(
                  // borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide(color: MyColors.primaryColor,width: 1.5),
                ),
                errorBorder: OutlineInputBorder(
                  // borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide(color: MyColors.redColor,width: 1.5),
                ),
              )

            ),

            dropdownButtonProps: DropdownButtonProps(

            ),
            items: items,

            // popupTitle: Container(
            //   color: Colors.transparent,
            //   height: 100,
            // ),


            // popupItemBuilderr: ,
            dropdownBuilder:
            // selectedItem==null?null:
                (context,value){
              // myCustomPrintStatement('the value is ${value.toString()}');
              // myCustomPrintStatement('the a is $a');
              if(value==null){
                return Container(
                  child: ParagraphText('$hint'),
                );
              }
              try{
                return Text('${(value as Map)['${itemMapKey}']}');

              }catch(e){
                myCustomPrintStatement('Error in catch block  5d55 $e');
              }
              return Container(
                decoration: BoxDecoration(
                    // color:Colors.white,
                    // border: Border(bottom: BorderSide(color: Colors.black12))
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(value.toString()+'sdfas'),
                    // Divider(),
                  ],
                ),
              );


            },
            itemAsString: (T? value){
              myCustomPrintStatement('this is called');
              try{
                return ' ${(value as Map)['${itemMapKey}']}';
              }catch(e){
                myCustomPrintStatement('Error in catch block  555 $e');
              }
              return '  ${value}';
              // return '  ${value.toString()}';
            },
            selectedItem: selectedItem,



            onChanged: onChanged,
            // onChanged: (val){
            //   selectedItem = val;
            //   if(onChanged!=null){
            //     onChanged!(val);
            //   }
            // },
          ),
        ),
      ],
    );
  }
}


// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import '../constants/colors.dart';
//

// class CustomDropdownButton extends StatelessWidget {
//   final String text;
//   final Color labelColor;
//   final List items;
//   final String hint;
//   final BoxBorder? border;
//   final Function(dynamic value)? onChanged;
//   final double margin;
//   final double labelFontSize;
//   final dynamic selectedItem;
//
//   const CustomDropdownButton({Key? key,
//     this.margin = 16,
//     this.labelFontSize = 18,
//     required this.text,
//     this.labelColor = MyColors.secondaryColor,
//     required this.items,
//     required this.hint,
//     this.onChanged,
//     this.border,
//     this.selectedItem,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(text, style: TextStyle(fontSize: labelFontSize, color: labelColor, fontFamily: 'bold'),),
//         Container(
//           height: 60,
//           margin: EdgeInsets.symmetric(vertical: margin),
//           decoration: BoxDecoration(
//               color: Color(0xFEF0F0F0),
//               border: Border.all(color: Color(0xFEF0F0F0)),
//               borderRadius: BorderRadius.circular(borderRadius)),
//           padding: EdgeInsets.only(left: 10, top: 5),
//           child: DropdownSearch(
//             selectedItem: selectedItem,
//             dropdownSearchDecoration: InputDecoration.collapsed(
//                 hintText: hint,
//                 hintStyle: TextStyle(color: Color(0xFEA1A1A1), fontFamily: 'light')
//             ),
//             mode: Mode.MENU,
//             items: items,
//             onChanged: onChanged,
//           ),
//         ),
//       ],
//     );
//   }
// }
