package buildObjects 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	
	public class Tree extends BuildBase
	{
		//set the source of the home image
		[Embed(source = "../images/buildObjects/tree.png")] private var treeImg:Class;
		
		public function Tree(X:int, Y:int, buildable:Boolean = true, UIitem:Boolean = false) 
		{
			//set the initial position of the home
			super(X, Y, UIitem, buildable);
			
			//load the sprite
			this.loadGraphic(treeImg, true, false, 64, 64);
			
			//create the images
			this.addAnimation("build", [0], 0, false);
			this.addAnimation("noBuild", [1], 0, false);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (this.isClicked())
			{
				Registry.UserDrags = "tree";
				FlxG.play(selectSnd);
			}
		}
	}
}