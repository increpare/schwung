import haxegon.*;

typedef TearCoord = {
	var x:Float;
	var y:Float;
    var leben:Float;
}

@:access(haxegon.Core)
@:access(haxegon.Gfx)
class Traenen {

    public static var bild : String;
    public static var scale : Float = 0.6;
    public static var geschwindigkeit : Float = 5.0;
    public static var tempo : Float = 5.0;

    private static var particles:Array<TearCoord>;
    private static var spawnpoints:Array<TearCoord>;
    
    private static var counter:Float=0;

    public static function enable(){
        particles = [];
        spawnpoints = [];
        Core.registerplugin("teardrops", "0.1.0");
        Core.extend_endframe(render);
    }    

    public static function clear() {
        particles.splice(0,particles.length);
        spawnpoints.splice(0,spawnpoints.length);
    }

    public static function AddPoint(x:Float,y:Float,leben:Float){
        spawnpoints.push({x:x,y:y,leben:leben});
    }

    private static function spawnNewPoint(){
        var sp = Random.pick(spawnpoints);
        particles.push( {
            x:sp.x+Random.int(-3,3),
            y:sp.y+Random.int(-3,3),
            leben:sp.leben*Random.float(0.9,1.1)
        });
    }

    private static function render(){
        if (spawnpoints.length==0&&particles.length==0){
            return;
        }

        var fps = Core.fps;
        var delta=1/fps;        
        
        counter+=delta;

        if (counter>1/tempo){
            spawnNewPoint();
            counter=0;
        }

        var i:Int = particles.length-1;
        while(i>=0){
            var p = particles[i];
            Gfx.scale(scale);
            p.y+=geschwindigkeit;
            p.x+=Random.int(-1,1);
            p.leben-=delta;
            if (p.leben<=0){
                particles.splice(i,1);               
            }
            Gfx.drawimage(p.x,p.y,bild);
            i--;
        }

        Gfx.scale(1);
        Gfx.rotation(0);     
    }
}