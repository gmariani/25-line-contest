/**
 * 25-Line ActionScript Contest Entry
 *
 * Project: Invaders (High Score : 61)
 * Author:  Gabriel Mariani
 * Date:    Jan 13th 2009
 * Publish Code: NO
 *
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

// 3 free lines! Alter the parameters of the following lines or remove them.
// Do not substitute other code for the three lines in this section
[SWF(width="800", height="800", backgroundColor, frameRate="24")]
stage.align = StageAlign.TOP_LEFT;
stage.scaleMode = StageScaleMode.NO_SCALE;
// 25 lines begins here!
// 1 Init variables
var data:Object = {so: SharedObject.getLocal("invaders"), txt: addChild(new TextField()) as TextField, canShoot: true, time: 0, prevTime: 0, prevShootTime: 0, tempx: 0, score: 0, lives: 10, holder: addChild(new Sprite()) as Sprite, _p: new Dictionary(), bmp: addChild(new Bitmap(new BitmapData(800, 800, true, 0))) as Bitmap};
// 2 Draw turret
(data.turret = addChild(new Sprite()) as Sprite).graphics.drawGraphicsData(Vector.<IGraphicsData>([new GraphicsStroke(1, true, "normal", "square", "miter", 8, new GraphicsSolidFill(0x333333)), new GraphicsSolidFill(0xCCCCCC), new GraphicsPath(Vector.<int>([1, 3, 3, 3, 3, 3, 3, 3, 3]), Vector.<Number>([0, -10, 5, -10, 7.5, -7.5, 10, -5, 10, 0, 10, 5, 7.5, 7.5, 5, 10, 0, 10, -5, 10, -7.5, 7.5, -10, 5, -10, 0, -10, -5, -7.5, -7.5, -5, -10, 0, -10]), GraphicsPathWinding.NON_ZERO), new GraphicsSolidFill(0xCCCCCC), new GraphicsPath(Vector.<int>([1, 2, 2, 2, 2]), Vector.<Number>([-1, -4, 15, -4, 15, 4, -1, 4, -1, -4]), GraphicsPathWinding.NON_ZERO), new GraphicsEndFill()]));
// 3 Draw terrain
(data.terrain = addChild(new Sprite()) as Sprite).graphics.drawGraphicsData(Vector.<IGraphicsData>([new GraphicsSolidFill(0xFFFFFF), new GraphicsPath(Vector.<int>([1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2]), Vector.<Number>([0, 790, 100, 780, 200, 785, 300, 775, 400, 795, 500, 780, 600, 760, 700, 780, 800, 780, 800, 800, 0, 800, 0, 790]), GraphicsPathWinding.NON_ZERO), new GraphicsStroke(1, true, "normal", "square", "miter", 8, new GraphicsSolidFill(0x333333)), new GraphicsSolidFill(0xCCCCCC), new GraphicsPath(Vector.<int>([1, 2, 2, 2, 2]), Vector.<Number>([380, 785, 420, 785, 420, 800, 380, 800, 380, 785]), GraphicsPathWinding.NON_ZERO), new GraphicsEndFill()]));
// 4 Listen for mouse click. If player has lives and can shoot, shoot. Otherwise reset game
stage.addEventListener(MouseEvent.CLICK, function():void
    {
        (data.lives > 0 && data.canShoot) ? emit("r", {x : 400, y: 795, r: data.turret.rotation}): (data.lives <= 0) ? data.time = data.score = int(!Boolean(data.lives = 10)) : null;
    });
// 5 Listen for enterframe
stage.addEventListener(Event.ENTER_FRAME, function():void
    {
        // 6 Update position and rotation of turret
        data.turret.transform.matrix = new Matrix(data.turret.scaleX * Math.cos((Math.atan2(data.turret.y - stage.mouseY, data.turret.x - stage.mouseX) * 360 / (Math.PI * 2) - 180) * Math.PI / 180), (data.turret.scaleY) * Math.sin((Math.atan2(data.turret.y - stage.mouseY, data.turret.x - stage.mouseX) * 360 / (Math.PI * 2) - 180) * Math.PI / 180), -(data.turret.scaleY) * Math.sin((Math.atan2(data.turret.y - stage.mouseY, data.turret.x - stage.mouseX) * 360 / (Math.PI * 2) - 180) * Math.PI / 180), data.turret.scaleX * Math.cos((Math.atan2(data.turret.y - stage.mouseY, data.turret.x - stage.mouseX) * 360 / (Math.PI * 2) - 180) * Math.PI / 180), 400, 785);
        // 7 Apply bitmap filter
        data.bmp.bitmapData.applyFilter(data.bmp.bitmapData, data.bmp.bitmapData.rect, new Point(), new flash.filters.ColorMatrixFilter([0.93, 0, 0, 0, 0, 0, 0.85, 0, 0, 0, 0, 0, 0.9, 0, 0, 0, 0, 0, .9, 0]));
        // 8 Start for loop through each particle
        for each (var p:Object in data._p)
        {
            // 9 Check if ship has gone off screen and reduce lives, or if particle is too old; remove it
            ((data.time - p.tS) > p.lS) ? delete data._p[data.holder.removeChild(p.t)] : (p.type == "ship" && data.terrain.hitTestPoint(p.t.x, p.t.y, true) && (data.time - p.tS) < p.lS) ? p.lS = ((data.lives - 1) < 0 ? data.lives = 0 : data.lives -= 1) : null;
            // 10 If particle is too old, remove and start explosion, and loop through to create multiple particles
            for (var i:int = 1; i <= (((p.type == "r" || p.type == "ship") && ((data.time - p.tS) > p.lS)) ? 20 : (p.type == "r") ? 1 : 0); i++)
                emit((p.type == "r" || p.type == "ship") && ((data.time - p.tS) > p.lS) ? "s2" : "s", {x: p.t.x, y: p.t.y}, (p.type == "r") ? 0xF7AC00 : (p.type == "ship") ? p.color : NaN);
            // 11 Update velocity of particle
            p.v = {x: p.v.x * ((p.type == "s") ? 0.99 : (p.type == "s2") ? 0.91 : 1), y: (p.v.y + ((p.type == "r") ? 0.35 : (p.type == "s") ? -0.03 : (p.type == "r") ? 0.2 : 0)) * ((p.type == "s") ? 0.99 : (p.type == "s2") ? 0.91 : 1)};
            // 12 Update positiong and roation of particle
            p.t.transform.matrix = new Matrix((p.t.scaleX * ((p.type == "r") ? 0.98 : (p.type == "s") ? 1.02 : (p.type == "ship") ? 1 : 0.9)) * Math.cos(Math.atan2(p.v.y, p.v.x)), (p.t.scaleY * ((p.type == "r") ? 0.98 : (p.type == "s") ? 1.02 : (p.type == "ship") ? 1 : 0.9)) * Math.sin(Math.atan2(p.v.y, p.v.x)), -((p.t.scaleY * ((p.type == "r") ? 0.98 : (p.type == "s") ? 1.02 : (p.type == "ship") ? 1 : 0.9)) * Math.sin(Math.atan2(p.v.y, p.v.x))), (p.t.scaleX * ((p.type == "r") ? 0.98 : (p.type == "s") ? 1.02 : (p.type == "ship") ? 1 : 0.9)) * Math.cos(Math.atan2(p.v.y, p.v.x)), p.t.x + p.v.x, p.t.y + p.v.y);
            // 13 Update bitmap
            data.bmp.bitmapData.draw(p.t, new Matrix(p.t.scaleX * Math.cos(Math.atan2(p.v.y, p.v.x)), p.t.scaleY * Math.sin(Math.atan2(p.v.y, p.v.x)), -(p.t.scaleY * Math.sin(Math.atan2(p.v.y, p.v.x))), p.t.scaleX * Math.cos(Math.atan2(p.v.y, p.v.x)), p.t.x, p.t.y), new ColorTransform(1, 1, 1, 0.98));
            // 14 Start for loop through each particle. Check if rocket has hit a ship, if rocket has hit, update score and set lifespan to something really short, update high score if necessary.
            for each (var p2:Object in data._p)
                if ((p.type == "r") ? (p2.type == "ship" && p.t.hitTestObject(p2.t)) ? Boolean(p2.lS = p.lS = (((data.score + 1) > int(data.so.data.score)) ? (data.so.data.score = (data.score += 1)) : (data.score += 1))) : false : false)
                    break;
        }
        // 15 Update text
        data.txt.htmlText = (data.lives > 0) ? "<br/><font face='_sans' color='#ffffff' size='25'><b><i>  Invaders!</i></b><font face='_sans' color='#eeeeee' size='20'><br/>  Lives: " + data.lives + " | Score: " + data.score + " | <b>High Score: " + int(data.so.data.score) + "</b></font>" : "<br/><font face='_sans' color='#ffffff' size='25'><b><i>  Invaders!</i></b><font face='_sans' color='#eeeeee' size='20'><br/>  Lives: " + data.lives + " | Score: " + data.score + " | <b>High Score: " + int(data.so.data.score) + "</b></font><br/><br/><br/><br/><br/><br/><br/><p align='center'><font face='_sans' color='#ff0000' size='40'><b>GAME OVER!</b></font><br/><br/><font face='_sans' color='#eeeeee' size='20'>- Click again to restart game -</font></p>";
        // 16 Save high score data
        if (data.lives <= 0)
            data.so.flush();
        // 17 Update time, initialize textfield, turn off mouse children, and create ships on an interval
        ((data.time = getTimer()) < 1500) ? stage.mouseChildren = data.txt.selectable = !(data.txt.multiline = Boolean(data.txt.height = data.txt.width = 800)) : ((data.time - data.prevTime) >= 2000 && data.lives > 0) ? emit("ship", {x : (Math.random() * 775) + 20, y: 0}): null;
        // 18 Reset shoot interval
        if ((data.time - data.prevShootTime) >= 1000)
            data.canShoot = true;
    });
// 19 Emit function
function emit(type:String, pt:Object, color:Number = NaN):void
{
    // 20 If particle is a ship, update previous time
    (type == "ship") ? data.prevTime = data.time : (type == "r") ? data.canShoot = !Boolean(data.prevShootTime = data.time) : null;
    // 21 Init particle object
    var p:Object = {type: type, tS: data.time, t: data.holder.addChild(new Sprite()), color: (type == "r") ? 0xF7AC00 : Math.random() * 0xFFFFFF, lS: (type == "ship") ? 50000 : (type == "r") ? 3500 : (type == "s") ? 1660 : 1300, v: (type == "ship") ? {x : 0, y: 5 + .3 * (data.score)}: (type == "r") ? {x : 27 * Math.cos((pt.r * Math.PI / 180)), y: 27 * Math.sin((pt.r * Math.PI / 180))}: (type == "s") ? {x : Math.random() * (0.25 - -0.25) + -0.25, y: 0}: {x: (data.tempx = (Math.random() * (20 - 10) + 10)) * Math.cos((Math.random() * 360) * (180 / Math.PI)), y: data.tempx * Math.sin((Math.random() * 360) * (180 / Math.PI))}};
    // 22 Draw particle
    p.t.graphics.drawGraphicsData(Vector.<IGraphicsData>([(type == "ship") ? new GraphicsSolidFill(p.color, 0.5) : (type == "s") ? new GraphicsGradientFill("radial", [0xFFFFFF, 0xFFFFFF], [0.1, 0.012], [0, 255], new Matrix(0.023, 0, 0, 0.023)) : (type == "r") ? new GraphicsGradientFill("radial", [0xFFFFFF, 0xFFFFFF, p.color, p.color], [1, 1, 0.25, 0.25], [0, 150, 151, 255], new Matrix(0.0213, 0, 0, 0.0024, 0, 0)) : new GraphicsGradientFill("radial", [0xFFFFFF, 0xFFFFFF, color, color], [0.5, 0.5, 0.075, 0.075], [0, 150, 151, 255], new Matrix(0.0213, 0, 0, 0.0024, 0, 0)), (type == "ship") ? new GraphicsPath(Vector.<int>([2, 2, 2, 2, 2, 2, 2]), Vector.<Number>([0, 5, 0, 10, 5, 20, 10, 10, 10, 5, 5, -5, 0, 5])) : (type == "s") ? new GraphicsPath(Vector.<int>([1, 3, 3, 3, 3]), Vector.<Number>([0, -10, 10, -10, 10, 0, 10, 10, 0, 10, -10, 10, -10, 0, -10, -10, 0, -10])) : new GraphicsPath(Vector.<int>([1, 3, 3, 3, 3]), Vector.<Number>([-21, -5.5, 21, -5.5, 21, 0, 21, 0, 0, 5.5, -21, 5.5, -21, 0, -21, -5.5, 0, 0])), new GraphicsEndFill()]));
    // 23 Update position and rotation
    p.t.transform.matrix = new Matrix(((type == "r" || type == "ship") ? 1 : (type == "s") ? Math.random() * (0.5 - 0.25) + 0.25 : Math.random() * (2.3 - 1.5) + 1.5), 0, 0, ((type == "r" || type == "ship") ? 1 : (type == "s") ? Math.random() * (0.5 - 0.25) + 0.25 : Math.random() * (2.3 - 1.5) + 1.5), pt.x, pt.y);
    // 24 Save particle to memory
    data._p[p.t] = p;
};
// 25
// 25 lines ends here!