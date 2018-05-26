// tinybox
// qdyBHædyIåKeMUsVfb4aJEvéag2adZaZaZa3bcgm3fcäaäa2bai2ceāaāaāaāa5bjfn4b2adZaZaZa3bcgm3fcäaäa2bai2ceāaāaāaāa5bfjn4bdabcbfbe2caim3dgYaàaäaãaāaāa6cacegko6bdZaZaZa3bcgm3fcäaäa2bai2ceāaāaāaāa5bfjn4bdhbfbeb3caei3dfèaåaäaàaāa5cacegk5bdZaZaZa3bcgm3fcäaäa2bai2ceāaāaāaāa5bfjn4becbebfbcb4caeim4dgYaàaäaãaéaéa6cacegko6bdZaZaZa3bcgm3fcäaäa2bai2ceāaāaāaāa5bfjn5babeadièaåaäaāaèaāaèaāa3c5bcegijklm8bdZaZaZa3bcgm3fcäaäa2bai2ceāaāaāaāa5bfjn4b

class MainScene {

	public var winkel:Float=0;

	public var langl:Float=50;
	public var langumfang:Float=20;

	public var kurzl:Float=15;
	public var kurzumfang:Float=10;

	public var tl:Float;
	public var tuf:Float;

	public var radius:Float=20;

	public var geschwindkeit:Float=360*1.5;
	public var fps:Float=30;

	public var bulletjeder:Int=6;
	public var bulletgeschwindigkeit:Float=3;
	
	public var bulleti:Int=0;
	
	public var gegnerjeder:Int=10;
	public var gegnerjederi:Int=0;
	public var gegnergeschwindigkeit:Int=1;

	public var bullets : Array<Float>; //x,y,dx,dy
	public var gegners : Array<Float>; //x,y,dx,dy
	public var score:Int;
	
	function reset(){
		init();
	}
	
	function init(){
		haxegon.Sound.play("music",0,true);
		score = 0;
		winkel = 90;
		bullets = [];
		gegners = [];
		bulleti=0;
		tl=kurzl;
		tuf=kurzumfang;

		gegnerjeder=10;
		gegnerjederi=0;

	}	 

	static inline function dot(ax:Float,ay:Float,bx:Float,by:Float):Float {
		return ax*bx+ay*by;
	}
	static inline function distance(ax:Float,ay:Float,bx:Float,by:Float):Float {
		var dx = ax-bx;
		var dy = ay-by;
		return Math.sqrt(dx*dx+dy*dy);
	}

	static inline function minimum_distance(vx:Float,vy:Float, wx:Float,wy:Float, px:Float, py:Float):Float {
		var dx=vx-wx;
		var dy=vy-wy;
		var l2 = dx*dx+dy*dy;

		if (l2 == 0.0) return distance(px,py, vx,vy);   // v == w case
		// Consider the line extending the segment, parameterized as v + t (w - v).
		// We find projection of point p onto the line. 
		// It falls where t = [(p-v) . (w-v)] / |w-v|^2
		// We clamp t from [0,1] to handle points outside the segment vw.
		var t:Float = Math.max(0, Math.min(1, dot(px - vx,py-vy, wx - vx,wy-vy) / l2));
		var projectionx:Float = vx + t * (wx - vx);  // Projection falls on the segment
		var projectiony:Float = vy + t * (wy - vy);  // Projection falls on the segment
		return distance(px,py, projectionx,projectiony);
	}

	function gameOver(){
		GameOver.score=score;
		haxegon.Sound.stop("music",1.0);
		Scene.change(GameOver);
	}

	function update() {	
		var v:Float = 0;
		if (Input.pressed(Key.LEFT)){
			v-=geschwindkeit/fps;
		}
		if (haxegon.Input.pressed(Key.RIGHT)){
			v+=geschwindkeit/fps;
		}
		winkel+=v;
		

		var w = Gfx.screenwidth;
		var h = Gfx.screenheight;
		
		var cx = Gfx.screenwidthmid;
		var cy = Gfx.screenheightmid;
	
		var mx = cx+30*Math.cos(winkel*Math.PI/180);//haxegon.Mouse.x;
		var my = cy+30*Math.sin(winkel*Math.PI/180);//haxegon.Mouse.y;

		var dx = mx-cx;
		var dy = my-cy;


		var pl = langl;
		var pw = langumfang;
		
		var a = Math.atan2(dy,dx);
		var ad = 180*a/Math.PI;
		var kurz=false;


		gegnerjederi++;
		if (gegnerjederi>=gegnerjeder){
			gegnerjederi=0;

			var randa:Float=Random.float(0,2*Math.PI);
			var rx = Math.cos(randa);
			var ry = Math.sin(randa);

			gegners.push(cx+rx*cx);
			gegners.push(cy+ry*cx);
			gegners.push(-rx*gegnergeschwindigkeit);
			gegners.push(-ry*gegnergeschwindigkeit);	
			trace("spawn gegner");		
		}

	

		var crita=55;
		var critdx=Math.sin(55*Math.PI/180);
		var critdy=Math.cos(55*Math.PI/180);

		if (ad < (-90-crita)  || ad > (-90+crita)){
			pl = kurzl;
			pw = kurzumfang;
			kurz=true;
		} 

		var s = Math.sqrt(dx*dx+dy*dy);

		var ndx = dx/s;
		var ndy = dy/s;

		Gfx.clearscreen();

		Gfx.linethickness=1;

		Gfx.drawline(cx,cy,cx-critdx*cx,cy-critdy*cx,Col.GRAY);
		Gfx.drawline(cx,cy,cx+critdx*cx,cy-critdy*cx,Col.GRAY);

		Gfx.fillcircle(cx,cy+5,radius,Col.DARKBROWN);
		Gfx.drawcircle(cx,cy,cx,Col.GRAY);
		//Gfx.drawcircle(cx,cy+5,radius,Col.GRAY);

		var gegnerrad=4;
		var bulletrad=2;
		
		var i=0;
		while(i<gegners.length){
			var gx = gegners[i];
			var gy = gegners[i+1];
			var gdx = gegners[i+2];
			var gdy = gegners[i+3];
			gx+=gdx;
			gy+=gdy;
			gegners[i]=gx;
			gegners[i+1]=gy;
			trace(gx,gy);
			var odistx = gx-cx;
			var odisty = gy-cy;

			var odist_sq = odistx*odistx+odisty*odisty;

			Gfx.fillbox(gegners[i]-4,gegners[i+1]-4,9,9,Col.RED);


			var sdx = gx-cx;
			var sdy = gy-cy-5;

			if ( sdx*sdx+sdy*sdy <= radius*radius ) {
				gameOver();				
			}

			i+=4;			

		}


		var pdx = tl*dx/s;
		var pdy = tl*dy/s;

		var i=0;
		Gfx.linethickness=tuf;
		if (kurz){
			var d = (tl-kurzl) / (langl-kurzl);
			var mx = cx+pdx*(0.5+d/2);
			var my = cy+pdy*(0.5+d/2);
			var tx = cx+pdx;
			var ty = cy+pdy;
			Gfx.drawline(cx,cy,mx,my,Col.BROWN);
			Gfx.linethickness=tuf/2;
			Gfx.drawline(mx,my,tx,ty,Col.BROWN);

			bulleti++;
			if (bulleti>bulletjeder){
				bulleti=0;
				var bx = tx;
				var by = ty;
				var bdx = ndx*bulletgeschwindigkeit*Math.log(3+score/10);
				var bdy = ndy*bulletgeschwindigkeit*Math.log(3+score/10);
				haxegon.Sound.play("schiess",0,false,0.3);
				bullets.push(bx);
				bullets.push(by);
				bullets.push(bdx);
				bullets.push(bdy);
			}
		} else {
			var tx=cx+pdx;
			var ty=cy+pdy;
			Gfx.drawline(cx,cy,tx,ty,Col.BROWN);

			var j=0;
			while (j<gegners.length){
				var gx = gegners[j];
				var gy = gegners[j+1];
				if (minimum_distance(cx,cy,tx,ty,gx,gy)<=tuf){
					gegners.splice(j,4);
					haxegon.Sound.play("hit",0,false,0.5);
					score++;
					j-=4;
				}
				j+=4;
			}
		}

		Gfx.linethickness=1;
		if (bullets.length>0){
			i=0;
			while(i<bullets.length){
				var bx = bullets[i];
				var by = bullets[i+1];
				var bdx = bullets[i+2];
				var bdy = bullets[i+3];
				bx+=bdx;
				by+=bdy;
				bullets[i]=bx;
				bullets[i+1]=by;
				Gfx.fillbox(bullets[i]-2,bullets[i+1]-2,5,5,Col.YELLOW);

				var j=0;
				while (j<gegners.length){
					var gx = gegners[j];
					var gy = gegners[j+1];
					var adx = Math.abs(gx-bx);
					var ady = Math.abs(gy-by);
					if (adx<7 && ady<7){
						gegners.splice(j,4);
						score++;
						j-=4;
					}
					j+=4;
				}
				
				i+=4;				
			}
			
			{
				var bx = bullets[0];
				var by = bullets[1];
				var bdx=bx-cx;
				var bdy=by-cy;
				if (bdx*bdx+bdy*bdy>cx*cx){
					bullets.splice(0,4);
				}				
			}

		}

		tl = 0.5*tl+0.5*pl;
		tuf = 0.5*tuf+0.5*pw;
		Text.display(2,2,score,Col.WHITE);
	}
}
