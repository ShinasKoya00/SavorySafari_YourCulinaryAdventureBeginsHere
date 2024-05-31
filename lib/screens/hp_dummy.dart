// class HpDummy extends StatefulWidget {
//   const HpDummy({super.key});
//
//   @override
//   State<HpDummy> createState() => _HpDummyState();
// }
//
// class _HpDummyState extends State<HpDummy> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: height,
//             width: width,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.deepPurple.shade100,
//                   Colors.deepPurple.shade500,
//                 ],
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Row(
//                         children: [
//                           GestureDetector(
//                             onTap: _searchRecipe,
//                             child: const Padding(
//                               padding: EdgeInsets.fromLTRB(3, 0, 7, 0),
//                               child: Icon(
//                                 Icons.search,
//                                 color: Colors.blueAccent,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: TextField(
//                               controller: searchController,
//                               decoration: const InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: "Let's cook something",
//                               ),
//                               onSubmitted: (value) {
//                                 _searchRecipe();
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     const Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "WHAT DO YOU WANT TO COOK TODAY?",
//                         style: TextStyle(fontSize: 33, color: Colors.white),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Let's Cook Something New!",
//                         style: TextStyle(fontSize: 20, color: Colors.white),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 70,
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         padding: const EdgeInsets.symmetric(vertical: 5),
//                         scrollDirection: Axis.horizontal,
//                         itemCount: recipeCategoryList.length,
//                         itemBuilder: (context, index) {
//                           return Container(
//                             width: 150,
//                             margin: const EdgeInsets.only(right: 15),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               color: Colors.white,
//                             ),
//                             child: InkWell(
//                               onTap: () {
//                                 log("section [$index] clicked");
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             SearchPage(query: recipeCategoryList[index]["heading"])));
//                               },
//                               child: Stack(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(15),
//                                     child: Image.network(
//                                       recipeCategoryList[index]["imgUrl"],
//                                       fit: BoxFit.cover,
//                                       height: height,
//                                       width: width,
//                                     ),
//                                   ),
//                                   Positioned(
//                                     bottom: 0,
//                                     left: 0,
//                                     right: 0,
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(15),
//                                       child: Container(
//                                         padding: const EdgeInsets.all(8),
//                                         color: Colors.black54,
//                                         child: Text(
//                                           recipeCategoryList[index]["heading"],
//                                           style: const TextStyle(color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     _isLoading
//                         ? const CircularProgressIndicator()
//                         : ListView.builder(
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: recipeList.length,
//                       itemBuilder: (context, index) {
//                         return InkWell(
//                           onTap: () {
//                             log("card [$index] clicked");
//                           },
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             margin: const EdgeInsets.only(top: 20),
//                             child: Stack(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(15),
//                                   child: Image.network(
//                                     recipeList[index].appimgUrl,
//                                     fit: BoxFit.fitWidth,
//                                     height: 220,
//                                     width: width,
//                                   ),
//                                 ),
//                                 Positioned(
//                                   left: 0,
//                                   bottom: 0,
//                                   right: 0,
//                                   child: Container(
//                                     padding: const EdgeInsets.all(10),
//                                     decoration: const BoxDecoration(
//                                       color: Colors.black38,
//                                       borderRadius: BorderRadius.only(
//                                         bottomLeft: Radius.circular(15),
//                                         bottomRight: Radius.circular(15),
//                                       ),
//                                     ),
//                                     child: Text(
//                                       recipeList[index].applabel,
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 0,
//                                   right: 0,
//                                   height: 30,
//                                   width: 80,
//                                   child: Container(
//                                     alignment: Alignment.centerLeft,
//                                     decoration: const BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.only(
//                                         topRight: Radius.circular(15),
//                                         bottomLeft: Radius.circular(15),
//                                       ),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         const Icon(
//                                           Icons.local_fire_department,
//                                           size: 18,
//                                         ),
//                                         const SizedBox(width: 3),
//                                         Text(
//                                           recipeList[index].appCalories.toStringAsFixed(2),
//                                           style: const TextStyle(fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );;
//   }
// }
