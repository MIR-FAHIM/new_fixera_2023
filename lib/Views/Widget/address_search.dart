import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Widget/place_service.dart';
import 'package:flutter/material.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  final sessionToken;
  PlaceApiProvider? apiClient;
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(

      icon: query == "" ?Icon(Icons.search): Icon(Icons.check, color: Colors.blueAccent,),
      onPressed: () {
        print("$query");
        SharedPref.location = query;
       // Navigator.pop(context);
      //  close(context, Suggestion(placeId, description));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    SharedPref.location = query;
    Navigator.pop(context);
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: query == "" ? null : apiClient!.fetchSuggestions(query),
        builder: (context, snapshot) => query == ""
            ? Container(child: Text("Enter Your Address"))
            : snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) => ListTile(
                      title: Text((snapshot.data![i] as Suggestion).description),
                      onTap: () {
                        print(
                            "${(snapshot.data![i] as Suggestion).description}");
                        close(context, snapshot.data![i] as Suggestion);

                        //Navigator.pop(context);
                      },
                    ),
                  )
                : Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ));
  }
}
