import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoCallPage extends StatelessWidget {
  final String? name,image;
  const VideoCallPage({Key? key, this.image,this.name}):super(key: key);

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
                image: AssetImage(image!),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(onPressed: ()=>Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back,color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 150,
                      width: 100,
                      margin: const EdgeInsets.only(right: 10.0,top: 10.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage('images/m1.jpg'),
                          fit: BoxFit.cover
                        )
                      ),
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
                                child: const Icon(CupertinoIcons.camera_rotate_fill, color: Colors.white,size: 28),
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
