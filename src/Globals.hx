

class Globals
{

  public static var PAL = {
      fg : Col.WHITE,   
      bg : Col.BLACK,
      
      fgDisabled : Col.GRAY,

      bghighlight : 0x999999,

      buttonTextCol : Col.WHITE,
      buttonBorderCol : Col.WHITE,
      buttonCol : Col.BLACK,
      buttonHighlightCol : 0x444444,
      buttonHighlightCol2 : 0xcccccc,
      titelFarbe: Col.RED,

      giltFarb: Col.GREEN,
      schlechtFarb: Col.RED,
  };

  public static var GUI = {
      smalltextsize:1,
      textsize:1,
      buttonTextSize:2,
      buttonPaddingX : 40,
      buttonPaddingY : 5,
      linethickness : 2,
      slimlinethickness : 2,
      thicklinethickness : 10,
      titleTextSize:3,
      subTitleTextSize:4,
      vpadding:10,
      healthbarheight:20,
    subSubTitleTextSize:60,

    portraitsize:80,
      
      screenPaddingTop:30,
      
      font:"GermaniaOne-Regular",
  };

  public static var state = {
      sprache:0,
      auserwaehlte:0,
      ort:0,
      owd:null,
      tx:-1,
      ty:-1,
      dyn:null
  };

  public static function S(de:String,en:String):String{
      if (state.sprache==0){
          return de;
      } else {
        return en;
      }
  }

}