package
{
    import org.flixel.*;

    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Joints.*;

    import flash.display.*;

    public class PlayState extends FlxState
    {
        public var m_world:b2World;
        public var m_physScale:Number = 30
        static public var mouseXWorldPhys:Number;
        static public var mouseYWorldPhys:Number;
        static public var mouseXWorld:Number;
        static public var mouseYWorld:Number;
        public var m_mouseJoint:b2MouseJoint;

        public var debugText:FlxText;

        override public function create():void
        {
            debugText = new FlxText(10, 30, FlxG.width, "");
            add(debugText);

            FlxG.mouse.show();
            setupWorld();

            // Create border of boxes
            var wall:b2PolygonShape= new b2PolygonShape();
            var wallBd:b2BodyDef = new b2BodyDef();
            var wallB:b2Body;

            // Left
            wallBd.position.Set( -95 / m_physScale, 360 / m_physScale / 2);
            wall.SetAsBox(100/m_physScale, 400/m_physScale/2);
            wallB = m_world.CreateBody(wallBd);
            wallB.CreateFixture2(wall);
            // Right
            wallBd.position.Set((640 + 95) / m_physScale, 360 / m_physScale / 2);
            wallB = m_world.CreateBody(wallBd);
            wallB.CreateFixture2(wall);
            // Top
            wallBd.position.Set(640 / m_physScale / 2, -95 / m_physScale);
            wall.SetAsBox(680/m_physScale/2, 100/m_physScale);
            wallB = m_world.CreateBody(wallBd);
            wallB.CreateFixture2(wall);
            // Bottom
            wallBd.position.Set(640 / m_physScale / 2, (360 + 95) / m_physScale);
            wallB = m_world.CreateBody(wallBd);
            wallB.CreateFixture2(wall);

            var circ:b2CircleShape;
            var box:b2PolygonShape;
            var bd:b2BodyDef = new b2BodyDef();
            var jd:b2RevoluteJointDef = new b2RevoluteJointDef();
            var fixtureDef:b2FixtureDef = new b2FixtureDef();

            // Add 5 ragdolls along the top
            for (var i:int = 0; i < 2; i++){
                var startX:Number = 70 + Math.random() * 20 + 480 * i;
                var startY:Number = 20 + Math.random() * 50;

                // BODIES
                // Set these to dynamic bodies
                bd.type = b2Body.b2_dynamicBody;

                // Head
                circ = new b2CircleShape( 12.5 / m_physScale );
                fixtureDef.shape = circ;
                fixtureDef.density = 1.0;
                fixtureDef.friction = 0.4;
                fixtureDef.restitution = 0.3;
                bd.position.Set(startX / m_physScale, startY / m_physScale);
                var head:b2Body = m_world.CreateBody(bd);
                head.CreateFixture(fixtureDef);
                //if (i == 0){
                    head.ApplyImpulse(new b2Vec2(Math.random() * 100 - 50, Math.random() * 100 - 50), head.GetWorldCenter());
                //}

                // Torso1
                box = new b2PolygonShape();
                box.SetAsBox(15 / m_physScale, 10 / m_physScale);
                fixtureDef.shape = box;
                fixtureDef.density = 1.0;
                fixtureDef.friction = 0.4;
                fixtureDef.restitution = 0.1;
                bd.position.Set(startX / m_physScale, (startY + 28) / m_physScale);
                var torso1:b2Body = m_world.CreateBody(bd);
                torso1.CreateFixture(fixtureDef);
                // Torso2
                box = new b2PolygonShape();
                box.SetAsBox(15 / m_physScale, 10 / m_physScale);
                fixtureDef.shape = box;
                bd.position.Set(startX / m_physScale, (startY + 43) / m_physScale);
                var torso2:b2Body = m_world.CreateBody(bd);
                torso2.CreateFixture(fixtureDef);
                // Torso3
                box.SetAsBox(15 / m_physScale, 10 / m_physScale);
                fixtureDef.shape = box;
                bd.position.Set(startX / m_physScale, (startY + 58) / m_physScale);
                var torso3:b2Body = m_world.CreateBody(bd);
                torso3.CreateFixture(fixtureDef);

                // UpperArm
                fixtureDef.density = 1.0;
                fixtureDef.friction = 0.4;
                fixtureDef.restitution = 0.1;
                // L
                box = new b2PolygonShape();
                box.SetAsBox(18 / m_physScale, 6.5 / m_physScale);
                fixtureDef.shape = box;
                bd.position.Set((startX - 30) / m_physScale, (startY + 20) / m_physScale);
                var upperArmL:b2Body = m_world.CreateBody(bd);
                upperArmL.CreateFixture(fixtureDef);
                // R
                box = new b2PolygonShape();
                box.SetAsBox(18 / m_physScale, 6.5 / m_physScale);
                fixtureDef.shape = box;
                bd.position.Set((startX + 30) / m_physScale, (startY + 20) / m_physScale);
                var upperArmR:b2Body = m_world.CreateBody(bd);
                upperArmR.CreateFixture(fixtureDef);

                // LowerArm
                fixtureDef.density = 1.0;
                fixtureDef.friction = 0.4;
                fixtureDef.restitution = 0.1;
                // L
                box = new b2PolygonShape();
                box.SetAsBox(17 / m_physScale, 6 / m_physScale);
                fixtureDef.shape = box;
                bd.position.Set((startX - 57) / m_physScale, (startY + 20) / m_physScale);
                var lowerArmL:b2Body = m_world.CreateBody(bd);
                lowerArmL.CreateFixture(fixtureDef);
                // R
                box = new b2PolygonShape();
                box.SetAsBox(17 / m_physScale, 6 / m_physScale);
                fixtureDef.shape = box;
                bd.position.Set((startX + 57) / m_physScale, (startY + 20) / m_physScale);
                var lowerArmR:b2Body = m_world.CreateBody(bd);
                lowerArmR.CreateFixture(fixtureDef);

                // UpperLeg
                fixtureDef.density = 1.0;
                fixtureDef.friction = 0.4;
                fixtureDef.restitution = 0.1;
                // L
                box = new b2PolygonShape();
                box.SetAsBox(7.5 / m_physScale, 22 / m_physScale);
                fixtureDef.shape = box;
                bd.position.Set((startX - 8) / m_physScale, (startY + 85) / m_physScale);
                var upperLegL:b2Body = m_world.CreateBody(bd);
                upperLegL.CreateFixture(fixtureDef);
                // R
                box = new b2PolygonShape();
                box.SetAsBox(7.5 / m_physScale, 22 / m_physScale);
                fixtureDef.shape = box;
                bd.position.Set((startX + 8) / m_physScale, (startY + 85) / m_physScale);
                var upperLegR:b2Body = m_world.CreateBody(bd);
                upperLegR.CreateFixture(fixtureDef);

                // LowerLeg
                fixtureDef.density = 1.0;
                fixtureDef.friction = 0.4;
                fixtureDef.restitution = 0.1;
                // L
                box = new b2PolygonShape();
                box.SetAsBox(6 / m_physScale, 20 / m_physScale);
                fixtureDef.shape = box;
                bd.position.Set((startX - 8) / m_physScale, (startY + 120) / m_physScale);
                var lowerLegL:b2Body = m_world.CreateBody(bd);
                lowerLegL.CreateFixture(fixtureDef);
                // R
                box = new b2PolygonShape();
                box.SetAsBox(6 / m_physScale, 20 / m_physScale);
                fixtureDef.shape = box;
                bd.position.Set((startX + 8) / m_physScale, (startY + 120) / m_physScale);
                var lowerLegR:b2Body = m_world.CreateBody(bd);
                lowerLegR.CreateFixture(fixtureDef);


                // JOINTS
                jd.enableLimit = true;

                // Head to shoulders
                jd.lowerAngle = -40 / (180/Math.PI);
                jd.upperAngle = 40 / (180/Math.PI);
                jd.Initialize(torso1, head, new b2Vec2(startX / m_physScale, (startY + 15) / m_physScale));
                m_world.CreateJoint(jd);

                // Upper arm to shoulders
                // L
                jd.lowerAngle = -85 / (180/Math.PI);
                jd.upperAngle = 130 / (180/Math.PI);
                jd.Initialize(torso1, upperArmL, new b2Vec2((startX - 18) / m_physScale, (startY + 20) / m_physScale));
                m_world.CreateJoint(jd);
                // R
                jd.lowerAngle = -130 / (180/Math.PI);
                jd.upperAngle = 85 / (180/Math.PI);
                jd.Initialize(torso1, upperArmR, new b2Vec2((startX + 18) / m_physScale, (startY + 20) / m_physScale));
                m_world.CreateJoint(jd);

                // Lower arm to upper arm
                // L
                jd.lowerAngle = -130 / (180/Math.PI);
                jd.upperAngle = 10 / (180/Math.PI);
                jd.Initialize(upperArmL, lowerArmL, new b2Vec2((startX - 45) / m_physScale, (startY + 20) / m_physScale));
                m_world.CreateJoint(jd);
                // R
                jd.lowerAngle = -10 / (180/Math.PI);
                jd.upperAngle = 130 / (180/Math.PI);
                jd.Initialize(upperArmR, lowerArmR, new b2Vec2((startX + 45) / m_physScale, (startY + 20) / m_physScale));
                m_world.CreateJoint(jd);

                // Shoulders/stomach
                jd.lowerAngle = -15 / (180/Math.PI);
                jd.upperAngle = 15 / (180/Math.PI);
                jd.Initialize(torso1, torso2, new b2Vec2(startX / m_physScale, (startY + 35) / m_physScale));
                m_world.CreateJoint(jd);
                // Stomach/hips
                jd.Initialize(torso2, torso3, new b2Vec2(startX / m_physScale, (startY + 50) / m_physScale));
                m_world.CreateJoint(jd);

                // Torso to upper leg
                // L
                jd.lowerAngle = -25 / (180/Math.PI);
                jd.upperAngle = 45 / (180/Math.PI);
                jd.Initialize(torso3, upperLegL, new b2Vec2((startX - 8) / m_physScale, (startY + 72) / m_physScale));
                m_world.CreateJoint(jd);
                // R
                jd.lowerAngle = -45 / (180/Math.PI);
                jd.upperAngle = 25 / (180/Math.PI);
                jd.Initialize(torso3, upperLegR, new b2Vec2((startX + 8) / m_physScale, (startY + 72) / m_physScale));
                m_world.CreateJoint(jd);

                // Upper leg to lower leg
                // L
                jd.lowerAngle = -25 / (180/Math.PI);
                jd.upperAngle = 115 / (180/Math.PI);
                jd.Initialize(upperLegL, lowerLegL, new b2Vec2((startX - 8) / m_physScale, (startY + 105) / m_physScale));
                m_world.CreateJoint(jd);
                // R
                jd.lowerAngle = -115 / (180/Math.PI);
                jd.upperAngle = 25 / (180/Math.PI);
                jd.Initialize(upperLegR, lowerLegR, new b2Vec2((startX + 8) / m_physScale, (startY + 105) / m_physScale));
                m_world.CreateJoint(jd);
            }
        }

        override public function update():void
        {
            UpdateMouseWorld()
            MouseDrag();

            m_world.Step(1.0/30.0, 10, 10);
            m_world.DrawDebugData();

            debugText.text = mouseXWorldPhys + " x " + mouseYWorldPhys;
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

                debugText.text = "in MouseDrag";

                if (body)
                {
                    debugText.text = "got body";
                    var md:b2MouseJointDef = new b2MouseJointDef();
                    md.bodyA = m_world.GetGroundBody();
                    md.bodyB = body;
                    md.target.Set(mouseXWorldPhys, mouseYWorldPhys);
                    md.collideConnected = true;
                    md.maxForce = 300.0 * body.GetMass();
                    m_mouseJoint = m_world.CreateJoint(md) as b2MouseJoint;
                    body.SetAwake(true);
                } else {
                    debugText.text = "no body";
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
        }
    }
}
