import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String imgurl;

  Avatar({Key key, this.imgurl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: _buildImg(imgurl));
  }

  Widget _buildImg(imgurl) {
    return Container(
        width: 60.0,
        height: 60.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage(imgurl ??
                    "https://images.unsplash.com/photo-1490717064594-3bd2c4081693?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"))));
  }

//   Widget _buildText(message) {
//   return Text(
//     message ?? 'Resources not available!',
//     style: TextStyle(
//       fontSize: 18.0,
//       color: Colors.grey[500],
//     ),
//   );
// }

}
