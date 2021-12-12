// Widget deliveryMethodCardOld(name,  methodValue)
// {
//   return GestureDetector(
//     onTap: ()=>{
//       setState(() {
//         selectedDelMethod = methodValue;
//       })
//     },
//     child: Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         side: BorderSide(color: Colors.white70, width: 1),
//         borderRadius: BorderRadius.circular(10),
//       ),
//
//       child: Container(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TextWidget(
//                 text: name.toString(),
//                 fontColor: Pallete.shopTitleText,
//                 fontFamily: Constant.QS_SEMIBOLD,
//                 fontSize: Constant.TEXT_FONT,
//               ),
//               CircularCheckBox(
//                   value: selectedDelMethod==methodValue?true:false,
//                   materialTapTargetSize: MaterialTapTargetSize.padded,
//                   checkColor: Colors.white,
//                   activeColor: Colors.blueAccent,
//                   onChanged: (bool x) {
//                     setState(() {
//                       selectedDelMethod = methodValue;
//                     });
//                     // someBooleanValue = !someBooleanValue;
//                   }
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
//
// Widget paymentMethodCardOld(name,  methodValue)
// {
//   return GestureDetector(
//     onTap: ()=>{
//       setState(() {
//         selectedPaymentMethod = methodValue;
//       })
//     },
//     child: Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         side: BorderSide(color: Colors.white70, width: 1),
//         borderRadius: BorderRadius.circular(10),
//       ),
//
//       child: Container(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TextWidget(
//                 text: name.toString(),
//                 fontColor: Pallete.shopTitleText,
//                 fontFamily: Constant.QS_SEMIBOLD,
//                 fontSize: Constant.TEXT_FONT,
//               ),
//               CircularCheckBox(
//                   value: selectedPaymentMethod==methodValue?true:false,
//                   materialTapTargetSize: MaterialTapTargetSize.padded,
//                   checkColor: Colors.white,
//                   activeColor: Colors.blueAccent,
//                   onChanged: (bool x) {
//                     setState(() {
//                       selectedPaymentMethod = methodValue;
//                     });
//                     // someBooleanValue = !someBooleanValue;
//                   }
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
