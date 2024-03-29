﻿<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
<!--
	Usage:
	To localize the description, use the following format for the description element.
	<description>
	<text xml:lang="en">English App description goes here</text>
	<text xml:lang="fr">French App description goes here</text>
	<text xml:lang="ja">Japanese App description goes here</text>
	</description>
	To localize the name, use the following format for the name element.
	<name>
	<text xml:lang="en">English App name goes here</text>
	<text xml:lang="fr">French App name goes here</text>
	<text xml:lang="ja">Japanese App name goes here</text>
	</name>
-->
<application xmlns="http://ns.adobe.com/air/application/3.8">
  <id>GravityBalls</id>
  <versionNumber>1.0</versionNumber>
  <filename>GravityBalls</filename>
  <description/>
  <name>GravityBalls</name>
  <copyright/>
  <initialWindow>
    <content>GravityBalls.swf</content>
    <systemChrome>standard</systemChrome>
    <transparent>false</transparent>
    <visible>true</visible>
    <fullScreen>false</fullScreen>
    <aspectRatio>landscape</aspectRatio>
    <renderMode>direct</renderMode>
    <autoOrients>false</autoOrients>
    <maximizable>true</maximizable>
    <minimizable>true</minimizable>
    <resizable>true</resizable>
  </initialWindow>
  <icon>
    <image72x72>AppIconsForPublish/ic_launcher_72.png</image72x72></icon>
  <customUpdateUI>false</customUpdateUI>
  <allowBrowserInvocation>false</allowBrowserInvocation>
  <android>
    <manifestAdditions><![CDATA[<manifest>
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
</manifest>]]></manifestAdditions>
  </android>
  <versionLabel/>
  <supportedLanguages>en</supportedLanguages>

  <extensions>
    <extensionID>com.brinkbit.admob</extensionID>
  </extensions>
</application>
