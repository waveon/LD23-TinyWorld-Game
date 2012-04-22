package  
{
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	public class Registry 
	{
		//variable to store if the user is dragging a build object
		public static var UserDrags:String = "nothing";
		
		//Clear the variables so they can be destroyed properly
		public static function destroy():void
		{
			UserDrags = null;
		}
	}
}