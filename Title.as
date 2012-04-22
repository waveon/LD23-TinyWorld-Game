package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	public class Title extends FlxState
	{
		//create variables for the texts
		public var startText:FlxText, instructions:FlxText, version:FlxText;
		
		//variable and source for background image
		[Embed(source = "images/title_background.png")] private var bgImg:Class;
		private var background:FlxSprite;
		
		public function Title() 
		{
			//create the background
			background = new FlxSprite(0, 0);
			background.loadGraphic(bgImg, false, false, 800, 800);
			add(background);
			
			//Show the title
			var startText:FlxText = new FlxText(8, 30, 800, "The tiny, unknown and\nunimportant world");
			startText.setFormat(null, 50, 0xffffff, "center");
			add(startText);
			
			//Show instructions
			var instructions:FlxText = new FlxText(FlxG.width / 4 - 20, 250, 450, "Click on an object and then somewhere on the map to build the object\n\nClick to start");
			instructions.setFormat(null, 25, 0xffffff, "center");
			add(instructions);
			
			//Show version
			var version:FlxText = new FlxText(8, FlxG.height - 30, 400, "Version 1.0");
			version.setFormat(null, 15, 0xffffff, "left");
			add(version);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.mouse.justPressed())
			{
				//Fade out before switching to the playState
				FlxG.camera.fade(0x00000000, 1, changeState);
			}
		}
		
		private function changeState():void
		{
			//Switch to PlayState when enter has been pressed, thus starting the game
			FlxG.switchState(new PlayState());
		}
	}

}