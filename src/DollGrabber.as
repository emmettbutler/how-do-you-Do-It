package
{
    import org.flixel.*;

    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Joints.*;

    public class DollGrabber
    {
        public var m_mouseJoint:b2MouseJoint;
        public var ctrlScheme:Number;
        public var doll:PhysicsDoll;

        static public var dollTranslateSpeed:Number = .1;

        public static const WASD:Number = 0;
        public static const ARROW:Number = 1;

        public function create(doll:PhysicsDoll, m_world:b2World, ctrl:Number = WASD):void
        {
            this.ctrlScheme = ctrl;
            this.doll = doll;

            var md:b2MouseJointDef = new b2MouseJointDef();
            md.bodyA = m_world.GetGroundBody();
            md.bodyB = doll.midriff;
            md.target.Set(doll.midriff.GetPosition().x, doll.midriff.GetPosition().y);
            md.collideConnected = true;
            md.maxForce = 3000.0 * doll.midriff.GetMass();
            m_mouseJoint = m_world.CreateJoint(md) as b2MouseJoint;
        }

        public function update():void
        {
            var target:b2Vec2 = m_mouseJoint.GetTarget();
            var angle:Number = doll.midriff.GetAngle();
            if (ctrlScheme == WASD) {
                if (FlxG.keys.D) {
                    target.x += dollTranslateSpeed;
                } else if (FlxG.keys.A) {
                    target.x -= dollTranslateSpeed;
                }
                if (FlxG.keys.S) {
                    target.y += dollTranslateSpeed;
                } else if (FlxG.keys.W) {
                    target.y -= dollTranslateSpeed;
                }

                if (FlxG.keys.E) {
                    angle += .1;
                } else if (FlxG.keys.Q) {
                    angle -= .1;
                }
            } else if (ctrlScheme == ARROW) {
                if (FlxG.keys.L) {
                    target.x += dollTranslateSpeed;
                } else if (FlxG.keys.J) {
                    target.x -= dollTranslateSpeed;
                }
                if (FlxG.keys.K) {
                    target.y += dollTranslateSpeed;
                } else if (FlxG.keys.I) {
                    target.y -= dollTranslateSpeed;
                }

                if (FlxG.keys.U) {
                    angle += .1;
                } else if (FlxG.keys.O) {
                    angle -= .1;
                }
            }
            m_mouseJoint.SetTarget(target);
            doll.midriff.SetAngle(angle);
        }
    }
}
