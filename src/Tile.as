package  
{
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
		
		public var xCoord:int;
		public var yCoord:int;
		public var state:String = new String; // state handles what happens when a tile's bombIt function is activated
		
		public function Tile(xCoord:int, yCoord:int, state:String = "water") 
		{
			this.graphics.beginFill(0x0000FF);
			this.graphics.drawRect(0, 0, TILESIZE, TILESIZE);
			this.graphics.endFill();
			
			
			this.xCoord = xCoord;
			this.yCoord = yCoord;
			
			this.state = state;
		}
		
		public function bombIt():void //Handles the determination of what happens when you click on a tile
		{
			
			if (this.state == "water")
			{
				this.state = "splash";
				this.transform.colorTransform = new ColorTransform(1, 0, 0, 1, 255, 0, 0, 0); //PH
			}
			if (this.state == "hiddenShip")
			{
				this.state = "debris";
				this.transform.colorTransform = new ColorTransform(0, 1, 0, 1, 0, 255, 0, 0); //PH
			}
		}
	}
}