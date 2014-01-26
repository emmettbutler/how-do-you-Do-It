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
        public var arm1:Arm;
        public var arm2:Arm;
        public var speed:Number = .055;
        public var speed_up:Number = .5;
        static public var dollTranslateSpeed:Number;
        static public var dollRotateSpeed:Number;
        public var t:FlxText;
        public var rotateMirror:Boolean = false;
        public var isClose:Boolean;

        public var timeFrame:Number = 0;
        public var timeSec:Number = 0;

        public function DollController(doll1:DollGrabber, doll2:DollGrabber,
                                       arm1:Arm, arm2:Arm)
        {
            dollRotateSpeed = speed;
            dollTranslateSpeed = speed;
            this.doll1 = doll1;
            this.doll2 = doll2;
            this.arm1 = arm1;
            this.arm2 = arm2;
            t = new FlxText(100,100,100,"");
            FlxG.state.add(t);
        }

        public function update(timeRemain:Number):Boolean
        {
            timeFrame++;

            if(timeFrame%500 == 0){
                rotateMirror = rotateMirror ? false : true;
            }

            var toss:Boolean = false;
            if (timeRemain < 2) {
                toss = true;
            }

            var ret:Boolean = false;

            var distance:Number = dollProximity(toss);

            if(distance < 7.5){
                this.isClose = true;
            } else {
                this.isClose = false;
            }
            //t.text = this.isClose.toString();

            var target1:b2Vec2 = doll1.m_mouseJoint.GetTarget().Copy();
            var target2:b2Vec2 = doll2.m_mouseJoint.GetTarget().Copy();
            var angle1:Number = doll1.doll.midriff.GetAngle();
            var angle2:Number = doll2.doll.midriff.GetAngle();
            var left:Boolean = false;
            var right:Boolean = false;
            var up:Boolean = false;
            var down:Boolean = false;
            if (FlxG.keys.D || (toss && distance > 7.5)) {
                right = true;
                left = false;
                ret = true;
            } else if (FlxG.keys.A) {
                right = false;
                left = true;
                ret = true;
            }
            if (FlxG.keys.S) {
                up = false;
                down = true;
                ret = true;
            } else if (FlxG.keys.W) {
                up = true;
                down = false;
                ret = true;
            }

            if (FlxG.keys.E) {
                ret = true;
                if (rotateMirror) {
                    angle1 += dollRotateSpeed;
                    arm1.turn(true);
                } else {
                    angle2 -= dollRotateSpeed;
                    arm2.turn(false);
                }
            } else if (FlxG.keys.Q) {
                ret = true;
                if (rotateMirror) {
                    angle2 -= dollRotateSpeed;
                    arm2.turn(false);
                } else {
                    angle1 += dollRotateSpeed;
                    arm1.turn(true);
                }
            } else {
                arm1.stopTurning();
                arm2.stopTurning();
            }

            if (toss) {
                dollTranslateSpeed = 1;
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

            doll1.SetTransform(target1, angle1, toss);
            doll2.SetTransform(target2, angle2, toss);
            return ret;
        }

        public function dollProximity(toss:Boolean):Number{
            var a:Number = Math.abs(doll1.doll.midriff.GetPosition().x - doll2.doll.midriff.GetPosition().y);
            var b:Number = Math.abs(doll1.doll.midriff.GetPosition().y - doll2.doll.midriff.GetPosition().x);
            var distance:Number = Math.sqrt(Math.pow(a,2)+Math.pow(b,2));

            if (toss) return distance;

            if(distance < 7.5){
                dollTranslateSpeed = speed_up;
                this.isClose == true;
            } else {
                dollTranslateSpeed = speed;
                this.isClose == false;
            }

            return distance;
        }
    }
}
