import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../bloc/astronomy_bloc.dart';
import '../bloc/astronomy_event.dart';
import '../bloc/astronomy_state.dart';
import '../data/astronomy_response.dart';
import '../data/astronomy_api.dart'; // Ensure you have this file
import 'video_player_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AstronomyPictureDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(
        child: Text(
                  "NASA Astronomy Picture of the Day",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: 'Roboto',
                  ),
                ),
      ),),
      body: BlocProvider(
        create: (context) => AstronomyBloc(AstronomyApi())..add(LoadAstronomyPicture()), // Trigger loading
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AstronomyContent(),
        ),
      ),
    );
  }
}
class AstronomyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
    
      child: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<AstronomyBloc, AstronomyState>(
            builder: (context, state) {
              if (state is AstronomyLoading) {
                return CircularProgressIndicator();
                
                // Container(
                //   padding: EdgeInsets.all(20),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: const [
                //       CircularProgressIndicator(),
                //       SizedBox(height: 8),
                //       Text("Fetching latest pic of the day..."),
                //     ],
                //   ),
                // );
             
              } else if (state is AstronomyError) {
                return Center(child: Text('Error: ${state.message}'));
              } else if (state is AstronomyLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                          Fluttertoast.showToast(
                            msg: "Loaded Successfully!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        });
                return Column(
                  children: [
                    displayAstronomyData(state.astronomyResponse,context),
                    SizedBox(height: 30),
              
                            // displaying the explanation
                            Container(
                              width: MediaQuery.of(context).size.width*0.9,
                              child: Text(
                                state.astronomyResponse.explanation,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                  ],
                );
              }
              return Container(); // Fallback for unexpected state
            },
          ),
        ),
      ),
    );
  }

  Widget displayAstronomyData(AstronomyResponse response,BuildContext context) {
    if (response.mediaType == "image") {
      return response.url.isNotEmpty?
      displayNetworkImage(response.url):Text("Error loading image");
    } else if (response.mediaType == "video") {
      return response.url.isNotEmpty?
       Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height / 2,
                                      color: Colors.green,
                                      child: VideoPlayerScreen(url: response.url),
                                    ):Text("Error loading video");
    }
    return Text("Unsupported media type");
  }

  Widget displayNetworkImage(String url) {
    // Check if the URL ends with .svg
    if (url.endsWith(".svg")) {
      return SvgPicture.network(
        url,
        placeholderBuilder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text("Fetching latest pic of the day..."),
          ],
        ),
      );
    }
    //other formats
     else {
      return CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text("Fetching latest pic of the day..."),
          ],
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    }
  }
}