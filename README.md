# UnrdiOSApp

This app uses embedded frameworks. These frameworks can be found here https://github.com/jellyfishjules/Unrd.

The UI is extremely simple and shows a story name along with a short summary, with a video playing in the background.

The presntation layer uses MVVM without using any 3rd party frameworks. The Network layer is also built without using 3rd party frameworks.

You can see the power of the embedded frameworks
 by how simply the whole app is composed. In the ScenceDelegate (the composition root) we simply compose our feature using the frameworks and thats it. If we wanted to build a sperate UI for mac, ipad or appleTV we could use exactly the same techniques as everything is encapsulated inside the frameworks. Anything platform specific (UIKIT references for example) is in its own framework. 
