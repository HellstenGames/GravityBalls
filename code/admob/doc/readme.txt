==admob for flash ==
admob ane for flash air mobile application .
 *  support Interstitial and Banner
 *  support  landscape and portrait  and autoOrient
 *  support ios 5, ios 6, ios 7 ,and android
 *  support all native event
 *  support admob 1 and admob 2

project home:http://code.google.com/p/flash-air-admob-ane-for-ios-and-android/

download:https://github.com/lilili87222/admob-for-flash/archive/master.zip

admob home: http://www.admob.com

base on admob ios sdk 6.9.3 and admob android sdk(Google Play services 4.3) 4.3 and air sdk 4.0 

requred  air sdk 4.0 or later

===admob_all_in_one.ane===
contains admob for ios and for android in one file,very convenient 
very easy to use ,just three line code for simple usage

===extension ID===
{{{
<extensionID>so.cuo.platform.admob</extensionID>
}}}

===simple banner usage:===
{{{
var admob:Admob=Admob.getInstance();
admob.setKeys("a152834c8723912");
admob.showBanner(Admob.BANNER,AdmobPosition.BOTTOM_CENTER);
}}}

===usage  Interstitial ad (full screen ad)===
{{{
import so.cuo.platform.admob.Admob;
import so.cuo.platform.admob.AdmobEvent;
import so.cuo.platform.admob.AdmobSize;

var admob:Admob=Admob.getInstance();
admob.setKeys("ca-app-pub-17380930385764784/6322941144","ca-app-pub-17380930385764874/4846207943");////replace this fake ID with your really ID
if (admob.isInterstitialReady())// check ad has cached ,if true show it
{
     admob.showInterstitial();
}
else
{
    admob.cacheInterstitial();
}
}}}

for android.  you need add in application-app.xml
{{{
<android>
        <manifestAdditions><![CDATA[
			<manifest android:installLocation="auto">
			    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
			    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
			     <application>
			           <meta-data android:name="com.google.android.gms.version" android:value="4452000" />
			  	   <activity android:name="com.google.android.gms.ads.AdActivity" android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize"/>
			     </application>
			</manifest>
		]]></manifestAdditions>
    </android>
}}}
===more function===
1. how to handler admob event with admob ane for flash ,just do like this
{{{
admob.addEventListener(AdmobEvent.onBannerReceive,onAdReceived);
}}}
2. how to get admob banner ad size info with admob ane for flex
{{{
protected function onAdReceived(event:AdmobEvent):void
{
    if(event.type==AdmobEvent.onBannerReceive){
	trace(event.data.width,event.data.height);
    }
}
}}}
3.how to get screen size info in flash air android or ios app,just do like this
{{{
admob.getScreenSize()
}}}
===admob ane 6.9.3===
1.update admob sdk ios to 6.9.3 ,update android google service sdk to the last version
2.trace the detail when load ad fail
===admob ane 6.9.2 updates===
1.update admob sdk ios 6.9.2 ,android google service sdk 4.3

2.add getScreenSize function for show banner absolute

===admob ane 6.6.0 updates===
1.support  landscape and portrait  and autoOrient

2.support relation position and Absolute position

3.support ios 5, ios 6, ios 7 ,and android

4.update admob sdk to last version
===admob ane 6.4.1 updates===
enable Interstitial admob ad 
===admob ane 6.3.1 updates===
1.include ios and android in one file

2.enable debug and pack on pc

3.base on admob6.3 no more use udid

4.enable get ad size info and screen size info

----

contact:wohaosea2@gmail.com ,qq group: 56892018