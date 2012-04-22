package buildObjects 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	
	public class Human extends CreatureBuild
	{
		//set the source of the home image
		[Embed(source = "../images/buildObjects/human.png")] private var humanImg:Class;
		
		public function Human(X:int, Y:int, buildable:Boolean = true, UIitem:Boolean = false) 
		{
			//set the initial position of the human
			super(X, Y, UIitem, buildable);
			
			//load the sprite
			this.loadGraphic(humanImg, true, false, 64, 64);
			
			//create the images
			this.addAnimation("build", [0], 0, false);
			this.addAnimation("noBuild", [1], 0, false);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (this.isClicked())
			{
				Registry.UserDrags = "human";
				FlxG.play(selectSnd);
			}
		}
		
		public function getBuild():Boolean
		{
			return this.canBuild;
		}
	}
}