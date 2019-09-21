package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.utils.setTimeout;
	import caurina.transitions.Tweener;
	import flash.utils.Timer;
	import flash.events.TimerEvent;


	public class Main extends MovieClip
	{
		private var bg_mc:MovieClip;
		private var level_mc:MovieClip;
		private var my_Array:Array = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32'];
		private var draw_Array:Array = [];
		private var countlevel:Number = 0;
		private var board_mc:MovieClip;
		private var whichLevel:Number = 1;
		private var storeValue:String;

		private var instructon_mc:MovieClip;
		private var sound_mc:MovieClip;
		private var coinbox_mc:MovieClip;
		private var gameover_mc:MovieClip;
		public var timer:Timer;
		private var gameScore:Number = 0;


		public function Main()
		{
			trace('Bismillah...');
			bg_mc= new Bg();
			this.addChild(bg_mc);



			board_mc= new boardclass();
			board_mc.x = 120;
			board_mc.y = 200;
			this.addChild(board_mc);
			board_mc.visible = false;

			//ablout the game
			instructon_mc=new instructionClass();
			instructon_mc.x = 300;
			instructon_mc.y = 200;
			addChild(instructon_mc);
			instructon_mc.visible = false;
			//instruction the game
			sound_mc=new soundoptionClass();
			sound_mc.x = 300;
			sound_mc.y = 200;
			addChild(sound_mc);
			sound_mc.visible = false;

			coinbox_mc=new levelcompleteClass();
			coinbox_mc.x = 300;
			coinbox_mc.y = 200;
			addChild(coinbox_mc);
			coinbox_mc.visible = false;

			gameover_mc=new gameoverClass();
			gameover_mc.x = 300;
			gameover_mc.y = 200;
			addChild(gameover_mc);
			gameover_mc.visible = false;
			
			



			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, updateTimeHandler);



			bg_mc.clock.visible = false;
			bg_mc.txt_time.visible = false;
			bg_mc.hello.visible = false;
			bg_mc.txtscore.visible = false;



			bg_mc.btngo.addEventListener(MouseEvent.CLICK,handlemouseEvent);
			bg_mc.btn_instruction.addEventListener(MouseEvent.CLICK,handleInstruction);
			bg_mc.btn_sound.addEventListener(MouseEvent.CLICK,handleSound);

			instructon_mc.ok_button.addEventListener(MouseEvent.CLICK,handleOkbutton);
			sound_mc.ok_button.addEventListener(MouseEvent.CLICK,handleOkbutton);
			gameover_mc.ok_button.addEventListener(MouseEvent.CLICK,handleOkbutton);
		}
		//ok_button;

		private function handlemouseEvent(e:MouseEvent):void
		{

			timer.start();
			hidemainboard();
			drawPanel();

		}
		private function drawPanel():void
		{
			var randvalue:int = rnd(3,31);
			var heightin:Number = 90;
			var checkLength:Number = 0;
			var incrementHeight:Number = 0;

			storeValue = my_Array[randvalue];

			for (var i:int=0; i<my_Array.length; i++)
			{
				if (whichLevel==1)
				{
					level_mc=new level1Class();
				}
				else if (whichLevel==2)
				{
					level_mc=new level2Class();
				}
				else if (whichLevel==3)
				{
					level_mc=new level3Class();

				}
				else if (whichLevel==4)
				{
					level_mc=new level4Class();
				}
				else if (whichLevel==5)
				{
					level_mc=new level5Class();
				}
				else if (whichLevel==6)
				{
					level_mc=new level6Class();
				}
				else if (whichLevel==7)
				{
					level_mc=new level7Class();

				}
				else
				{
					gameover_mc.visible = true;
					board_mc.visible = false;
					bg_mc.clock.visible = false;
					bg_mc.txt_time.visible = false;
					bg_mc.txtscore.visible=false;
					bg_mc.hello.visible = false;
					bg_mc.gamescoreboad.visible = false;
					bg_mc.txt_score.visible = false;
					
					break;
				}


				//level_mc=new showpanelclass();
				level_mc.txt.text = my_Array[i];
				board_mc.addChild(level_mc);
				if (checkLength==8)
				{
					incrementHeight +=  heightin;
					checkLength = 0;
				}
				level_mc.x=(checkLength*(level_mc.width+10))+52;
				level_mc.y = incrementHeight + 10;
				checkLength++;

				if (level_mc.txt.text == storeValue)
				{
					level_mc.alpha = 0.5;
				}

				draw_Array.push(level_mc);
				level_mc.addEventListener(MouseEvent.CLICK,mousehandler);

			}

		}

		private function mousehandler(e:MouseEvent):void
		{
			var targetLevel:MovieClip;

			if (whichLevel==1)
			{
				targetLevel = e.currentTarget as level1Class;

			}
			else if (whichLevel==2)
			{
				targetLevel = e.currentTarget as level2Class;
			}
			else if (whichLevel==3)
			{
				targetLevel = e.currentTarget as level3Class;
			}
			else if (whichLevel==4)
			{
				targetLevel = e.currentTarget as level4Class;
			}
			else if (whichLevel==5)
			{
				targetLevel = e.currentTarget as level5Class;
			}
			else if (whichLevel==6)
			{
				targetLevel = e.currentTarget as level6Class;
			}
			else if (whichLevel==7)
			{
				targetLevel = e.currentTarget as level7Class;

			}

			if (targetLevel.txt.text == storeValue)
			{
				coinbox_mc.visible = true;
				gameScore +=  5;
				bg_mc.hello.text = String(gameScore);
				shownext();

			}
			else
			{

				targetLevel.filters = [new GlowFilter  ];
				Tweener.addTween(targetLevel, {
				x:targetLevel.x + 15,
				time: 0.5
				});
				Tweener.addTween(targetLevel, {
				x:targetLevel.x,
				time: 0.1,
				delay: 0.5
				});

				if (gameScore<=0)
				{
					bg_mc.hello.text = String(0);

				}
				else
				{
					gameScore -=  3;
					bg_mc.hello.text = String(gameScore);
				}


			}
		}
		private function hidemainboard():void
		{
			bg_mc.btngo.visible = false;
			bg_mc.game_title.visible = false;
			bg_mc.btn_instruction.visible = false;
			bg_mc.btn_sound.visible = false;
			board_mc.visible = true;
			bg_mc.clock.visible = true;
			bg_mc.txt_time.visible = true;
			bg_mc.hello.visible = true;
			bg_mc.txtscore.visible=true;


		}
		private function shownext():void
		{
			setTimeout(function(){
			 
			nextLevel();
			
			   },2000);
		}

		private function nextLevel():void
		{
			removequize();
			bg_mc.txt_time.text = 0;
			timer.reset();
			timer.start();
		}

		private function removequize():void
		{
			for (var i:int=0; i<draw_Array.length; i++)
			{
				var myarray:MovieClip = draw_Array[i] as MovieClip;
				myarray.parent.removeChild(myarray);
				draw_Array.splice(i,1);
				i--;
			}
			whichLevel +=  1;
			coinbox_mc.visible = false;
			drawPanel();

		}

		private function handleInstruction(e:MouseEvent):void
		{
			bg_mc.btngo.visible = false;
			bg_mc.game_title.visible = false;
			board_mc.visible = false;
			instructon_mc.visible = true;


		}
		private function handleSound(e:MouseEvent):void
		{
			bg_mc.btngo.visible = false;
			bg_mc.game_title.visible = false;
			board_mc.visible = false;
			sound_mc.visible = true;
		}
		private function handleOkbutton(e:MouseEvent):void
		{
			bg_mc.btngo.visible = true;
			bg_mc.game_title.visible = true;
			board_mc.visible = false;
			sound_mc.visible = false;
			instructon_mc.visible = false;
			gameover_mc.visible = false;

		}


		private function rnd(min: Number, max: Number):Number
		{
			var randomNum: Number = Math.floor(Math.random() * (max - min + 1)) + min;
			return randomNum;
		}
		public function updateTimeHandler(event:TimerEvent):void
		{

			bg_mc.txt_time.text = String(timer.currentCount);
			if (timer.currentCount == 10)
			{
				bg_mc.txt_time.text = String(0);
				timer.stop();
			}
		}
	}


}