import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';
import 'package:stud_advice/src/screens/deals/deals_total_screen.dart';
import 'package:stud_advice/src/widgets/deals/deal_item.dart';
import '../../../stud_advice.dart';
import '../../controllers/deals/search_deals_controller.dart';
import '../../models/stud_advice/deals.dart';
import '../../widgets/deals/deal_item_slide.dart';

class DealsScreen extends StatelessWidget {
  static const navigatorId = '/deals_screen';
  final PageController _controller = PageController();
  final SearchDealsController searchDealsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: FutureBuilder<Deals>(
        future: searchDealsController.getDealsBySearch(size: 3, number: 0),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final deals = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                      child: PageView.builder(
                        controller: _controller,
                        itemCount: deals.numberOfElements,
                        itemBuilder: (context, index) {
                          return DealItemSlide(deal: deals.content[index]);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SmoothPageIndicator(
                      controller: _controller,
                      count: deals.content.length,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: AppColors.primaryColor,
                        dotColor: AppColors.grey,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 10,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Recommended",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => DealsTotalScreen());
                          },
                          child: const Icon(
                            Icons.add,
                            color: AppColors.black,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                    FutureBuilder<Deals>(
                      future: searchDealsController.getRecommendedDeals(size: 4, number: 0),
                      builder: (context, recommendedSnapshot) {
                        if (recommendedSnapshot.connectionState ==
                            ConnectionState.done) {
                          if (recommendedSnapshot.hasData) {
                            final recommendedDeals =
                            recommendedSnapshot.data!;
                            return Expanded(
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: recommendedDeals.numberOfElements,
                                itemBuilder: (context, index) {
                                  return DealItem(
                                    deal: recommendedDeals.content[index],
                                  );
                                },
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text('No recommended deals found.'),
                            );
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('No deals found.'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
