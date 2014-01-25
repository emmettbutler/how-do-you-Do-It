package
{
    import org.flixel.*;

    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Joints.*;

    public class PhysicsDoll
    {
        public var m_world:b2World;
        public var m_physScale:Number = 30
        public var midriff:b2Body;

        public function create(_world:b2World, start:FlxPoint):void
        {
            m_world = _world;

            var circ:b2CircleShape;
            var box:b2PolygonShape;
            var bd:b2BodyDef = new b2BodyDef();
            var jd:b2RevoluteJointDef = new b2RevoluteJointDef();
            var fixtureDef:b2FixtureDef = new b2FixtureDef();
            var startX:Number = start.x;
            var startY:Number = start.y;

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
            midriff = torso2;
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

        public function update():void
        {

        }
    }

}
