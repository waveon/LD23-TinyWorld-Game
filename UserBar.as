package
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	
	public class UserBar extends FlxSprite
	{
		//set the source of the UI bar image
		[Embed(source = "images/UI_bar.png")] private var UBarImg:Class;
	
		public function UserBar(X:int, Y:int) 
		{
			//set the initial position of the user bar
			super(X, Y);
			
			//load the sprite
			this.loadGraphic(UBarImg, false, false, 800, 160);
		}
	}
}