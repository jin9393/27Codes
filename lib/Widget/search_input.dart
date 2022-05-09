import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'merchant_page.dart';

class SearchInput extends StatelessWidget {

  var textController;
  final searchText = TextEditingController();
  String searchStr = '';
  final void Function() onTap;

  SearchInput(
      {required this.textController,required this.onTap});
  // SearchInput({required this.addUser});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: Container(
          height: 40,
          child: TextField(
            controller: textController,
            onSubmitted: (value){
              searchStr = value;
              print(searchStr);
            },
            onChanged: (value){
              searchStr = value;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 35, right: 35),
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              prefixIcon: IconButton(
                onPressed: (){
                  print(searchStr);
                  onTap();
                },
                icon: Icon(Icons.search_rounded),
                color: Colors.black,
                iconSize: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: 'Search',
            ),
          ),
        ));
  }
}
