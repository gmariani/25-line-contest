/**
 * 25-Line ActionScript Contest Entry
 * 
 * Project: Fireworks
 * Author:  Gabriel Mariani
 * Date:    November 24, 2008
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
[SWF(width=800, height=800, backgroundColor=0x000000, frameRate=30)]
stage.align = StageAlign.TOP_LEFT;
stage.scaleMode = StageScaleMode.NO_SCALE;
// 25 lines begins here!
var txt:TextField = addChild(new TextField()) as TextField, interval:int = 2000, tempx:Number, isDestroy:Number, holder:Sprite = addChild(new Sprite()) as Sprite, _t:int, _pt:int = -interval, _p:Dictionary = new Dictionary(), bmp:Bitmap = addChild(new Bitmap(new BitmapData(800, 800, true, 0))) as Bitmap;
stage.addEventListener(MouseEvent.CLICK, function() { isDestroy = 1 });
stage.addEventListener(MouseEvent.MOUSE_WHEEL, function(e:MouseEvent) { interval += ((interval + (e.delta * 33)) < 0) ? 0 : e.delta * 33});
stage.addEventListener(Event.ENTER_FRAME, function() {
	bmp.bitmapData.applyFilter(bmp.bitmapData, bmp.bitmapData.rect, new Point(), new flash.filters.ColorMatrixFilter([0.93, 0, 0, 0, 0, 0, 0.85, 0, 0, 0, 0, 0, 0.9, 0, 0, 0, 0, 0, .9, 0]));
	for each (var p:Object in _p) {
		(p.type == "r" && ((_t - p.tS) > p.lS || isDestroy == 1)) ? emit("s2", {x:p.t.x, y:p.t.y}, p.color, 40) : (p.type == "r") ? emit("s", {x:p.t.x, y:p.t.y}, 1) : null;
		if((_t - p.tS) > p.lS || (p.type == "r" && isDestroy-- == 1)) delete _p[holder.removeChild(p.t)];
		p.v = { x:p.v.x * ((p.type == "s") ? 0.99 : (p.type == "s2") ? 0.91 : 1), y:(p.v.y + ((p.type == "r") ? 0.35 : (p.type == "s") ? -0.03 : 0.2)) * ((p.type == "s") ? 0.99 : (p.type == "s2") ? 0.91 : 1) };
		p.t.transform.matrix = new Matrix((p.t.scaleX * ((p.type == "r") ? 0.98 : (p.type == "s") ? 1.02 : 0.9)) * Math.cos(Math.atan2(p.v.y, p.v.x)), (p.t.scaleY * ((p.type == "r") ? 0.98 : (p.type == "s") ? 1.02 : 0.9)) * Math.sin(Math.atan2(p.v.y, p.v.x)), -((p.t.scaleY * ((p.type == "r") ? 0.98 : (p.type == "s") ? 1.02 : 0.9)) * Math.sin(Math.atan2(p.v.y, p.v.x))), (p.t.scaleX * ((p.type == "r") ? 0.98 : (p.type == "s") ? 1.02 : 0.9)) * Math.cos(Math.atan2(p.v.y, p.v.x)), p.t.x + p.v.x, p.t.y + p.v.y);
		bmp.bitmapData.draw(p.t, new Matrix(p.t.scaleX * Math.cos(Math.atan2(p.v.y, p.v.x)), p.t.scaleY * Math.sin(Math.atan2(p.v.y, p.v.x)), -(p.t.scaleY * Math.sin(Math.atan2(p.v.y, p.v.x))), p.t.scaleX * Math.cos(Math.atan2(p.v.y, p.v.x)), p.t.x, p.t.y), new ColorTransform(1, 1, 1, 0.98));
	}
	txt.htmlText = "<font face='_sans' color='#333333' size='25'><b>" + Number(interval / 1000).toFixed(1) + "s Delay (Scroll to Change) / Click to Explode</b></font>";
	if (((_t = getTimer() + 550) - _pt) >= interval) emit("r", {x:((Math.random()*200) + 300), y:800}, 1);
});
function emit(type:String, pt:Object, color:Number = NaN, num:uint = 1):void {
	if (type == "r") txt.width = _pt = _t;
	for (var i:int = 0; i < num; i++) {
		var p:Object = {type:type, tS:_t, t:holder.addChild(new Sprite()), color:Math.random() * 0xFFFFFF, lS:(type == "r") ? 2000 : (type == "s") ? 1660 : 1300, v:(type == "r") ? {x:Math.random() * (5 - -5) + -5,y:-20} : (type == "s") ? {x:Math.random() * (0.25 - -0.25) + -0.25, y:0} : {x:(tempx = (Math.random() * (20 - 10) + 10)) * Math.cos((Math.random()*360) * (180 / Math.PI)), y:tempx * Math.sin((Math.random()*360) * (180 / Math.PI))}};
		(type == "s") ? p.t.graphics.beginGradientFill("radial", [0xFFFFFF, 0xFFFFFF], [0.1, 0.012], [0, 255], new Matrix(0.023, 0, 0, 0.023)) : (type == "r") ? p.t.graphics.beginGradientFill("radial", [0xFFFFFF, 0xFFFFFF, p.color, p.color], [1, 1, 0.25, 0.25], [0, 150, 151, 255], new Matrix(0.0213, 0, 0, 0.0024, 0, 0)) : p.t.graphics.beginGradientFill("radial", [0xFFFFFF, 0xFFFFFF, color, color], [0.5, 0.5, 0.075, 0.075], [0, 150, 151, 255], new Matrix(0.0213, 0, 0, 0.0024, 0, 0));
		(type == "s") ? p.t.graphics.drawCircle(0, 0, 20) : p.t.graphics.drawEllipse(-21, -5.5, 42, 11);
		p.t.transform.matrix = new Matrix(((type == "r") ? 1 : (type == "s") ? Math.random() * (0.5 - 0.25) + 0.25 : Math.random() * (2.3 - 1.5) + 1.5), 0, 0, ((type == "r") ? 1 : (type == "s") ? Math.random() * (0.5 - 0.25) + 0.25 : Math.random() * (2.3 - 1.5) + 1.5), pt.x, pt.y);
		_p[p.t] = p;
	}
}
// 25 lines ends here!