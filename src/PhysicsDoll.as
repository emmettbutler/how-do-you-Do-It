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
        public var legType:Number;

        private const LEGSPACING:Number = 10;

        public static const ATYPE:Number = 0;
        public static const BTYPE:Number = 1;

        private const LEGAMASK:uint = 0x0002;
        private const LEGACAT:uint  = 0x0002;
        private const LEGBMASK:uint = 0x0004;
        private const LEGBCAT:uint  = 0x0004;
        private const TORSOMASK:uint  = 0xFFFF;
        private const TORSOCAT:uint  = 0x0010;
        private const ARMMASK:uint  = 0xFFFF;
        private const ARMCAT:uint  = 0x0020;
        private const FOOTMASK:uint = 0xFFEF;
        private const FOOTCAT:uint  = 0x0008;

        public function create(_world:b2World, start:FlxPoint,
                               legType:Number = LEGAMASK):void
        {
            m_world = _world;
            legType = legType;

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

            // Torso1
            box = new b2PolygonShape();
            box.SetAsBox(15 / m_physScale, 15 / m_physScale);
            fixtureDef.shape = box;
            fixtureDef.density = 1.0;
            fixtureDef.friction = 0.4;
            fixtureDef.restitution = 0.1;
            filterData = new b2FilterData();
            filterData.maskBits = TORSOMASK;
            filterData.categoryBits = TORSOCAT;
            fixtureDef.filter = filterData;
            bd.position.Set(startX / m_physScale, (startY + 28) / m_physScale);
            var torso1:b2Body = m_world.CreateBody(bd);
            torso1.CreateFixture(fixtureDef);
            // Torso2
            box = new b2PolygonShape();
            box.SetAsBox(15 / m_physScale, 15 / m_physScale);
            fixtureDef.shape = box;
            bd.position.Set(startX / m_physScale, (startY + 58) / m_physScale);
            bd.fixedRotation = true;
            var torso2:b2Body = m_world.CreateBody(bd);
            torso2.CreateFixture(fixtureDef);
            bd.fixedRotation = false;
            midriff = torso2;

            // UpperArm
            fixtureDef.density = 1.0;
            fixtureDef.friction = 0.4;
            fixtureDef.restitution = 0.1;
            filterData = new b2FilterData();
            filterData.maskBits = ARMMASK;
            filterData.categoryBits = ARMCAT;
            fixtureDef.filter = filterData;
            // L
            box = new b2PolygonShape();
            box.SetAsBox(36 / m_physScale, 6.5 / m_physScale);
            fixtureDef.shape = box;
            bd.position.Set((startX - 48) / m_physScale, (startY + 20) / m_physScale);
            var upperArmL:b2Body = m_world.CreateBody(bd);
            upperArmL.CreateFixture(fixtureDef);
            // R
            box = new b2PolygonShape();
            box.SetAsBox(36 / m_physScale, 6.5 / m_physScale);
            fixtureDef.shape = box;
            bd.position.Set((startX + 48) / m_physScale, (startY + 20) / m_physScale);
            var upperArmR:b2Body = m_world.CreateBody(bd);
            upperArmR.CreateFixture(fixtureDef);

            // UpperLeg
            fixtureDef.density = 1.0;
            fixtureDef.friction = 0.4;
            fixtureDef.restitution = 0.1;
            var filterData:b2FilterData = new b2FilterData();
            filterData.maskBits = LEGAMASK;
            filterData.categoryBits = LEGACAT;
            if (legType == BTYPE) {
                filterData.maskBits = LEGBMASK;
                filterData.categoryBits = LEGBCAT;
            }
            fixtureDef.filter = filterData;
            // L
            box = new b2PolygonShape();
            box.SetAsBox(7.5 / m_physScale, 44 / m_physScale);
            fixtureDef.shape = box;
            bd.position.Set((startX - LEGSPACING) / m_physScale, (startY + 108) / m_physScale);
            var upperLegL:b2Body = m_world.CreateBody(bd);
            upperLegL.CreateFixture(fixtureDef);
            // R
            box = new b2PolygonShape();
            box.SetAsBox(7.5 / m_physScale, 44 / m_physScale);
            fixtureDef.shape = box;
            bd.position.Set((startX + LEGSPACING) / m_physScale, (startY + 108) / m_physScale);
            var upperLegR:b2Body = m_world.CreateBody(bd);
            upperLegR.CreateFixture(fixtureDef);

            // LowerLeg
            fixtureDef.density = 1.0;
            fixtureDef.friction = 0.4;
            fixtureDef.restitution = 0.1;
            filterData = new b2FilterData();
            filterData.maskBits = FOOTMASK;
            filterData.categoryBits = FOOTCAT;
            fixtureDef.filter = filterData;
            // L
            box = new b2PolygonShape();
            box.SetAsBox(6 / m_physScale, 10 / m_physScale);
            fixtureDef.shape = box;
            bd.position.Set((startX - LEGSPACING) / m_physScale, (startY + 160) / m_physScale);
            var lowerLegL:b2Body = m_world.CreateBody(bd);
            lowerLegL.CreateFixture(fixtureDef);
            // R
            box = new b2PolygonShape();
            box.SetAsBox(6 / m_physScale, 10 / m_physScale);
            fixtureDef.shape = box;
            bd.position.Set((startX + LEGSPACING) / m_physScale, (startY + 160) / m_physScale);
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

            // Shoulders/stomach
            jd.lowerAngle = -15 / (180/Math.PI);
            jd.upperAngle = 15 / (180/Math.PI);
            jd.Initialize(torso1, torso2, new b2Vec2(startX / m_physScale, (startY + 35) / m_physScale));
            m_world.CreateJoint(jd);

            // Torso to upper leg
            // L
            jd.lowerAngle = -25 / (180/Math.PI);
            jd.upperAngle = 45 / (180/Math.PI);
            jd.Initialize(torso2, upperLegL, new b2Vec2((startX - LEGSPACING) / m_physScale, (startY + 72) / m_physScale));
            m_world.CreateJoint(jd);
            // R
            jd.lowerAngle = -45 / (180/Math.PI);
            jd.upperAngle = 25 / (180/Math.PI);
            jd.Initialize(torso2, upperLegR, new b2Vec2((startX + LEGSPACING) / m_physScale, (startY + 72) / m_physScale));
            m_world.CreateJoint(jd);

            // Upper leg to lower leg
            // L
            jd.lowerAngle = -25 / (180/Math.PI);
            jd.upperAngle = 115 / (180/Math.PI);
            jd.Initialize(upperLegL, lowerLegL, new b2Vec2((startX - 8) / m_physScale, (startY + 155) / m_physScale));
            m_world.CreateJoint(jd);
            // R
            jd.lowerAngle = -115 / (180/Math.PI);
            jd.upperAngle = 25 / (180/Math.PI);
            jd.Initialize(upperLegR, lowerLegR, new b2Vec2((startX + 8) / m_physScale, (startY + 155) / m_physScale));
            m_world.CreateJoint(jd);
        }

        public function update():void
        {

        }
    }

}
