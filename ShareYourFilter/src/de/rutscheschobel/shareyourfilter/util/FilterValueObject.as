package de.rutscheschobel.shareyourfilter.util
{
	public class FilterValueObject
	{
		private var _id:Number;
		private var _name:String;
		private var _brightness:Number ;
		private var _saturation:Number ;
		private var _contrast:Number;
		private var _red:Number;
		private var _green:Number;
		private var _blue:Number;
		private var _negative:Boolean ;
		private var _random:Array;
		
		public function FilterValueObject(name:String = null, id:Number = 0, brightness:Number = 0, saturation:Number = 100, 
			contrast:Number = 50, red:Number = 10, blue:Number = 10, green:Number = 10, negative:Boolean = false, random:Array = null)
		{
			_name = name;
			_id = id;
			_brightness = brightness;
			_saturation = saturation;
			_contrast = contrast;
			_red = red;
			_blue = blue;
			_green = green;
			_negative = negative; 
			_random = random;
		}
		
		
		public function get red():Number
		{
			return _red;
		}
		
		public function set red(value:Number):void
		{
			_red = value;
		}
		
		public function get green():Number
		{
			return _green;
		}
		
		public function set green(value:Number):void
		{
			_green = value;
		}
		
		public function get blue():Number
		{
			return _blue;
		}
		
		public function set blue(value:Number):void
		{
			_blue = value;
		}
		
		public function get brightness():Number
		{
			return _brightness;
		}
		
		public function set brightness(value:Number):void
		{
			_brightness = value;
		}
		
		public function get negative():Boolean
		{
			return _negative;
		}
		
		public function set negative(value:Boolean):void
		{
			_negative = value;
		}
		
		public function get contrast():Number
		{
			return _contrast;
		}
		
		public function set contrast(value:Number):void
		{
			_contrast = value;
		}
		
		public function get saturation():Number
		{
			return _saturation;
		}
		
		public function set saturation(value:Number):void
		{
			_saturation = value;
		}
		
		public function get random():Array
		{
			return _random;
		}
		
		public function set random(value:Array):void
		{
			_random = value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function get id():Number
		{
			return _id;
		}
		
		public function set id(value:Number):void
		{
			_id = value;
		}
		
		public function toString():String {
			return name;
		}
		
		
		
		
	}
}