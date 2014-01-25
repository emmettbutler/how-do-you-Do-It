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
        public var worldBounds:b2AABB;

        static public var dollTranslateSpeed:Number = .1;
        static public var dollRotateSpeed:Number = .1;

        public static const WASD:Number = 0;
        public static const ARROW:Number = 1;

        public function create(doll:PhysicsDoll, m_world:b2World,
                               bounds:b2AABB,
                               ctrl:Number = WASD):void
        {
            this.ctrlScheme = ctrl;
            this.doll = doll;
            this.worldBounds = bounds;

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
            var target:b2Vec2 = m_mouseJoint.GetTarget().Copy();
            var angle:Number = doll.midriff.GetAngle();
            var left:Boolean = false;
            var right:Boolean = false;
            var up:Boolean = false;
            var down:Boolean = false;
            if (ctrlScheme == WASD) {
                if (FlxG.keys.D) {
                    right = true;
                    left = false;
                } else if (FlxG.keys.A) {
                    right = false;
                    left = true;
                }
                if (FlxG.keys.S) {
                    up = false;
                    down = true;
                } else if (FlxG.keys.W) {
                    up = true;
                    down = false;
                }

                if (FlxG.keys.E) {
                    angle += dollRotateSpeed;
                } else if (FlxG.keys.Q) {
                    angle -= dollRotateSpeed;
                }
            } else if (ctrlScheme == ARROW) {
                if (FlxG.keys.L) {
                    right = true;
                    left = false;
                } else if (FlxG.keys.J) {
                    right = false;
                    left = true;
                }
                if (FlxG.keys.K) {
                    up = false;
                    down = true;
                } else if (FlxG.keys.I) {
                    up = true;
                    down = false;
                }

                if (FlxG.keys.U) {
                    angle += dollRotateSpeed;
                } else if (FlxG.keys.O) {
                    angle -= dollRotateSpeed;
                }
            }

            if (left) {
                target.x -= dollTranslateSpeed;
            }
            if (right) {
                target.x += dollTranslateSpeed;
            }
            if (up) {
                target.y -= dollTranslateSpeed;
            }
            if (down) {
                target.y += dollTranslateSpeed;
            }
            var targetAABB:b2AABB = new b2AABB();
            targetAABB.lowerBound.Set(target.x, target.y);
            targetAABB.upperBound.Set(target.x, target.y);
            if (worldBounds.Contains(targetAABB)) {
                m_mouseJoint.SetTarget(target);
            }
            doll.midriff.SetAngle(angle);
        }
    }
}
