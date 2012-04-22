package buildObjects 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	
	public class Shelter extends BuildBase
	{
		//set the source of the home image
		[Embed(source = "../images/buildObjects/shelter.png")] private var shelterImg:Class;
		
		public function Shelter(X:int, Y:int, buildable:Boolean = true, UIitem:Boolean = false) 
		{
			//set the initial position of the shelter
			super(X, Y, UIitem, buildable);
			
			//load the sprite
			this.loadGraphic(shelterImg, true, false, 64, 64);
			
			//create the images
			this.addAnimation("build", [0], 0, false);
			this.addAnimation("noBuild", [1], 0, false);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (this.isClicked())
			{
				Registry.UserDrags = "shelter";
				FlxG.play(selectSnd);
			}
		}
	}

}