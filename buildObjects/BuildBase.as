package buildObjects 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	
	public class BuildBase extends FlxSprite
	{
		//Variable to recognize if it's and UI item and can be build
		protected var UI:Boolean;
		public var canBuild:Boolean;
		
		//set source of the select sound
		[Embed(source = "../sounds/select.mp3")] protected var selectSnd:Class;
		
		public function BuildBase(X:int, Y:int, UIitem:Boolean, buildable:Boolean = true, solid:Boolean = true) 
		{
			if (!UIitem)
			{
				if (Y < 0)
				{
					Y = 0;
				}
				else if (Y > FlxG.height - 160 - 64)
				{
					Y = FlxG.height - 160 - 64;
				}
				
				if (X < 0)
				{
					X = 0;
				}
				else if (X > FlxG.width - 64)
				{
					X = FlxG.width - 64;
				}
			}
			
			super(X, Y);
			
			//store if this is a UI item and can be build
			this.UI = UIitem;
			this.canBuild = buildable;
			
			this.immovable = solid;
		}
		
		override public function update():void 
		{
			super.update();
			
			//show the right image
			if (this.canBuild)
			{
				this.play("build");
			}
			else
			{
				this.play("noBuild");
			}
			
			//check if the mouse button has been clicked
			isClicked();
		}
		
		protected function isClicked():Boolean
		{
			//The player is dragging the home after clicking on it in the user bar
			//Return whether the player is clicking on the object or not
			return (FlxG.mouse.justPressed() && hover() && this.UI && this.canBuild);
		}
		
		private function hover():Boolean
		{
			//check if the mouse is over the object when clicked
			var mx:int = FlxG.mouse.screenX;
			var my:int = FlxG.mouse.screenY;
			return ( (mx > this.x) && (mx < this.x + this.width) ) && ( (my > this.y) && (my < this.y + this.height) );
		}
		
		public function changeBuild(TF:Boolean):void
		{
			this.canBuild = TF;
		}
	}
}