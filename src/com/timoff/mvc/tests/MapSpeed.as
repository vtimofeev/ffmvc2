package com.timoff.mvc.tests
{
	import flash.display.*;
	import flash.utils.*;
	import flash.text.*;

	/**
	*   An app to test the speed of various maps
	*   @author Jackson Dunstan
	*/
	public class MapSpeed extends Sprite
	{
		public function MapSpeed()
		{
			var logger:TextField = new TextField();
			logger.autoSize = TextFieldAutoSize.LEFT;
			addChild(logger);
			function log(msg:*): void { logger.appendText(msg + "\n"); }

 			var array:Array = [33];

 			var vectorDynamic:Vector.<int> = new Vector.<int>(1, false);
 			vectorDynamic[0] = 33;

 			var vectorFixed:Vector.<int> = new Vector.<int>(1, true);
 			vectorFixed[0] = 33;

			var object:Object = {val:33};

			var dictionaryStrong:Dictionary = new Dictionary(false);
			dictionaryStrong.val = 33;

			var dictionaryWeak:Dictionary = new Dictionary(true);
			dictionaryWeak.val = 33;

			var bitmapDataNoAlpha:BitmapData = new BitmapData(1, 1, false);

			var bitmapDataAlpha:BitmapData = new BitmapData(1, 1, true);

			var byteArray:ByteArray = new ByteArray();
			byteArray.writeByte(33);

			const NUM_ITERATIONS:int = 1000000;
			var i:int;
			var beforeTime:int;

			log("Hit:");

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				array[0];
			}
			log("\tArray: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				vectorDynamic[0];
			}
			log("\tVector Dynamic: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				vectorFixed[0];
			}
			log("\tVector Fixed: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				object.val;
			}
			log("\tObject: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				dictionaryStrong.val;
			}
			log("\tDictionary Strong: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				dictionaryWeak.val;
			}
			log("\tDictionary Weak: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				bitmapDataNoAlpha.getPixel(0, 0);
			}
			log("\tBitmapData no alpha, getPixel: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				bitmapDataNoAlpha.getPixel32(0, 0);
			}
			log("\tBitmapData no alpha, getPixel32: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				bitmapDataAlpha.getPixel(0, 0);
			}
			log("\tBitmapData alpha, getPixel: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				bitmapDataAlpha.getPixel32(0, 0);
			}
			log("\tBitmapData alpha, getPixel32: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				byteArray[0];
			}
			log("\tByteArray: " + (getTimer()-beforeTime));

			log("Miss:");

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				try
				{
                    array[2];
				}
				catch (err:Error)
				{
				}

			}
			log("\tArray: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				try
				{
					vectorDynamic[2];
				}
				catch (err:Error)
				{
				}
			}
			log("\tVector Dynamic: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				try
				{
					vectorFixed[2];
				}
				catch (err:Error)
				{
				}
			}
			log("\tVector Fixed: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				object.val2;
			}
			log("\tObject: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				dictionaryStrong.val2;
			}
			log("\tDictionary Strong: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				dictionaryWeak.val2;
			}
			log("\tDictionary Weak: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				bitmapDataNoAlpha.getPixel(1, 1);
			}
			log("\tBitmapData no alpha, getPixel: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				bitmapDataNoAlpha.getPixel32(1, 1);
			}
			log("\tBitmapData no alpha, getPixel32: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				bitmapDataAlpha.getPixel(1, 1);
			}
			log("\tBitmapData alpha, getPixel: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				bitmapDataAlpha.getPixel32(1, 1);
			}
			log("\tBitmapData alpha, getPixel32: " + (getTimer()-beforeTime));

			beforeTime = getTimer();
			for (i = 0; i < NUM_ITERATIONS; ++i)
			{
				byteArray[2];
			}
			log("\tByteArray: " + (getTimer()-beforeTime));
		}
	}
}