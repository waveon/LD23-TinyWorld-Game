package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxDelay;
	
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	
	public class Weather extends FlxSprite
	{
		//set the source of the weather images
		[Embed(source = "images/weathers.png")] private var weatherImg:Class;
		
		//variable for extra damage from weather
		public var weatherDamage:int = 0;
		
		//timer for when the weather may occur
		private var weatherTimer:FlxDelay = new FlxDelay(20000);
		
		public function Weather() 
		{
			//place the weather in the upper-left corner so it covers the whole field
			super(0, 0);
			
			//load the image
			this.loadGraphic(weatherImg, true, false, 800, 640);
			
			//create the animations
			addAnimation("rain", [0, 1, 2], 5, true);
			addAnimation("snow", [3, 4, 5], 5, true);
			
			//make the weather invisible till it's needed
			this.visible = false;
			
			//start the timer
			this.weatherTimer.start();
		}
		
		override public function update():void 
		{
			super.update();
			
			if (this.weatherTimer.hasExpired)
			{
				if (!this.visible)
				{
					startWeather(FlxG.random() * 4);
				}
				else
				{
					stopWeather();
				}
				
				this.weatherTimer = new FlxDelay(20000);
				this.weatherTimer.start();
			}
		}
		
		public function startWeather(weather:int):void
		{
			this.visible = true;
			
			switch(weather)
			{
				case 0:
					this.weatherDamage = -5;
					play("rain");
					break;
				case 1:
					this.weatherDamage = -10;
					play("snow");
					break;
				default:
					this.weatherDamage = 0;
					this.visible = false;
					break;
			}
		}
		
		private function stopWeather():void
		{
			this.visible = false;
			this.weatherDamage = 0;
		}
	}
}