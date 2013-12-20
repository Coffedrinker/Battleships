package 
{
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.net.URLRequest;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Jacob
	 */
	
	 /**TODO LIST
	  * TODO: sänka skepp : Done
	  * TODO: fler skepptyper : in progress
	  * TODO: minska outnyttjat område : in progress
	  * TODO: 4x2 ; 3x3 ; 2x4 ; 1x5 ; Antal x storlek : in progress
	  * TODO:
	  */
	 
	public class Main extends Sprite 
	{
		
		
		
		
		
		public var score:int = 0;
		public var misses:int = 0;
		public var scoreBoard:TextField = new TextField;
		public var battleField:Vector.<Vector.<Tile>> = new Vector.<Vector.<Tile>>; // the vector that functions as the gamemap
		private var settingShips:Boolean = true;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			scoreBoard.x = 600;
			scoreBoard.y = 100;
			
			scoreBoard.text = "Hits:" + String(score) + "\nMisses:" + String(misses);
			
			addChild(scoreBoard);
			
			setGameBoard();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
		}
		
		private function keyDownHandler(e:KeyboardEvent):void // decided to call it keydownhandler in case I add more keyboard shortcuts
		{
			switch (e.keyCode) 
			{
				case Keyboard.SPACE:
					setGameBoard();
				break;
			}
		}
		
		private function setGameBoard():void 
		{
			if (battleField.length > 0 )
			{
				for each (var line:Vector.<Tile> in battleField) 
				{
					for each (var newTile:Tile in line) 
					{
						removeChild(newTile);
					}
					line = null;
				}
				battleField = null;
			}
			
			battleField = new Vector.<Vector.<Tile>>;
			
			for (var i:int = 0; i < 10; i++) 
			{
				var line:Vector.<Tile> = new Vector.<Tile>;
				for (var j:int = 0; j < 10; j++) 
				{
					var newTile:Tile = new Tile(i,j);
					
					
					newTile.x = 50 + i * (newTile.TILESIZE + 5);
					newTile.y = 50 + j * (newTile.TILESIZE + 5);
					
					newTile.addEventListener(MouseEvent.CLICK, onMouseClick);
					
					addChild(newTile);
					line.push(newTile);
				}
				battleField.push(line);
			}
			score = 0;
			misses = 0;
			
			scoreBoard.text = "Hits:" + String(score) + "\nMisses:" + String(misses);
			
			for (var k:int = 0; k < 4; k++) // Hides 10 ships on the battlefield
			{
				switch (k) //Controls which ship is added 
				{
					case 0 : // 4 ships 2 tiles long
						for (var l:int = 0; l < 4 ; l++) 
						{
							var shipX:int = new int;
							var shipY:int = new int;
							
							if (Math.round(Math.random()) == 1) //The direction the ship is facing 1 is right 0 is down
							{
								settingShips = true;
								while (settingShips) 
								{
										
									shipX = Math.round(Math.random() * 8);
									shipY = Math.round(Math.random() * 9);
									
									if (battleField[shipX][shipY].state != "hiddenShip" && battleField[shipX+1][shipY].state != "hiddenShip" )
									{
										for (var m:int = 0; m < 2; m++) 
										{
											battleField[shipX + m][shipY].state = "hiddenShip";
											battleField[shipX + m][shipY].bombIt();
										}
										settingShips = false;
									}
								}
								
							}
							else
							{
								settingShips = true;

								while (settingShips) 
								{
										
									shipX = Math.round(Math.random() * 9);
									shipY = Math.round(Math.random() * 8);
									
									if (battleField[shipX][shipY].state != "hiddenShip" && battleField[shipX][shipY +1].state != "hiddenShip" )
									{
										for (var m:int = 0; m < 2; m++) 
										{
											battleField[shipX][shipY + m].state = "hiddenShip";
											battleField[shipX][shipY + m].bombIt();
										}
										settingShips = false;
									}
								}
								
							}
						}
					break;
					
					case 1:
						for (var l:int = 0; l < 3 ; l++) 
						{
							var shipX:int = new int;
							var shipY:int = new int;
							
							if (Math.round(Math.random()) == 1) //The direction the ship is facing 1 is right 0 is down
							{
								settingShips = true;
								while (settingShips) 
								{
										
									shipX = Math.round(Math.random() * 7);
									shipY = Math.round(Math.random() * 9);
									
									if (battleField[shipX][shipY].state != "hiddenShip" && battleField[shipX+1][shipY].state != "hiddenShip" && battleField[shipX+2][shipY].state != "hiddenShip" )
									{
										for (var m:int = 0; m < 3; m++) 
										{
											battleField[shipX + m][shipY].state = "hiddenShip";
											battleField[shipX + m][shipY].bombIt();
										}
										settingShips = false;
									}
								}
								
							}
							else
							{
								settingShips = true;

								while (settingShips) 
								{
										
									shipX = Math.round(Math.random() * 9);
									shipY = Math.round(Math.random() * 7);
									
									if (battleField[shipX][shipY].state != "hiddenShip" && battleField[shipX][shipY+1].state != "hiddenShip" && battleField[shipX][shipY+2].state != "hiddenShip"  )
									{
										for (var m:int = 0; m < 3; m++) 
										{
											battleField[shipX][shipY + m].state = "hiddenShip";
											battleField[shipX][shipY + m].bombIt();
										}
										settingShips = false;
									}
								}
								
							}
						}
					break;
					default:
				}
			}
		}
		public function onMouseClick(m:MouseEvent):void 
		{
			trace(m.target.xCoord);
			trace(m.target.yCoord);
			trace(m.target.state);
			
			if (m.target.state == "water")
			{
				m.target.bombIt();
				misses++;	
			}
			if (m.target.state == "hiddenShip")
			{
				m.target.bombIt();
				score++;
			}
			scoreBoard.text = "Hits:" + String(score) + "\nMisses:" + String(misses);
		}
	}
}