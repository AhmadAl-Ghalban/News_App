import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/modules/webView/web_view.dart';

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: NetworkImage('${article?['urlToImage']}'),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      '${article['title']}',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
                    Text(
                      '${article['publishedAt']}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
Widget myDivder() => Padding(
      padding: EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivder(),
        itemCount: 10),
    fallback: (context) =>
        isSearch ? Container() : Center(child: CircularProgressIndicator()));
void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

Widget defultTextField({
  required TextEditingController controller,
  required TextInputType type,
  required String text,
  required IconData prefixIcon,
  required Function validator,
  bool obscureText = false,
  IconData? suffixIcon,
  // Function? onTap,
  Function(dynamic? val)? onSubmit,
  Function? onChange,
  Function? suffoxPressed,
  bool isClickable = true,
}) =>
    TextFormField(
        controller: controller,
        enabled: isClickable,
        keyboardType: type,
        onFieldSubmitted: (s) {},
        onChanged: (s) {},
        validator: (value) {
          return validator(value);
        },
        obscureText: obscureText,
        decoration: InputDecoration(
          label: Text(text),
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            prefixIcon,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: () {
                    suffoxPressed!();
                  },
                  icon: Icon(
                    suffixIcon,
                  ),
                )
              : null,
        ));

//         Widget defaultFormFieldGit({
//   required TextEditingController controller,
//   required TextInputType type,
//   Function? onSubmit,
//   Function? onChange,
//   Function? onTap,
//   bool isPassword = false,
//   required Function validate,
//   required String label,
//   required IconData prefix,
//   IconData? suffix,
//   Function? suffixPressed,
//   bool isClickable = true,
// }) =>
//     TextFormField(
//       controller: controller,
//       keyboardType: type,
//       obscureText: isPassword,
//       enabled: isClickable,
//       onFieldSubmitted: onSubmit,
//       onChanged: onChange,
//       onTap: onTap,
//       validator: validate,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(
//           prefix,
//         ),
//         suffixIcon: suffix != null
//             ? IconButton(
//           onPressed: suffixPressed,
//           icon: Icon(
//             suffix,
//           ),
//         )
//             : null,
//         border: OutlineInputBorder(),
//       ),
//     );
