package de.rutscheschobel.shareyourfilter.main
{
	import de.rutscheschobel.shareyourfilter.event.JPEGAsyncCompleteEvent;
	import de.rutscheschobel.shareyourfilter.util.JPEGAsyncEncoder;
	import de.rutscheschobel.shareyourfilter.view.ImageWindow;
	import de.rutscheschobel.shareyourfilter.view.components.ProgressBox;
	
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import mx.managers.PopUpManager;

	public class ApplicationManager{
		
		private var _imageWindow:ImageWindow;
		private var _imageFile:File;
		private var _bitmap:Bitmap;
		private var _colorTransform:ColorTransform;
		private var _fileReference:FileReference = new FileReference();
		private var _encoder:JPEGAsyncEncoder;
		
		public function ApplicationManager(){
		}
		
		private static var instance:ApplicationManager = null;
		public static function getInstance():ApplicationManager {
			if (ApplicationManager.instance == null) {
				ApplicationManager.instance = new ApplicationManager();
			}
			return ApplicationManager.instance;
		}
		
		public function get imageWindow():ImageWindow{
			if(_imageFile != null){
				PopUpManager.removePopUp(_imageWindow);
				_imageWindow = new ImageWindow(_imageFile.nativePath);	
			}			
			return _imageWindow;
		}

		public function get bitmap():Bitmap{
			return _bitmap;
		}

		public function set bitmap(value:Bitmap):void{
			_bitmap = value;
		}

		public function get imageFile():File{
			return _imageFile;
		}

		public function set imageFile(value:File):void{
			_imageFile = value;
		}
		
		public function get colorTransform():ColorTransform	{
			return _colorTransform;
		}
		
		public function set colorTransform(value:ColorTransform):void {
			_colorTransform = value;
		}
		
		public function get encoder():JPEGAsyncEncoder {
			return _encoder;
		}

		public function saveImage():void{
			var bitmapData:BitmapData = new BitmapData(_bitmap.bitmapData.width, _bitmap.bitmapData.height);
			bitmapData.draw(_bitmap,new Matrix(), _bitmap.transform.colorTransform);
			var bitmap : Bitmap = new Bitmap(bitmapData);
			
			_encoder = new JPEGAsyncEncoder(90);
			_encoder.PixelsPerIteration = 800;
			_encoder.addEventListener(JPEGAsyncCompleteEvent.JPEGASYNC_COMPLETE, onEncodeDone);
			_encoder.encode(bitmapData);
			
		}
		
		private function onEncodeDone(event:JPEGAsyncCompleteEvent):void {
			trace("encoding complete");
			var ba:ByteArray = event.ImageData;
			_fileReference.save(ba,"untitled.jpg");
		}
	}
}