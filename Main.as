package 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	
	//Set the background color and dimension of the screen
	[SWF(width = "800", height = "800", backgroundColor = "#888888")]
	 
	public class Main extends FlxGame 
	{
		public function Main():void 
		{
			//Set the size of the game and go to the PlayState
			super(800, 800, Title, 1, 60, 30, true);
		}
	}
}