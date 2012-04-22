package buildObjects 
{
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxDelay;
	
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	
	public class CreatureBuild extends BuildBase
	{
		//Timers to delay several things
		private var walkTimer:FlxDelay = new FlxDelay(1000);
		protected var healthTimer:FlxDelay = new FlxDelay(10000);
		
		//indicator for if the health has to be altered
		public var changeHealth:Boolean = false;
		
		public function CreatureBuild(X:int, Y:int, UIitem:Boolean, buildable:Boolean = true) 
		{
			super(X, Y, UIitem, buildable, false);
			
			this.health = 100;
			
			this.walkTimer.start();
			this.healthTimer.start();
		}
		
		override public function update():void 
		{
			super.update();
			
			move();
			
			if (!this.UI && this.healthTimer.hasExpired)
			{
				this.changeHealth = true;
			}
			
			if (this.health <= 0)
			{
				this.kill();
			}
		}
		
		private function move():void
		{
			//The human can only walk if it's not an UI item and the timer has expired
			if (!this.UI && this.walkTimer.hasExpired)
			{
				//create and store a random number between 0 and 5
				var r:int = FlxG.random() * 5;
				
				//Move the player accordingly witht the random result
				switch(r)
				{
					case 1:
						this.y -= 32;
						break;
					case 2:
						this.y += 32;
						break;
					case 3:
						this.x -= 32;
						break;
					case 4:
						this.x += 32;
						break;
					case 0:
					default:
						break;
				}
				
				checkBoundaries();
				
				//reset the timer
				this.walkTimer = new FlxDelay(1000);
				this.walkTimer.start();
			}
		}
		
		private function checkBoundaries():void
		{
			if (this.y + this.height <= 0)
			{
				this.y = FlxG.height - (this.height / 2) - 160;
			}
			else if (this.y >= FlxG.height - 160)
			{
				this.y = -32;
			}
			else if (this.x + this.width <= 0)
			{
				this.x = FlxG.width - (this.width / 2);
			}
			else if (this.x >= FlxG.width)
			{
				this.x = -32;
			}
		}
		
		public function resetTimer():void
		{
			this.changeHealth = false;
			
			this.healthTimer = new FlxDelay(10000);
			this.healthTimer.start();
		}
	}
}