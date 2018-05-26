class GameOver {

	function reset(){
		init();
	}
	
	public static var score=0;
	var maxscore:Int;
	var highscore:Bool;
	function init(){
		haxegon.Sound.play("explode",0,false,0.5);
		highscore=false;

		//initial all globals here
		if (Save.exists("highscore")){
			maxscore = Save.loadvalue("highscore");
			if (maxscore<score){
				maxscore=score;
				highscore=true;
				Save.savevalue("highscore",maxscore);
			}
		} else {
				maxscore=score;
				highscore=true;
				Save.savevalue("highscore",maxscore);
		}

		state.sprache = Save.loadvalue("language");
		if (state.sprache==0){
			state.sprache=0;//ok does't do much			
		}	
	}	

	function update() {	
		var h = Gfx.screenheight;
		var w = Gfx.screenwidth;
		Text.wordwrap=w;

		Text.size=GUI.titleTextSize;
		Text.display(Text.CENTER,h/5+10,S("TOT","DEAD"), 0x0000ff);
		
		Text.size=3;

		Text.display(Text.CENTER,h/5+50,score, Col.WHITE);
		if (highscore)
		{
			Text.display(Text.CENTER,h/5+80,S("Neuer Highscore!","New Highscore!"), Col.WHITE);
		}

		if (IMGUI.button( Text.CENTER,Math.round(h/3+70),S("Fang an!","Start!")) 
		|| haxegon.Input.justpressed(Key.SPACE) || haxegon.Input.justpressed(Key.ENTER) || haxegon.Input.justpressed(Key.X)   ){
			Scene.change(MainScene);
		}


		
	}
}
