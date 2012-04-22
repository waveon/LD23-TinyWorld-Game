package  
{
	//import the needed flixel files
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import org.flixel.plugin.photonstorm.FlxCollision;
	
	//import self created package
	import buildObjects.*;
	
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	
	public class PlayState extends FlxState
	{
		//set the source of the map tiles
		[Embed(source = "images/map_tiles.png")] private var mapTiles:Class;
		
		//set the source of the place sound and background music
		[Embed(source = "sounds/place.mp3")] private var placeSnd:Class;
		[Embed(source = "sounds/BG_music.mp3")] private var bgSnd:Class;
		
		//variable to store the map
		private var map:FlxTilemap;
		
		//flixel groups to seperate the UI and entities
		private var church:FlxGroup = new FlxGroup();
		private var farm:FlxGroup = new FlxGroup();
		private var home:FlxGroup = new FlxGroup();
		private var mine:FlxGroup = new FlxGroup();
		private var shelter:FlxGroup = new FlxGroup();
		private var tree:FlxGroup = new FlxGroup();
		private var well:FlxGroup = new FlxGroup();
		private var human:FlxGroup = new FlxGroup();
		private var kitty:FlxGroup = new FlxGroup();
		private var _UIGroup:FlxGroup = new FlxGroup();
		
		//This handles the weather
		private var weather:Weather;
		
		override public function create():void 
		{
			//set the background color
			FlxG.bgColor = 0x888888;
			
			//create the map and user bar
			createMap();
			
			//add the flixelgroups and its members so they're shown in the right order
			add(church);
			add(farm);
			add(home);
			add(mine);
			add(shelter);
			add(tree);
			add(well);
			add(human);
			add(kitty);
			add(_UIGroup);
			
			//Create the User Bar
			createUserBar();
			
			//create the weather
			weather = new Weather();
			add(weather);
			
			//Start with one human
			human.add(new Human(FlxG.width / 2, FlxG.height / 2));
			
			//play the background sound
			FlxG.playMusic(bgSnd);
		}
		
		private function createMap():void
		{
			//declare an array
			var data:Array = new Array();
			
			//the map has 625 tiles, so run the loop 625 times
			for (var i:int = 0; i <= 500; i++)
			{
				//create a random number from 1 to 4 and put it in the array
				data[i] = (FlxG.random()*2) + 1;
			}
			
			//create the map
			map = new FlxTilemap();
			map.loadMap(FlxTilemap.arrayToCSV(data,25), mapTiles, 32, 32);
			add(map);
		}
		
		private function createUserBar():void
		{
			//create the UI bar itself
			_UIGroup.add(new UserBar(0, FlxG.height - 160));
			
			//create the items on the UI bar
			_UIGroup.add(new Tree((0 * 64) + (1 * 20), (FlxG.height - _UIGroup.members[0].height) + 20, true, true));
			_UIGroup.add(new Farm((1 * 64) + (2 * 20), (FlxG.height - _UIGroup.members[0].height) + 20, true, true));
			_UIGroup.add(new Shelter((2 * 64) + (3 * 20), (FlxG.height - _UIGroup.members[0].height) + 20, false, true));
			_UIGroup.add(new Home((3 * 64) + (4 * 20), (FlxG.height - _UIGroup.members[0].height) + 20, false, true));
			_UIGroup.add(new Mine((4 * 64) + (5 * 20), (FlxG.height - _UIGroup.members[0].height) + 20, false, true));
			_UIGroup.add(new Well((5 * 64) + (6 * 20), (FlxG.height - _UIGroup.members[0].height) + 20, false, true));
			_UIGroup.add(new Church((6 * 64) + (7 * 20), (FlxG.height - _UIGroup.members[0].height) + 20, false, true));
			_UIGroup.add(new Human((7 * 64) + (8 * 20), (FlxG.height - _UIGroup.members[0].height) + 20, false, true));		
			_UIGroup.add(new Kitty((8 * 64) + (9 * 20), (FlxG.height - _UIGroup.members[0].height) + 20, false, true));		
		}
		
		override public function update():void 
		{
			super.update();
			
			//Check if the mouse button is been clicked
			OnClick();
			
			//Check if a build object needs to be (un)locked
			checkUnlocking();
			
			//Stops the collision between the humans and structures
			checkCollision();
			
			//update the health of the humans
			human.members.forEach(updateHealth);
			
			//End the game when no humans are alive
			if (human.countLiving() <= 0)
			{
				endGame();
			}
		}
		
		private function OnClick():void
		{
			//store the position of the mouse in variables
			var mx:int = FlxG.mouse.screenX - 32;
			var my:int = FlxG.mouse.screenY - 32;
			
			//Create the appropriate object if the mouse has been clicked and is not on the user bar
			if (FlxG.mouse.justPressed() && my < FlxG.height - _UIGroup.members[0].height - 32)
			{
				switch(Registry.UserDrags)
				{
					case "human":
						human.add(new Human(mx, my));
						FlxG.play(placeSnd);
						break;
					case "kitty":
						kitty.add(new Kitty(mx, my));
						FlxG.play(placeSnd);
						break;
					case "church":
						church.add(new Church(mx, my));
						FlxG.play(placeSnd);
						break;
					case "farm":
						farm.add(new Farm(mx, my));
						FlxG.play(placeSnd);
						break;
					case "home":
						home.add(new Home(mx, my));
						FlxG.play(placeSnd);
						break;
					case "mine":
						mine.add(new Mine(mx, my));
						FlxG.play(placeSnd);
						break;
					case "shelter":
						shelter.add(new Shelter(mx, my));
						FlxG.play(placeSnd);
						break;
					case "tree":
						tree.add(new Tree(mx, my));
						FlxG.play(placeSnd);
						break;
					case "well":
						well.add(new Well(mx, my));
						FlxG.play(placeSnd);
						break;
					default:
						break;
				}
				
				//The user isn't draggin an object anymore
				Registry.UserDrags = "nothing";
			}
		}
		
		private function checkUnlocking():void
		{
			if (tree.countLiving() >= 1)
			{
				_UIGroup.members[3].changeBuild(true);
			}
			else
			{
				_UIGroup.members[3].changeBuild(false);
			}

			if (tree.countLiving() >= 4 && shelter.countLiving() >= 1)
			{
				_UIGroup.members[4].changeBuild(true);
			}
			else
			{
				_UIGroup.members[4].changeBuild(false);
			}

			if (home.countLiving() >= 1)
			{
				_UIGroup.members[5].changeBuild(true);
			}
			else
			{
				_UIGroup.members[5].changeBuild(false);
			}

			if (home.countLiving() >= 2)
			{
				_UIGroup.members[6].changeBuild(true);
			}
			else
			{
				_UIGroup.members[6].changeBuild(false);
			}

			if (home.countLiving() >= 3 && mine.countLiving() >= 2)
			{
				_UIGroup.members[7].changeBuild(true);
			}
			else
			{
				_UIGroup.members[7].changeBuild(false);
			}

			if (church.countLiving() >= 1)
			{
				_UIGroup.members[8].changeBuild(true);
			}
			else
			{
				_UIGroup.members[8].changeBuild(false);
			}
			
			if (human.countLiving() >= 2)
			{
				_UIGroup.members[9].changeBuild(true);
			}
			else
			{
				_UIGroup.members[9].changeBuild(false);
			}
		}
		
		private function checkCollision():void
		{
			//create a list of all existing structures
			var structureArr:Array = new Array();
			structureArr[0] = church;
			structureArr[1] = home;
			structureArr[2] = mine;
			structureArr[3] = shelter;
			structureArr[4] = tree;
			structureArr[5] = well;
			
			//check if any object collide with each other
			for (var i:int = 0; i < structureArr.length; i++)
			{
				FlxG.collide(human, structureArr[i]);
				FlxG.collide(kitty, structureArr[i]);
				
				for (var j:int = 0; j < structureArr.length; j++)
				{
					FlxG.overlap(structureArr[i], structureArr[j], killStructure);
					FlxG.overlap(farm, structureArr[j], killStructure);
				}
			}
		}
		
		private function killStructure(Building1:BuildBase, Building2:BuildBase):void
		{
			if (FlxCollision.pixelPerfectCheck(Building1, Building2))
			{
				Building1.kill();
			}
		}
		
		private function updateHealth(creature:CreatureBuild, index:int, array:Array):void
		{
			if (creature != null && creature.changeHealth)
			{
				creature.health += calculateDamage();
				creature.resetTimer();
			}
		}
		
		private function calculateDamage():int
		{
			//create a list of all existing structures
			var buildsArr:Array = new Array();
			buildsArr[0] = new Array(2);
			buildsArr[1] = new Array(2);
			buildsArr[2] = new Array(2);
			buildsArr[3] = new Array(2);
			buildsArr[4] = new Array(2);
			buildsArr[5] = new Array(2);
			buildsArr[6] = new Array(2);
			
			buildsArr[0][0] = human.countLiving();
			buildsArr[0][1] = -human.countLiving() * 1;
			buildsArr[1][0] = church.countLiving();
			buildsArr[1][1] = church.countLiving() * 5;
			buildsArr[2][0] = farm.countLiving();
			buildsArr[2][1] = farm.countLiving() * 3;
			buildsArr[3][0] = home.countLiving();
			buildsArr[3][1] = home.countLiving() * 2;
			buildsArr[4][0] = mine.countLiving();
			buildsArr[4][1] = -mine.countLiving() *  5;
			buildsArr[5][0] = shelter.countLiving();
			buildsArr[5][1] = shelter.countLiving() * 1;
			buildsArr[6][0] = well.countLiving();
			buildsArr[6][1] = well.countLiving() + 3;
			
			//create the standard damage
			var damage:int = -10;
			
			//Counter to check how many structures there are
			var structureCount:int;
			
			//calculate the damage
			for (var i:int = 0; i < buildsArr.length; i++)
			{
				if (buildsArr[i][0] >= 0)
				{
					damage += buildsArr[i][1];
					structureCount + buildsArr[i][0];
				}
			}
			
			if (structureCount < human.countLiving())
			{
				damage += -20;
			}
			
			damage += weather.weatherDamage;
			
			return damage;
		}
		
		private function endGame():void
		{
			if (endText == null)
			{
			//Show the game over text
			var endText:FlxText = new FlxText(FlxG.width / 7, FlxG.height / 5, 600, "Game Over!\nAll humans died!\n\nClick to try again");
			endText.setFormat(null, 50, 0xffffff, "center");
			add(endText);
			
			//make sure that the humans can't be build
			_UIGroup.members[8].changeBuild(false);
			}
			//Restart the game when the enter key is pressed
			if (!_UIGroup.members[8].getBuild() && FlxG.mouse.justPressed())
			{
				//Fade out before resetting the state
				FlxG.camera.fade(0x00000000, 1, resetState);
			}
		}
		
		private function resetState():void
		{
			//Reset the PlayState
			FlxG.resetState();
		}
		
		override public function destroy():void
		{
			//override the destroy function so objects in the registry can be destroyed properly
			Registry.destroy();
			
			//continue destroying other objects
			super.destroy();
		}
	}
}