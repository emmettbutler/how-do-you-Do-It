package
{
    import org.flixel.*;

    public class MomLeavingState extends TimedState{
        [Embed(source = "../assets/bgm.mp3")] private var SndBGM:Class;
        [Embed(source = "../assets/dooropen.mp3")] private var doorOpen:Class;
        [Embed(source = "../assets/doorclose.mp3")] private var doorClose:Class;
        [Embed(source = "../assets/garageopen.mp3")] private var garageOpen:Class;
        [Embed(source = "../assets/cardoor.mp3")] private var carDoor:Class;
        [Embed(source = "../assets/carleave.mp3")] private var carLeave:Class;
        [Embed(source = "../assets/mom1.png")] private var mom:Class;
        [Embed(source = "../assets/house.png")] private var house:Class;
        [Embed(source = "../assets/girl1.png")] private var girl1:Class;
        [Embed(source = "../assets/girl2.png")] private var girl2:Class;
        [Embed(source = "../assets/girl3.png")] private var girl3:Class;
        [Embed(source = "../assets/dolls.png")] private var dolls:Class;
        [Embed(source = "../assets/car.png")] private var car:Class;
        [Embed(source = "../assets/outside.png")] private var outside:Class;
        public var mom_sprite:FlxSprite;
        public var girl1_sprite:FlxSprite;
        public var scene_time:Number = 3;
        public var current_scene:Number = 1;
        public var cameraTrack:FlxSprite;
        public var cam_moving:Boolean = false;
        public var cam_target_point:FlxPoint;
        public var car_sprite:FlxSprite;
        public var girl2_sprite:FlxSprite;
        public var girl3_sprite:FlxSprite;
        public var dolls_sprite:FlxSprite;
        public var girlAnimLock:Boolean = false;

        public var nextState:FlxState;
        public var time_frame:Number = 0;

        public function MomLeavingState(next:FlxState) {
            super();
            this.nextState = next;
        }

        override public function create():void
        {
            endTime = 12;

            cam_target_point = new FlxPoint(FlxG.width/2,FlxG.height/2);

            cameraTrack = new FlxSprite(FlxG.width/2,FlxG.height/2);
            cameraTrack.visible = false;
            add(cameraTrack);
            FlxG.camera.target = cameraTrack;

            var outside_bg:FlxSprite = new FlxSprite(0, 0);
            outside_bg.loadGraphic(outside, true, true, 600, 185, true);
            add(outside_bg);
            outside_bg.scrollFactor = new FlxPoint(.5, .5);

            car_sprite = new FlxSprite(300, 69);
            car_sprite.loadGraphic(car, true, true, 104, 54, true);
            car_sprite.alpha = 0;
            add(car_sprite);

            var house_bg:FlxSprite = new FlxSprite(0, 0);
            house_bg.loadGraphic(house, true, true, 1500/2, 360, true);
            house_bg.addAnimation("closed", [0], 1, false);
            house_bg.addAnimation("open", [1], 1, false);
            add(house_bg);

            mom_sprite = new FlxSprite(22, 49);
            mom_sprite.loadGraphic(mom, true, true, 77, 151, true);
            add(mom_sprite);

            girl1_sprite = new FlxSprite(110, 98);
            girl1_sprite.loadGraphic(girl1, true, true, 44, 121, true);
            add(girl1_sprite);

            girl2_sprite = new FlxSprite(293, 82);
            girl2_sprite.loadGraphic(girl2, true, true, 216/4, 99, true);
            girl2_sprite.addAnimation("run", [0,1,2,3], 10, false);
            girl2_sprite.alpha = 0;
            add(girl2_sprite);

            girl3_sprite = new FlxSprite(525, 174);
            girl3_sprite.loadGraphic(girl3, true, true, 60, 101, true);
            girl3_sprite.alpha = 0;
            add(girl3_sprite);

            dolls_sprite = new FlxSprite(598, 178);
            dolls_sprite.loadGraphic(dolls, true, true, 76, 55, true);
            dolls_sprite.alpha = 0;
            add(dolls_sprite);

            if(FlxG.music == null){
                FlxG.playMusic(SndBGM, ggj.VOLUME);
            } else {
                FlxG.music.resume();
                if(!FlxG.music.active){
                    FlxG.playMusic(SndBGM, ggj.VOLUME);
                }
            }
        }

        override public function update():void
        {
            super.update();
            time_frame++;
            if(time_frame == 50){
                FlxG.play(doorOpen);
            } else if(time_frame == 150){
                FlxG.play(doorClose);
            } else if(time_frame == 200){
                FlxG.play(garageOpen);
            } else if(time_frame == 300){
                FlxG.play(carDoor);
            } else if(time_frame == 400){
                FlxG.play(carLeave);
            }

            if((timeFrame/100)%3 == 0){
                current_scene++;
                if(current_scene == 2){
                    cam_moving = true;
                    cam_target_point = new FlxPoint(176+(FlxG.width/2),FlxG.height/2);
                }
                if(current_scene == 3){
                    cam_moving = true;
                    cam_target_point = new FlxPoint(389+(FlxG.width/2),52+FlxG.height/2);
                }
            }

            if(Math.abs(cameraTrack.x - cam_target_point.x) < 10 && Math.abs(cameraTrack.y - cam_target_point.y) < 10){
                cam_moving = false;
                if(current_scene == 2){
                    car_sprite.alpha += .02;
                    girl2_sprite.alpha += .02;
                    if(!girlAnimLock && girl2_sprite.alpha >= 1){
                        girl2_sprite.play("run");
                        girlAnimLock = true;
                    }
                }
                if(current_scene == 3){
                    dolls_sprite.alpha += .02;
                    girl3_sprite.alpha += .02;
                }
            } else {
                cameraTrack.velocity.x = cam_target_point.x - cameraTrack.x;
                cameraTrack.velocity.y = cam_target_point.y - cameraTrack.y;
            }

            if(current_scene == 2){
                girl1_sprite.alpha -= .02;
                mom_sprite.alpha -= .02;
            }
            if(current_scene == 3){
                girl2_sprite.alpha -= .02;
                car_sprite.alpha -= .02;
            }
        }

        override public function endCallback():void {
            FlxG.switchState(nextState);
        }
    }
}
