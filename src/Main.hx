class Main {

	function reset(){
		init();
	}
	
	private var score:Int;
	function init(){
		//initial all globals here

		if (Save.exists("highscore")){
			score = Save.loadvalue("highscore");
		} else {
			score=0;
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
		Text.display(Text.CENTER,h/5+10,S("Schwung","Schwung"), 0x0000ff);
		Text.size=1;
		Text.display(10,10,S("HIGHSCORE ","HIGHSCORE ")+ score, Col.WHITE);

		if (IMGUI.button( Text.CENTER,Math.round(h/3+20),S("Fang an!","Start!"))
				|| haxegon.Input.justpressed(Key.SPACE) || haxegon.Input.justpressed(Key.ENTER) || haxegon.Input.justpressed(Key.X)   ){

			Scene.change(MainScene);
		}

		if (IMGUI.schalter( Text.CENTER,Math.round(h/3+60),
		S("deu","deu"),
		S("eng","eng"),
		1-state.sprache)){
			state.sprache=1-state.sprache;
			Save.savevalue("language",state.sprache);
		}

		
	}
}
