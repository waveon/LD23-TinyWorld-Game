package buildObjects 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	
	public class Well extends BuildBase
	{
		//set the source of the home image
		[Embed(source = "../images/buildObjects/well.png")] private var wellImg:Class;
		
		public function Well(X:int, Y:int, buildable:Boolean = true, UIitem:Boolean = false) 
		{
			//set the initial position of the home
			super(X, Y, UIitem, buildable);
			
			//load the sprite
			this.loadGraphic(wellImg, true, false, 64, 64);
			
			//create the images
			this.addAnimation("build", [0], 0, false);
			this.addAnimation("noBuild", [1], 0, false);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (this.isClicked())
			{
				Registry.UserDrags = "well";
				FlxG.play(selectSnd);
			}
		}
	}
}