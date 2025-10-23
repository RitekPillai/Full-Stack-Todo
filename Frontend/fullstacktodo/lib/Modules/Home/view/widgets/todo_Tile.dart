import 'package:flutter/material.dart';

Widget todoTile(String name, String Description, bool isCompleted) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, top: 15, bottom: 15),
    child: Container(
      height: 70,
      width: 50,
      decoration: BoxDecoration(
        color: Color(0xfff4f7ff).withAlpha(100),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),

              child: Checkbox(
                shape: CircleBorder(side: BorderSide(color: Colors.black)),
                value: isCompleted,
                onChanged: (value) {
                  value = true;
                },
              ),
            ),

            Text(name, style: TextStyle(fontSize: 20)),
            const SizedBox(width: 23),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz_sharp)),
          ],
        ),
      ),
    ),
  );
}
