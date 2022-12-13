import 'package:flutter/material.dart';
import 'package:film_review/model/bookdan.dart';
import 'booknoticeItem.dart';
import 'shudan.dart';

class includebook extends StatelessWidget {
  List<bookdan> includebang;
  includebook({Key key, this.includebang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: Center(
          child: Text("包含书单"),
        ),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0), // 设置padding
      itemBuilder: (context, index) {
        return shudan(includebang[index]);
      },
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: includebang.length,
    );
  }
}
