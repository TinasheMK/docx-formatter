import 'package:docxform/core/constants/color_constants.dart';

import 'package:docxform/core/utils/responsive.dart';
import 'package:docxform/screens/dashboard/components/mini_information_widget.dart';
import 'package:docxform/screens/zimra/new/new_zimra_home_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/models/daily_info_model.dart';
import '../../objectives/objectives_home_screen.dart';
import '../../register/new/new_register_home_screen.dart';
import '../../stages/stages_home_screen.dart';

class ZimrasHeader extends StatelessWidget {
  final String title;

  const ZimrasHeader({
    Key? key, required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "${title} Registration Office",
              style: Theme.of(context).textTheme.headline6,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                // backgroundColor: Colors.,
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                  defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StagesHomeScreen()),
                );


              },
              icon: Icon(Icons.toc),
              label: Text(
                "Stages",
              ),
            ),

            ElevatedButton.icon(
              style: TextButton.styleFrom(
                // backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                  defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewZimraHome(title: title, code: 'wiw',)),
                );


              },
              icon: Icon(Icons.add),
              label: Text(
                "Start ${title} Reg",
              ),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        // Responsive(
        //   mobile: InformationCard(
        //     crossAxisCount: _size.width < 650 ? 2 : 4,
        //     childAspectRatio: _size.width < 650 ? 1.2 : 1,
        //   ),
        //   tablet: InformationCard(),
        //   desktop: InformationCard(
        //     childAspectRatio: _size.width < 1400 ? 1.2 : 1.4,
        //   ),
        // ),
      ],
    );
  }
}

class InformationCard extends StatelessWidget {
  const InformationCard({
    Key? key,
    this.crossAxisCount = 5,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: dailyDatas.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) =>
          MiniInformationWidget(dailyData: dailyDatas[index]),
    );
  }
}
