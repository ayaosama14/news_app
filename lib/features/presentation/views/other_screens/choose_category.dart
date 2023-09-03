import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/utils/capitalize_string_extension.dart';
import 'package:news_app/features/presentation/views/home_view.dart';

List<String> categoryList = [
  'business',
  'entertainment',
  'general',
  'science',
  'sports',
  'technology',
  'health',
];
List<String> categoryImageList = [
  'https://freepngimg.com/download/business/70298-management-business-icons-consultant-company-social-marketing.png',
  'https://cdn-icons-png.flaticon.com/512/6008/6008427.png',
  'https://grin2b.com/wp-content/uploads/2017/01/Grin2B_icon_NEWS.png',
  'https://cdn-icons-png.flaticon.com/512/2947/2947865.png',
  'https://img.freepik.com/premium-vector/jumping-icon-sports-logo-vector_148524-30.jpg?w=2000',
  'https://img.freepik.com/free-vector/illustration-social-media-concept_53876-18383.jpg?w=2000',
  'https://cdn-icons-png.flaticon.com/512/4003/4003833.png',
];
List<String> passedParameterList = [];

class ChooseCategoryScreen extends StatefulWidget {
  const ChooseCategoryScreen({super.key});

  @override
  State<ChooseCategoryScreen> createState() => _ChooseCategoryScreenState();
}

class _ChooseCategoryScreenState extends State<ChooseCategoryScreen> {
  bool isChecked = false;
  List selectedIndex = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Choose Categories to start read about",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 5,
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.915,
                  ),
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex.contains(index)
                                ? selectedIndex.remove(index)
                                : selectedIndex.add(index);
                            isChecked = !isChecked;
                          });
                          if (passedParameterList
                                  .contains(categoryList[index]) &&
                              categoryList.isNotEmpty) {
                            passedParameterList.remove(categoryList[index]);
                            debugPrint(
                                '${passedParameterList[index]} deleted successfully');
                          } else if (!(passedParameterList
                                  .contains(categoryList[index]) &&
                              categoryList.isEmpty)) {
                            passedParameterList.add(categoryList[index]);
                            debugPrint(
                                '${passedParameterList[index]} added successfully');
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: selectedIndex.contains(index)
                                ? Border.all(
                                    color: Colors.blue,
                                    width: 3,
                                    strokeAlign: BorderSide.strokeAlignOutside)
                                : null,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: categoryImageList[index],
                                  height: 135,
                                ),
                                Text(
                                  categoryList[index].capitalize(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })),
          MaterialButton(
            height: 50,
            color: Colors.blue,
            onPressed: () {
              print(passedParameterList);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeView(
                            passedParameterList: passedParameterList,
                          )));
            },
            child: const Text(
              "Continue",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
