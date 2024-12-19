import 'package:flutter/material.dart';
class positioned extends StatelessWidget {
  const positioned({
    super.key,
    required this.popularBooks,
  });

  final List popularBooks;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: -20,
      right: 0,
      child: Container(
        height: 180,
        child: PageView.builder(
            controller: PageController(viewportFraction: 0.8),
            itemCount: popularBooks == null
                ? 0
                : popularBooks.length, // Safely check null
            itemBuilder: (_, i) {
              return Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(popularBooks[i]
                    ["img"]), // Handle possible null
                    fit: BoxFit.fill,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
