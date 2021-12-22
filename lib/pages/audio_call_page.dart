import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioCall extends StatefulWidget {
  final String? name,image;
  const AudioCall({Key? key, this.image,this.name}):super(key: key);

  @override
  _AudioCallState createState() => _AudioCallState();
}

class _AudioCallState extends State<AudioCall> {

  // void starttimer() {
  //   const onesec = Duration(seconds: 1);
  //   Timer.periodic(onesec, (Timer t) {
  //
  //     setState(() {
  //       if (timer <= 1) {
  //         stopMusic();
  //         t.cancel();
  //         _showTimeUpDialog();
  //         setState(() {
  //           tScore.name = widget.name;
  //           tScore.score = _currentScore;
  //           tScore.income = _currentIncome;
  //         });
  //         _save();
  //       } else if (canceltimer == true) {
  //         t.cancel();
  //       } else {
  //         timer = timer - 1;
  //       }
  //       showtimer = timer.toString();
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage(widget.image!),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black45,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    ///Top Section
                    Column(
                      children: [
                        ///Appbar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(onPressed: ()=>Navigator.pop(context),
                                  icon: const Icon(Icons.arrow_back,color: Colors.white)),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Container(
                                    height: 25,
                                    width: 70,
                                    decoration: const BoxDecoration(
                                      color: Color(0xff7B7F7E),
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(50))
                                    ),
                                    child: const Icon(Icons.videocam_off,color: Colors.black,),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),

                        ///Name image section
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0, left: 16.0, bottom: 8.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                                widget.image!),
                            radius: 24.0,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${widget.name!} Islam', style: const TextStyle(fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          '01:30', style: TextStyle(fontSize: 20.0,color: Colors.white),
                        ),
                      ],
                    ),

                    ///Bottom Section
                    Container(
                      height: 95,
                      decoration: const BoxDecoration(
                        color: Color(0xff1D1F1C),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        Container(
                        height: 6,
                        width: 35,
                        margin:const EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
                            color: Color(0xff5E615D),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey[600],
                                child: const Icon(Icons.person_add_rounded, color: Colors.white,size: 28),
                              ),
                              const SizedBox(width: 20),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey[600],
                                child: const Icon(CupertinoIcons.volume_down, color: Colors.white,size: 28),
                              ),
                              const SizedBox(width: 20),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey[600],
                                child: const Icon(Icons.mic_sharp, color: Colors.white,size: 28)
                              ),
                              const SizedBox(width: 20),
                              const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.redAccent,
                                child: Icon(CupertinoIcons.phone_down_fill, color: Colors.white,size: 28)
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
