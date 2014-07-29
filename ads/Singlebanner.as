package ads
{
	// Ane Extension Imports
	import com.codealchemy.ane.admobane.AdMobManager;
	import com.codealchemy.ane.admobane.AdMobPosition;
	import com.codealchemy.ane.admobane.AdMobSize;
	import com.codealchemy.ane.admobane.AdMobEvent;
	
	// Flash Imports
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.EventDispatcher;
	
	/** 
	 * Singlebanner Class<br/>
	 * The class will construct The Single Banner Example
	 *
	 **/
	public class Singlebanner extends Sprite
	{
		private var adMobManager:AdMobManager;
		private var isShow:Boolean = false;
		private var funcButton:TextField;
		
		/** 
		 * Singlebanner Constructor
		 *
		 **/
		public function Singlebanner()
		{
			// Init Sprite
			super();
			// Get the AdMobManager instance
			adMobManager = AdMobManager.manager;
			// Check if the Extension is supported
			if(adMobManager.isSupported){
			
				// Set Operation settings
				adMobManager.verbose = true;
				adMobManager.operationMode = AdMobManager.PROD_MODE;
				
				// Set AdMobId settings
				if (adMobManager.device == AdMobManager.IOS){
				//	adMobManager.bannersAdMobId = "ca-app-pub-2753474656261978/6802326443";
				}else{
				//	adMobManager.bannersAdMobId = "ca-app-pub-2753474656261978/6802326443";					
				}
				
				adMobManager.bannersAdMobId = "ca-app-pub-2753474656261978/6802326443";	
				
				// Set Targetting Settings [Optional]
				/*
				adMobManager.gender = AdMobManager.GENDER_MALE;
				adMobManager.birthYear = 1996;
				adMobManager.birthMonth = 1;
				adMobManager.birthDay = 24;
				adMobManager.isCDT = true;
				*/
				
				// Create The Banner
				adMobManager.createBanner(AdMobSize.BANNER,AdMobPosition.MIDDLE_CENTER,"StartSceneBanner", null, true);
				adMobManager.createBannerAbsolute(AdMobSize.BANNER,100, 200, "BottomBanner1", null, true);
				
				// Function Button
				var txtFormat:TextFormat = new TextFormat(null,38);
				funcButton = new TextField();
				funcButton.width = 200;
				funcButton.height = 48;
				funcButton.defaultTextFormat = txtFormat;
				funcButton.text = "SHOW/HIDE BANNERS";
				addChild(funcButton);
				funcButton.addEventListener(MouseEvent.CLICK,onClick);
				funcButton.x=100;
				funcButton.border=true;
				funcButton.y=100;
				
				// onBannerLoaded Event Listener
				if (!dispatcher.hasEventListener(AdMobEvent.BANNER_FAILED_TO_LOAD))
				{
					funcButton.text = "Attaching banner failed to load event";
					dispatcher.addEventListener(AdMobEvent.BANNER_FAILED_TO_LOAD, onBannerFailed);
				}
				else
				{
					funcButton.text = "It already has it wtf?";
				}
				
				if (!dispatcher.hasEventListener(AdMobEvent.BANNER_LOADED)) {
					funcButton.text = "Attaching banner loaded event";
					dispatcher.addEventListener(AdMobEvent.BANNER_LOADED, onBannerLoaded);				
				}
				
				var num:int = adMobManager.bannersQuantity;
				funcButton.text = String(num);
				
				adMobManager.showAllBanner();
				funcButton.text += "showing banners";
			}		
			
		}
		
			private function onBannerFailed(e:AdMobEvent):void
			{
				// Do Something like show the banner...
				funcButton.text = "Banner load failed";
				adMobManager.showAllBanner();
			}
			
			private function onBannerLoaded(e:AdMobEvent):void
			{
				// Do Something like show the banner...
				funcButton.text = "Banner loaded";
				adMobManager.showAllBanner();
			}

			/**
			 * Extension event dispatcher instance
			 **/
			private function get dispatcher():EventDispatcher
			{
				// Return the extension dispatcher
				return adMobManager.dispatcher;
			}

		/** 
		 * Hide/Show function Event Listener
		 *
		 **/
		private function onClick(e:Event):void
		{

		}
	}
}