package
{
    import org.flixel.*;

    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Joints.*;

    import flash.display.*;

    public class PlayState extends TimedState
    {
        [Embed(source = "../assets/bgm.mp3")] private var SndBGM:Class;
        [Embed(source="../assets/girl_body.png")] private var ImgBody:Class;
        [Embed(source="../assets/mainbg.png")] private var ImgBG:Class;

        public var m_physScale:Number = 30
        public var m_world:b2World;
        public var m_mouseJoint:b2MouseJoint;
        public var dollLGrabber:DollGrabber;
        public var dollRGrabber:DollGrabber;
        public var dollL:PhysicsDoll;
        public var dollR:PhysicsDoll;
        public var dollController:DollController;
        public var dollCollision:DollContactListener;
        static public var mouseXWorldPhys:Number;
        static public var mouseYWorldPhys:Number;
        static public var mouseXWorld:Number;
        static public var mouseYWorld:Number;

        public var thinking:ScrollingText;
        public var thinking_two:ScrollingText;
        public var thinking_counter:Number = 0;
        public var bubble_width:Number = FlxG.width/2;
        public var face:Face;
        public var body:FlxSprite;
        public var lArm:Arm;
        public var rArm:Arm;

        public var debugText:FlxText;
        public var started:Boolean;
        public var smoke:FlxSprite;
        public var howText:FlxText;

        override public function create():void
        {
            started = false;

            var bg:FlxSprite = new FlxSprite(0, 0);
            bg.loadGraphic(ImgBG, true, true, 320, 240, true);
            add(bg);

            debugText = new FlxText(10, 30, FlxG.width, "");
            add(debugText);

            setupWorld();

            body = new FlxSprite(-70, 56);
            body.loadGraphic(ImgBody, true, true, 294, 190, true);
            add(body);

            face = new Face(-10, -68);

            thinking = new ScrollingText();
            add(thinking);

            var startY:Number = 200;
            var startX:Number = 170;

            var worldAABB:b2AABB = new b2AABB();
            worldAABB.lowerBound.Set(0, 0);
            worldAABB.upperBound.Set(640 / m_physScale, 480 / m_physScale);

            dollRGrabber = new DollGrabber();
            dollLGrabber = new DollGrabber();

            lArm = new Arm(50, dollLGrabber, false);
            rArm = new Arm(220, dollRGrabber, true);

            var position:FlxPoint = new FlxPoint(startX, startY);
            dollL = new PhysicsDoll();
            dollL.create(m_world, position, PhysicsDoll.ATYPE);
            dollLGrabber.create(dollL, m_world, worldAABB);

            //setup collision listener
            dollCollision = new DollContactListener(face);
            m_world.SetContactListener(dollCollision);

            startX = 510;
            position = new FlxPoint(startX, startY);
            dollR = new PhysicsDoll();
            dollR.create(m_world, position, PhysicsDoll.BTYPE);
            dollRGrabber.create(dollR, m_world, worldAABB);

            dollController = new DollController(dollRGrabber, dollLGrabber, rArm, lArm);

            smoke = new FlxSprite(0, 0);
            smoke.makeGraphic(640, 480);
            smoke.fill(0x55000000);
            add(smoke);

            howText = new FlxText(10, FlxG.height/2, FlxG.width, "WASDQE to play");
            add(howText);

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

            if(timeFrame%100 == 0 && !started){
                endTime++;
            }

            started = dollController.update(endTime - timeSec);

            if (started) {
                thinking.paused = false;
                FlxG.state.remove(smoke);
                FlxG.state.remove(howText);
            }

            UpdateMouseWorld()
            MouseDrag();

            m_world.Step(1.0/30.0, 10, 10);
            //m_world.DrawDebugData();

            dollL.update();
            dollR.update();
            dollLGrabber.update();
            dollRGrabber.update();

            lArm.update();
            rArm.update();

            face.update();

            /*if(thinking.pos_x > bubble_width){
                thinking_counter
                thinking_two = new ScrollingText();
                add(thinking_two);
            }*/
        }

        override public function endCallback():void
        {
            FlxG.switchState(new EndState(dollCollision.sex, dollController.isClose));
        }

        public function UpdateMouseWorld():void{
            mouseXWorldPhys = (FlxG.mouse.screenX)/m_physScale;
            mouseYWorldPhys = (FlxG.mouse.screenY)/m_physScale;
            mouseXWorld = (FlxG.mouse.screenX);
            mouseYWorld = (FlxG.mouse.screenY);
        }

        public function MouseDrag():void{
            // mouse press
            if (FlxG.mouse.pressed() && !m_mouseJoint){

                var body:b2Body = GetBodyAtMouse();

                if (body)
                {
                    var md:b2MouseJointDef = new b2MouseJointDef();
                    md.bodyA = m_world.GetGroundBody();
                    md.bodyB = body;
                    md.target.Set(mouseXWorldPhys, mouseYWorldPhys);
                    md.collideConnected = true;
                    md.maxForce = 300.0 * body.GetMass();
                    m_mouseJoint = m_world.CreateJoint(md) as b2MouseJoint;
                    body.SetAwake(true);
                }
            }

            // mouse release
            if (!FlxG.mouse.pressed()){
                if (m_mouseJoint)
                {
                    m_world.DestroyJoint(m_mouseJoint);
                    m_mouseJoint = null;
                }
            }

            // mouse move
            if (m_mouseJoint)
            {
                var p2:b2Vec2 = new b2Vec2(mouseXWorldPhys, mouseYWorldPhys);
                m_mouseJoint.SetTarget(p2);
            }
        }

        private var mousePVec:b2Vec2 = new b2Vec2();
        public function GetBodyAtMouse(includeStatic:Boolean = false):b2Body {
            // Make a small box.
            mousePVec.Set(mouseXWorldPhys, mouseYWorldPhys);
            var aabb:b2AABB = new b2AABB();
            aabb.lowerBound.Set(mouseXWorldPhys - 0.001, mouseYWorldPhys - 0.001);
            aabb.upperBound.Set(mouseXWorldPhys + 0.001, mouseYWorldPhys + 0.001);
            var body:b2Body = null;
            var fixture:b2Fixture;

            // Query the world for overlapping shapes.
            function GetBodyCallback(fixture:b2Fixture):Boolean
            {
                var shape:b2Shape = fixture.GetShape();
                if (fixture.GetBody().GetType() != b2Body.b2_staticBody || includeStatic)
                {
                    var inside:Boolean = shape.TestPoint(fixture.GetBody().GetTransform(), mousePVec);
                    if (inside)
                    {
                        body = fixture.GetBody();
                        return false;
                    }
                }
                return true;
            }
            m_world.QueryAABB(GetBodyCallback, aabb);
            return body;
        }

        private function setupWorld():void{
            var gravity:b2Vec2 = new b2Vec2(0,9.8);
            m_world = new b2World(gravity,true);

            var dbgDraw:b2DebugDraw = new b2DebugDraw();
            var dbgSprite:Sprite = new Sprite();
            FlxG.stage.addChild(dbgSprite);
            dbgDraw.SetSprite(dbgSprite);
            dbgDraw.SetDrawScale(30.0);
            dbgDraw.SetFillAlpha(0.3);
            dbgDraw.SetLineThickness(1.0);
            dbgDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
            m_world.SetDebugDraw(dbgDraw);

            // Create border of boxes
            var wall:b2PolygonShape= new b2PolygonShape();
            var wallBd:b2BodyDef = new b2BodyDef();
            var wallB:b2Body;

            // Left
            wallBd.position.Set( -95 / m_physScale, 480 / m_physScale / 2);
            wall.SetAsBox(100/m_physScale, 480/m_physScale/2);
            //wallB = m_world.CreateBody(wallBd);
            //wallB.CreateFixture2(wall);
            // Right
            wallBd.position.Set((640 + 95) / m_physScale, 480 / m_physScale / 2);
            //wallB = m_world.CreateBody(wallBd);
            //wallB.CreateFixture2(wall);
            // Top
            wallBd.position.Set(640 / m_physScale / 2, -95 / m_physScale);
            wall.SetAsBox(680/m_physScale/2, 100/m_physScale);
            //wallB = m_world.CreateBody(wallBd);
            //wallB.CreateFixture2(wall);
            // Bottom
            wallBd.position.Set(640 / m_physScale / 2, (480 + 95) / m_physScale);
            //wallB = m_world.CreateBody(wallBd);
            //wallB.CreateFixture2(wall);
        }
    }
}
