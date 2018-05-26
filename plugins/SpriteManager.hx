import haxegon.*;

class Sprite {
    public var name:String;
    public var x:Float;
    public var y:Float;
    public var angle:Float;
    public var scale:Float;
    public var visible:Bool;
    public var alpha:Float;

    public var pivotx:Float;
    public var pivoty:Float;

    public function destroy(){
        SpriteManager.RemoveSprite(this);
    }

    public function new(name:String,x:Float,y:Float){
        this.name=name;
        this.x=x;
        this.y=y;
        this.angle=0;
        this.scale=1;
        this.alpha=1;
        this.visible=true;
        this.pivotx = Gfx.imagewidth(name)/2;
        this.pivoty = Gfx.imageheight(name)/2;
    }
}

@:access(haxegon.Core)
@:access(haxegon.Gfx)
class SpriteManager {

    private static var sprites:Array<Sprite>;

    public static function enable(){
        sprites = [];
        Core.registerplugin("spritemanager", "0.1.0");
       // Core.extend_endframe(render);
    }
    
    public static function clear() {
        sprites.splice(0,sprites.length);
    }

    public static function AddSprite(name:String,x:Float,y:Float):Sprite
    {
        var s:Sprite = new Sprite(name,x,y);
        sprites.push(s);
        return s;        
    }

    public static function RemoveSprite(s:Sprite){
        sprites.remove(s);
    }

    public static function render(){
        for (s in sprites){
            Gfx.imagealpha=s.alpha;
            Gfx.rotation(s.angle,s.pivotx,s.pivoty);
            Gfx.scale(s.scale);
            Gfx.drawimage(s.x,s.y,s.name);            
        }
        Gfx.rotation(0);
        Gfx.scale(1);
        Gfx.imagealpha=1;
    }
}