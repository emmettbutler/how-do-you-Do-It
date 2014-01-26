package{
    import org.flixel.*;
    [SWF(width="640", height="480", backgroundColor="#000000")]
    [Frame(factoryClass="Preloader")]

    public class ggj extends FlxGame{
        public static const VOLUME:Number = .4;

        public function ggj(){
            super(320,240,MenuState,2);
        }
    }
}
