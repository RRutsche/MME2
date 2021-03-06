package de.rutscheschobel.shareyourfilter.main{
	import de.rutscheschobel.shareyourfilter.service.HttpRESTService;
	import de.rutscheschobel.shareyourfilter.service.ServiceManager;
	import de.rutscheschobel.shareyourfilter.util.*;
	import de.rutscheschobel.shareyourfilter.util.FileExplorer;
	import de.rutscheschobel.shareyourfilter.view.ImageWindow;
	import de.rutscheschobel.shareyourfilter.view.components.BatchJobComponent;
	import de.rutscheschobel.shareyourfilter.view.components.Splashscreen;
	
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeApplication;
	import flash.desktop.NativeDragManager;
	import flash.display.NativeWindow;
	import flash.events.NativeDragEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.FileSystemTree;
	import mx.controls.MenuBar;
	import mx.core.WindowedApplication;
	import mx.events.MenuEvent;
	import mx.managers.PopUpManager;

	public class Main extends WindowedApplication{
		
		public var imageWindow:ImageWindow;
		public var menuBar:MenuBar;
		public var fileTree:FileSystemTree;
		public var request:HttpRESTService;
		public var splash:Splashscreen;
		public var mainWindow:NativeWindow;
		public var batchWindow:BatchJobComponent;
		private var _imageFiles:ArrayCollection;
		
		
		public function Main(){
			
		}
		
		public function boot():void {
			mainWindow = this.nativeWindow;
			mainWindow.visible = false;
			splash = new Splashscreen();
			splash = PopUpManager.createPopUp(this,Splashscreen, true) as Splashscreen;
			splash.x = (Capabilities.screenResolutionX - splash.width) / 2;
			splash.y = (Capabilities.screenResolutionY - splash.height) / 2;
			var splashTimer:Timer = new Timer(1000, 3);
			splashTimer.addEventListener(TimerEvent.TIMER_COMPLETE, init);
			splashTimer.start();
		}
		
		public function init(event:TimerEvent):void{
			PopUpManager.removePopUp(splash);
			mainWindow.visible = true;
			this.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER,onDragEnter);
			this.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP,onDrop);
			menuBar.addEventListener(MenuEvent.ITEM_CLICK, menuItemClickHandler);
			ServiceManager.getInstance().updateFilterList();
		}
		
		private function menuItemClickHandler(event:MenuEvent):void{
			var id:String = event.item.@id;
			switch(id) {
				case "menuOpen": 
					var fileExplorer:FileExplorer = new FileExplorer();
					fileExplorer.openFile();
					break;
				case "menuSave": 
					ApplicationManager.getInstance().saveImage();
					break;
				case "menuClose":
					ApplicationManager.getInstance().closeApplication();
					break;
				case "menuAbout":
					splash = PopUpManager.createPopUp(this,Splashscreen, true) as Splashscreen;
					PopUpManager.centerPopUp(splash);
					break;
				default:
					break;
			}
		}
		
		/*
		 * FILE OPEN
		 */
		public function onDragEnter(event:NativeDragEvent):void{
			NativeDragManager.acceptDragDrop(this);
		}
		public function onDrop(event:NativeDragEvent):void{
			
			var pattern:RegExp = /jpg|jpeg|JPG|gif|png/;
			var dropfiles:Array = event.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			if(dropfiles[0] != null && pattern.test(dropfiles[0].extension) && dropfiles.length == 1){
				ApplicationManager.getInstance().setImage(dropfiles[0]);
			}else if (dropfiles != null && dropfiles.length>0){
				_imageFiles = new ArrayCollection();
				processDroppedFiles(dropfiles);
				batchWindow = PopUpManager.createPopUp(this, BatchJobComponent, true) as BatchJobComponent;
				PopUpManager.centerPopUp(batchWindow);
			}else{
				Alert.show("File format not supported.");
			}
		}
		
		private function processDroppedFiles(dropfiles:Array):void {
			
			var pattern:RegExp = /jpg|jpeg|JPG|gif|png/;
			
			for each (var file:File in dropfiles) {
				if (file.isDirectory) {
					processDroppedFiles(file.getDirectoryListing());
				} else {
					if (pattern.test(file.extension)) {
						_imageFiles.addItem(file);
					}
				}
			}
			ApplicationManager.getInstance().batchFiles = _imageFiles;
		}
	}
		
}
