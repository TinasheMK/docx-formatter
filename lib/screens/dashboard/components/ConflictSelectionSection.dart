import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/widgets/app_button_widget.dart';
import 'package:smart_admin_dashboard/core/types/daily_info_model.dart';
import 'package:smart_admin_dashboard/core/utils/responsive.dart';
import 'package:flutter/material.dart';

// import '../../../providers/Conflict.dart';
import '../../../core/types/Conflict.dart';
import '../../../core/models/Client.dart';

class ConflictSelectionSection extends StatelessWidget {
  ConflictSelectionSection({
    Key? key,
    required this.conflict

  }) : super(key: key);

  final Conflict conflict;

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
            childAspectRatio: _size.width < 650 ? 3/2 : 1,
            conflict: conflict
          ),
          tablet: InformationCard(
            conflict: conflict
          ),
          desktop: InformationCard(
            childAspectRatio: _size.width < 1400 ? 2 : 3,
            conflict: conflict
          ),
        ),
        SizedBox(
          height: 16,
        ),
        ElevatedButton.icon(
            icon: Icon(
              Icons.close,
              size: 14,
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.grey),
            onPressed: () {
              Navigator.of(context).pop();
            },
            label: Text("Accept Incoming")),
        SizedBox(
          height: 20,
        ),
        ElevatedButton.icon(
            icon: Icon(
              Icons.delete,
              size: 14,
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.red),
            onPressed: () {},
            label: Text("Use Local"))
      ],
    );
  }
}



class InformationCard extends StatefulWidget {
  const InformationCard({
    Key? key,
    this.crossAxisCount = 2,
    this.childAspectRatio = 6,
    required this.conflict,

  }) : super(key: key);

  final Conflict conflict;
  final int crossAxisCount;
  final double childAspectRatio;


  @override
  _InformationCardState createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {


  List<Client> clients = [Client.fromJson({})];

  Future<void> _initClients() async {
    clients = await getClients();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _initClients();
  }


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
          MiniInformationWidget(memo: clients[index]),
    );
  }
}

class MiniInformationWidget extends StatefulWidget {
  const MiniInformationWidget({
    Key? key,
    required this.memo
  }) : super(key: key);
  final Client memo;

  @override
  _MiniInformationWidgetState createState() => _MiniInformationWidgetState();
}

class _MiniInformationWidgetState extends State<MiniInformationWidget> {
  bool _visible = false;

  int selectedClient = 0;

  TextEditingController _controller = TextEditingController();

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  int charLength = 0;

  bool status = false;
  bool _closeIcon = true;

  _onChanged(String value) {
    setState(() {
      charLength = value.length;
    });

    if (charLength >= 6) {
      setState(() {
        _closeIcon = _closeIcon;
        status = true;
      });
    } else {
      setState(() {
        _closeIcon = !_closeIcon;
        status = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 6,),
                      Text(
                        "Due Date",
                        style:
                        const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 14),
                        // "${widget.memo.name?? 'Name'}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                    ],
                  ),
                ),
            ),

          ],
        ),
        SizedBox(height: 5,),
        Container(
          padding: EdgeInsets.all(defaultPadding/3),
          decoration: BoxDecoration(
            color: selectedClient==widget.memo.id?darkgreenColor:Colors.black38,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child:
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.lightBlue,
                              size: 12,
                            ),
                            SizedBox(width: 6,),
                            Text(
                              "Tinashe Makarudze",
                              style:
                              const TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 12),
                              // "${widget.memo.name?? 'Name'}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        // _toggle();
                        if(selectedClient==widget.memo.id){
                          selectedClient=='';
                          print(selectedClient);
                          Navigator.of(context).pop();
                          setState(() {
                          });
                        }else{
                          selectedClient = widget.memo.id!;
                          print(selectedClient);
                          Navigator.of(context).pop();
                          setState(() {
                          });

                        }
                      }
                  ),

                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 6,),
                            Text(
                              "11/02/23 ",
                              style:
                              const TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 12),
                              // "${widget.memo.name?? 'Name'}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.redAccent,
                              size: 12,
                            ),
                            Text(
                              "12/03/23 ",
                              style:
                              const TextStyle(color: Colors.greenAccent, fontStyle: FontStyle.italic, fontSize: 12),
                              // "${widget.memo.name?? 'Name'}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        // _toggle();
                        if(selectedClient==widget.memo.id){
                          selectedClient=='';
                          print(selectedClient);
                          Navigator.of(context).pop();
                          setState(() {
                          });
                        }else{
                          selectedClient = widget.memo.id!;
                          print(selectedClient);
                          Navigator.of(context).pop();
                          setState(() {
                          });

                        }
                      }
                  ),

                ],
              ),
            ],
          ),



        ),
        SizedBox(height: 5,),
        Container(
          padding: EdgeInsets.all(defaultPadding/3),
          decoration: BoxDecoration(
            color: selectedClient==widget.memo.id?darkgreenColor:Colors.black38,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child:
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.lightBlue,
                              size: 12,
                            ),
                            SizedBox(width: 6,),
                            Text(
                              "Tinashe Makarudze",
                              style:
                              const TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 12),
                              // "${widget.memo.name?? 'Name'}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        // _toggle();
                        if(selectedClient==widget.memo.id){
                          selectedClient=='';
                          print(selectedClient);
                          Navigator.of(context).pop();
                          setState(() {
                          });
                        }else{
                          selectedClient = widget.memo.id!;
                          print(selectedClient);
                          Navigator.of(context).pop();
                          setState(() {
                          });

                        }
                      }
                  ),

                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 6,),
                            Text(
                              "11/02/23 ",
                              style:
                              const TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 12),
                              // "${widget.memo.name?? 'Name'}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.redAccent,
                              size: 12,
                            ),
                            Text(
                              "12/03/23 ",
                              style:
                              const TextStyle(color: Colors.greenAccent, fontStyle: FontStyle.italic, fontSize: 12),
                              // "${widget.memo.name?? 'Name'}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        // _toggle();
                        if(selectedClient==widget.memo.id){
                          selectedClient=='';
                          print(selectedClient);
                          Navigator.of(context).pop();
                          setState(() {
                          });
                        }else{
                          selectedClient = widget.memo.id!;
                          print(selectedClient);
                          Navigator.of(context).pop();
                          setState(() {
                          });

                        }
                      }
                  ),

                ],
              ),
              SizedBox(height: 5,),
            ],

          ),



        ),
      ],
    );


  }

}
