import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/utils/responsive.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/UserPreference.dart';
import '../../../core/types/Memo.dart';
import '../../../core/models/Company.dart';
import '../new/new_profile_home_screen.dart';

class AddBusinessProfile extends StatelessWidget {
  const AddBusinessProfile({
    Key? key,
    required this.memos,
    required this.callback

  }) : super(key: key);

  final Function(String, String) callback;
  final List<Memo> memos;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: InformationCard(
            crossAxisCount: _size.width < 650 ? 1 : 1,
            childAspectRatio: _size.width < 650 ? 5 : 8,
            memos: memos,
            callback: callback
          ),
          tablet: InformationCard(
            memos: memos,
            callback: callback
          ),
          desktop: InformationCard(
            childAspectRatio: _size.width < 1400 ? 6 : 6,
            memos: memos,
            callback: callback
          ),
        ),
      ],
    );
  }
}


class InformationCard extends StatefulWidget {
  const InformationCard({
    Key? key,
    this.crossAxisCount = 2,
    this.childAspectRatio = 6,
    required this.memos,
    required this.callback,

  }) : super(key: key);

  final List<Memo> memos;
  final int crossAxisCount;
  final double childAspectRatio;
  final Function(String, String) callback;


  @override
  _InformationCardState createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {


  List<Company> clients = [Company.fromJson({})];

  Future<void> _initCompanys() async {
    clients = await getCompanys();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _initCompanys();
  }


  @override
  Widget build(BuildContext context) {
    return clients.isEmpty ? Text("Add a business profile") :GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: clients.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemBuilder: (context, index) =>
          MiniInformationWidget(memo: clients[index], callback:widget.callback),
    );
  }
}

class MiniInformationWidget extends StatefulWidget {
  const MiniInformationWidget({
    Key? key,
    required this.memo,
    required this.callback
  }) : super(key: key);
  final Company memo;
  final Function(String, String) callback;

  @override
  _MiniInformationWidgetState createState() => _MiniInformationWidgetState();
}

class _MiniInformationWidgetState extends State<MiniInformationWidget> {
  bool _visible = false;

  TextEditingController _controller = TextEditingController();

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  int charLength = 0;

  bool status = false;
  bool _closeIcon = true;

  SharedPreferences? prefs;
  int? activeCompany;

  init() async {
    prefs = await SharedPreferences.getInstance();
    activeCompany = await prefs!.getInt(UserPreference.activeCompany);
    setState(() {  activeCompany; });
  }

  @override
  void initState() {
    init();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var variaId = widget.memo.id;

    print('This is the active company: $activeCompany');
    print('Business id is: $variaId');


    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: activeCompany==widget.memo.id?darkgreenColor:Colors.black38,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


          GestureDetector(
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(defaultPadding * 0),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue!.withOpacity(0.1),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Icon(
                        Icons.house,
                        color: Colors.lightBlue,
                        size: 18,
                      ),
                    ),
                    SizedBox(width: 6,),
                    Text(
                      "${widget.memo.companyName??''}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Visibility(
                      visible: !_visible,
                      child: activeCompany==widget.memo.id?Text("Active",   style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.blue),):SizedBox(),
                    )
                  ],
                ),
              ),
              onTap: () {
                // _toggle();
                if(widget.memo.set=="set"){
                  widget.callback(widget.memo.id.toString()!, "not");
                  setState(() {
                    widget.memo.set="not";
                  });
                }else{
                  widget.callback(widget.memo.id.toString()!, "set");
                  setState(() {
                    widget.memo.set="set";
                  });

                }

                //
                // Navigator.of(context).push(new MaterialPageRoute<Null>(
                //     builder: (BuildContext context) {
                //       return new NewClientHome(title: "Edit Client", code: "edit", clientId: widget.memo.id );
                //     },
                //     fullscreenDialog: true));


                print(widget.memo.toJson());
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewProfileHome(title: 'New Invoice', code: 'invoice', profileId: widget.memo.id)),
                );







              }
              ),

        ],
      ),
    );
  }

}
