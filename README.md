# WatchKit-ComplicationDemo
watchOS2.0 complication demo

#Requirement
Xcode7.0beta
watchOS2.0+iOS9.0

#Tips
Deep press on Modular or Utilitarian WatchFace and choose this complication.

Compatible with TLS 1.1 SSL by adding below to WatchKit Extension’s Info.plist:
``` 
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>
``` 
