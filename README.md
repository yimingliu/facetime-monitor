#  FaceTime Connection Monitor


This is a tool that watches the system log facility for repeated instances of

```avconferenced: (AVConference) [com.apple.AVConference:log]  [WARNING] CalculateVideoTimestamp:1876 CalculateVideoTimestamp FORCE forward: dAudio/dVideo: 528600.789559/528600.750222  dwAudioTS/dwVideoTS: 1440/495 -> 1441 (last: 1440)```

and alerts you when it happens.


## Why?

This error indicates that your FaceTime partner is *no longer seeing you*.  Due to some kind of macOS bug, the remote side will start to show "Poor connection" even though your Internet connection is just fine.  The video will cut out and be replaced by the Poor connection black screen, while the audio will be just fine.  The "poor connection" error will never improve, and will necessitate a hangup and redial.

This error is one-way.  You will still be able to see your Facetime partner.  Since you are seeing your partner just fine, and the remote side can still _hear_ you, you may not realize that the video connection has actually dropped –- unless they interrupt the conversation and tell you, which sometimes, depending on the social context, they might opt not to.


## What does this do?

The monitor will simply show a notification that FaceTime has entered perpetual "poor connection" mode for this conversation, and advise you to hangup and reconnect.


## Why does the app only show a blank window when I open it?

Only apps with GUIs are allowed to post OS-level notifications that show up in macOS's Notification Center.  I originally wrote this tool as purely a command line daemon that could be run as a LaunchAgent -- since obviously this monitor does not require, or even want, a user interface of any sort.  After most of the coding is complete, I tested it, only to realize that Foundation framework apps can't post OS-level notifications.  

Therefore, this tool shows a blank window as a "GUI", to satisfy this silly Apple requirement in order to be able to use the Notification system.


## Why does FCM show a generic app icon in the notification?

Because I can't draw.  I'd turn the icon off, but I can't find a way to do it.
