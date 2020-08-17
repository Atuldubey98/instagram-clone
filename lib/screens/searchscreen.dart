import 'package:flutter/material.dart';
import 'package:masterinstagram/models/user.dart';
import 'package:masterinstagram/services/searchutils.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchuserController =
      new TextEditingController();
  SearchUtils searchUtils = new SearchUtils();
  @override
  void initState() {
    searchUtils.stream = searchUtils.streamController.stream;
    super.initState();
  }

  @override
  void dispose() {
    searchUtils.streamController.close();
    searchuserController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[300],
                  ),
                  child: TextFormField(
                    onChanged: (String value) {
                      if (value.length > 3) {
                        searchUtils.getSearchedUser(value);
                      }
                    },
                    controller: searchuserController,
                    cursorRadius: Radius.circular(5),
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        hintText: "Search",
                        contentPadding: EdgeInsets.only(left: 20, right: 20),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: StreamBuilder<List<User>>(
                stream: searchUtils.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(),
                          title: Text(snapshot.data[index].username),
                          trailing: Text(snapshot.data[index].emailid),
                        );
                      },
                      itemCount: snapshot.data.length,
                    );
                  }
                  return Container();
                }),
          )
        ],
      ),
    );
  }
}
