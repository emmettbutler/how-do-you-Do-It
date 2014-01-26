package
{
    import org.flixel.*;

    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Joints.*;

    public class DollController
    {
        public var doll1:DollGrabber;
        public var doll2:DollGrabber;
        static public var dollTranslateSpeed:Number = .045;
        static public var dollRotateSpeed:Number = .045;
        public var t:FlxText;

        public function DollController(doll1:DollGrabber, doll2:DollGrabber)
        {
            this.doll1 = doll1;
            this.doll2 = doll2;
            t = new FlxText(100,100,100,"");
            FlxG.state.add(t);
        }

        public function update():void
        {
            var target1:b2Vec2 = doll1.m_mouseJoint.GetTarget().Copy();
            var target2:b2Vec2 = doll2.m_mouseJoint.GetTarget().Copy();
            var angle1:Number = doll1.doll.midriff.GetAngle();
            var angle2:Number = doll2.doll.midriff.GetAngle();
            var left:Boolean = false;
            var right:Boolean = false;
            var up:Boolean = false;
            var down:Boolean = false;
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
                angle1 += dollRotateSpeed;
            } else if (FlxG.keys.Q) {
                angle2 += dollRotateSpeed;
            }

            if (left) {
                target1.x -= dollTranslateSpeed;
                target2.x += dollTranslateSpeed;
            }
            if (right) {
                target1.x += dollTranslateSpeed;
                target2.x -= dollTranslateSpeed;
            }
            if (up) {
                target1.y -= dollTranslateSpeed;
                target2.y -= dollTranslateSpeed;
            }
            if (down) {
                target1.y += dollTranslateSpeed;
                target2.y += dollTranslateSpeed;
            }

            doll1.SetTransform(target1, angle1);
            doll2.SetTransform(target2, angle2);
            dollProximity();
        }

        public function dollProximity():void{
            var a:Number = Math.abs(doll1.doll.midriff.GetPosition().x - doll2.doll.midriff.GetPosition().y);
            var b:Number = Math.abs(doll1.doll.midriff.GetPosition().y - doll2.doll.midriff.GetPosition().x);
            //c = sqrt(a^2+b^2)
            var distance:Number = Math.sqrt(Math.pow(a,2)+Math.pow(b,2));
            //t.text = distance.toString();

            if(distance < 9){
                dollTranslateSpeed = .2;
            } else {
                dollTranslateSpeed = .045;
            }
        }
    }
}
