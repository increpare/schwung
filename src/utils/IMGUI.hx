package utils;

class IMGUI {

	public static function schalter(x,y,text1,text2,selection:Int) {
		var oldtextsize=Text.size;
		Text.size = GUI.buttonTextSize;
		
	  var textcolor =PAL.buttonTextCol;
	  var color = PAL.buttonCol;
	  var colorhover = PAL.buttonHighlightCol;
	  var colorhover2:Int = PAL.buttonHighlightCol2;
	  var borderCol = PAL.buttonBorderCol;
	  var lightbgcol = PAL.buttonTextCol;
	  var linethickness=GUI.linethickness;
	  var xpadding = GUI.buttonPaddingX;
	  var ypadding = GUI.buttonPaddingY;

	  Gfx.linethickness=linethickness;

	  var width=39;
	  var w1 = Math.round(Text.width(text1));
	  var w2 = Math.round(Text.width(text1));
	  var w = w1+w2+xpadding*2;
	  if (w+6>=width){
	  	width=w+6;
	  }
	  width+=xpadding*2;

	  var height=Math.round(Math.max(Text.height(text1),Text.height(text2)));
	  if (x==Text.CENTER){
		  x=Math.round(Gfx.screenwidthmid-width/2);
	  }
	  height+=ypadding*2;

	  var dx = Mouse.x-x;
	  var dy = Mouse.y-y;

	  var collide = !(dx<0||dx>=width||dy<0||dy>=height);

	  var click = collide && Mouse.leftclick();

	  if (collide){
	    color=colorhover;
		lightbgcol = colorhover2;
	  }
	  Gfx.fillbox(x,y,width,height,color);
	  if (selection==1){
		  Gfx.fillbox(x,y,w1+2*xpadding,height,lightbgcol);
	  } else {
		  Gfx.fillbox(x+w1+2*xpadding,y,x+width-(x+w1+2*xpadding),height,lightbgcol);
	  }

	  Gfx.drawbox(x,y,width,height,borderCol);

	  Text.display(x+xpadding, y+ypadding, text1, selection==0?textcolor:PAL.buttonCol);
	  Text.display(x+xpadding+w1+xpadding*2, y+ypadding,text2,selection==1?textcolor:PAL.buttonCol);

	  Text.size=oldtextsize;

	  return click;
	}


	public static function kleineSchaltflaeche(x:Float,y:Float,w:Float,h:Float,text:String,disabled:Bool) {
		var oldtextsize=Text.size;
		Text.size = GUI.smalltextsize;
		
		var textcolor =PAL.buttonTextCol;
		var color = PAL.buttonCol;
		var colorhover = PAL.buttonHighlightCol;
		var borderCol = PAL.buttonBorderCol;

		var linethickness=GUI.slimlinethickness;
		var xpadding = GUI.buttonPaddingX;
		var ypadding = GUI.buttonPaddingY;

		Gfx.linethickness=linethickness;
		
		var dx = Mouse.x-x;
		var dy = Mouse.y-y;

		var collide = !(dx<0||dx>=w||dy<0||dy>=w);

		var click = collide && Mouse.leftclick();

		if (disabled){
			click=false;
			borderCol=PAL.fgDisabled;
			textcolor=PAL.fgDisabled;
		}		

		if (collide&& !click){
			color=colorhover;
		}

		Gfx.fillbox(x,y,w,h,color);
		Gfx.drawbox(x,y,w,h,borderCol);

		Text.display(x+3, y+3, text, textcolor);
		Text.size=oldtextsize;

		return click;
	}

	public static function button(x,y,text) {
		var oldtextsize=Text.size;
		Text.size = GUI.buttonTextSize;
		
	  var textcolor =PAL.buttonTextCol;
	  var color = PAL.buttonCol;
	  var colorhover = PAL.buttonHighlightCol;
	  var borderCol = PAL.buttonBorderCol;

	  var linethickness=GUI.linethickness;
	  var xpadding = GUI.buttonPaddingX;
	  var ypadding = GUI.buttonPaddingY;

	  Gfx.linethickness=linethickness;

	  var width=39;
	  var w = Math.round(Text.width(text));
	  if (w+6>=width){
	  	width=w+6;
	  }
	  width+=xpadding*2;

	  var height=Math.round(Text.height(text));
	  if (x==Text.CENTER){
		  x=Math.round(Gfx.screenwidthmid-width/2);
	  }
	  height+=ypadding*2;

	  var dx = Mouse.x-x;
	  var dy = Mouse.y-y;

	  var collide = !(dx<0||dx>=width||dy<0||dy>=height);

	  var click = collide && Mouse.leftclick();

	  if (collide&& !click){
	    color=colorhover;
	  }

	  Gfx.fillbox(x,y,width,height,color);
	  Gfx.drawbox(x,y,width,height,borderCol);

	  Text.display(x+xpadding, y+ypadding, text, textcolor);
	  Text.size=oldtextsize;

	  return click;
	}


	public static function selectedbutton(x,y,text) {
		var oldtextsize=Text.size;
		Text.size = GUI.buttonTextSize;
		
	  var textcolor =PAL.buttonTextCol;
	  var color = PAL.buttonCol;
	//   var colorhover = PAL.buttonHighlightCol;
	  var borderCol = PAL.buttonBorderCol;

	  var linethickness=GUI.linethickness;
	  var xpadding = GUI.buttonPaddingX;
	  var ypadding = GUI.buttonPaddingY;

	  Gfx.linethickness=linethickness;

	  var width=39;
	  var w = Math.round(Text.width(text));
	  if (w+6>=width){
	  	width=w+6;
	  }
	  width+=xpadding*2;

	  var height=Math.round(Text.height(text));
	  if (x==Text.CENTER){
		  x=Math.round(Gfx.screenwidthmid-width/2);
	  }
	  height+=ypadding*2;

	  var dx = Mouse.x-x;
	  var dy = Mouse.y-y;

	  var collide = !(dx<0||dx>=width||dy<0||dy>=height);

	  var click = collide && Mouse.leftclick();

	  if (collide&& !click){
	    //color=colorhover;
	  }

	  Gfx.fillbox(x,y,width,height,textcolor);
	  Gfx.drawbox(x,y,width,height,borderCol);

	  Text.display(x+xpadding, y+ypadding, text, color);
	  Text.size=oldtextsize;

	  return click;
	}

	public static function Bildbutton(x:Int,y:Int,bild:String,an:Bool,scale:Float) {
		var oldtextsize=Text.size;
		Text.size = GUI.buttonTextSize;
		
	//   var textcolor =PAL.buttonTextCol;
	  var color = PAL.buttonCol;
	  var colorhover = PAL.buttonHighlightCol;
	  var borderCol = PAL.buttonBorderCol;

	  var linethickness=GUI.linethickness;
	//  var xpadding = GUI.buttonPaddingX;
	//   var ypadding = GUI.buttonPaddingY;

	  Gfx.linethickness=linethickness;

	  var width = Gfx.imagewidth(bild)*scale;

	  var height=Gfx.imageheight(bild)*scale;

	  Gfx.scale(scale,scale);
	  if (x==Text.CENTER){
		  x=Math.round(Gfx.screenwidthmid-width/2);
	  }

	  var dx = Mouse.x-x;
	  var dy = Mouse.y-y;

	  var collide = !(dx<0||dx>=width||dy<0||dy>=height);

	  var click = collide && Mouse.leftclick();

	var alpha=1.0;
	  if ( collide && !click ){
		  if (!an){
	    	color=colorhover;
			alpha=0.6;
		  }
	  }

	  Gfx.fillbox(x,y,width,height,color);
	  Gfx.imagealpha=alpha;
	  Gfx.drawimage(x,y,bild);
	  Gfx.drawbox(x,y,width,height,borderCol);
	  
	  Gfx.imagealpha=1.0;
	  Text.size=oldtextsize;

	  Gfx.scale();
	  return click;
	}
}