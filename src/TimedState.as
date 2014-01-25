package {
    import org.flixel.*;

    public class TimedState extends FlxState {
        public var timeFrame:Number = 0;
        public var timeSec:Number = 0;
        public var endTime:Number = 30;

        override public function update():void{
            super.update();
            timeFrame++;

            if(timeFrame%100 == 0){
                timeSec++;
            }

            if(timeSec == this.endTime) {
                this.endCallback();
            }
        }

        public function endCallback():void{}
    }
}