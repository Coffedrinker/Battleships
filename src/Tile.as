package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author Jacob
	 */
	public class Tile extends Sprite
	{
		public const TILESIZE:int = 48;
		
		[Embed(source = "../lib/HitTile.png")] private var Hit:Class;
		private var hitImage:Bitmap = new Hit;
		[Embed(source = "../lib/MissTile.png")] private var Miss:Class;
		private var missImage:Bitmap = new Miss;
		[Embed(source = "../lib/WaterTile.png")] private var Water:Class
		private var waterImage:Bitmap = new Water;
		
		public var xCoord:int;
		public var yCoord:int;
		public var state:String = new String; // state handles what happens when a tile's bombIt function is activated
		
		public function Tile(xCoord:int, yCoord:int, state:String = "water") 
		{
			this.graphics.beginBitmapFill(waterImage.bitmapData);
			this.graphics.drawRect(0, 0, TILESIZE, TILESIZE);
			
			this.xCoord = xCoord;
			this.yCoord = yCoord;
			
			this.state = state;
		}
		
		public function bombIt():void //Handles what happens when you click on a tile
		{
			
			if (this.state == "water")
			{
				this.state = "splash";
				
				this.addChild(missImage);
			}
			if (this.state == "hiddenShip")
			{
				this.state = "debris";
				
				this.addChild(hitImage);
			}
		}
	}
}