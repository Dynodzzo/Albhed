-- Easing class based on Easing for Lua by Roland Yonaba (https://github.com/Yonaba).

App.Easing = App.Class({
	_name = 'Easing',
});

-- Linear easing
function App.Easing:linear(b, c, t, d)
	return c * t / d + b;
end

-- Quadratic
function App.Easing:inQuad(b, c, t, d)
	local t = t / d;
	return c * math.pow(t, 2) + b;
end

function App.Easing:outQuad(b, c, t, d)
	local t = t / d;
	return -c * t * (t - 2) + b;
end

function App.Easing:inOutQuad(b, c, t, d)
	local t = t / d * 2;
	if (t < 1) then
		return c / 2 * math.pow(t, 2) + b;
	else
		return -c / 2 * ((t - 1) * (t - 3) - 1) + b;
	end
end

function App.Easing:outInQuad(b, c, t, d)
	if t < d / 2 then
		return self:outQuad(b, c / 2, t * 2, d);
	else
		return self:inQuad(b + c / 2, c / 2, (t * 2) - d, d);
	end
end

-- Cubic easing
function App.Easing:inCubic(b, c, t, d)
	local t = t / d;
	return c * math.pow(t, 3) + b;
end

function App.Easing:outCubic(b, c, t, d)
	local t = t / d - 1;
	return c * (math.pow(t, 3) + 1) + b;
end

function App.Easing:inOutCubic(b, c, t, d)
	local t = t / d * 2;
	if (t < 1) then
		return c / 2 * t * t * t + b;
	else
		t = t - 2;
		return c / 2 * (t * t * t + 2) + b;
	end
end

function App.Easing:outInCubic(b, c, t, d)
	if (t < d / 2) then
		return self:outCubic(b, c / 2, t * 2, d);
	else
		return self:inCubic(b + c, c / 2, (t * 2) - d, d);
	end
end

-- Quartic easing
function App.Easing:inQuart(b, c, t, d)
	local t = t / d;
	return c * math.pow(t, 4) + b;
end

function App.Easing:outQuart(b, c, t, d)
	local t = t / d - 1;
	return -c * (math.pow(t, 4) - 1) + b;
end

function App.Easing:inOutQuart(b, c, t, d)
	local t = t / d * 2;
	if (t < 1) then
		return c / 2 * math.pow(t, 4) + b;
	else
		t = t - 2;
		return -c / 2 * (math.pow(t, 4) - 2) + b;
	end
end

function App.Easing:outInQuart(b, c, t, d)
	if (t < d / 2) then
		return self:outQuart(b, c / 2, t * 2, d);
	else
		return self:inQuart(b + c / 2, c / 2, (t * 2) - d, d);
	end
end

-- Quintic easing
function App.Easing:inQuint(b, c, t, d)
	local t = t / d;
	return c * math.pow(t, 5) + b;
end

function App.Easing:outQuint(b, c, t, d)
	local t = t / d - 1;
	return c * (math.pow(t, 5) + 1) + b;
end

function App.Easing:inOutQuint(b, c, t, d)
	local t = t / d * 2;
	if (t < 1) then
		return c / 2 * math.pow(t, 5) + b;
	else
		t = t - 2;
		return c / 2 * (math.pow(t, 5) + 2) + b;
	end
end

function App.Easing:outInQuint(b, c, t, d)
	if (t < d / 2) then
		return self:outQuint(b, c / 2, t * 2, d);
	else
		return self:inQuint(b + c / 2, c / 2, (t * 2) - d, d);
	end
end

-- Sinusoidal easing
function App.Easing:inSine(b, c, t, d)
	return -c * math.cos(t / d * (math.pi / 2)) + c + b;
end

function App.Easing:outSine(b, c, t, d)
	return c * math.sin(t / d * (math.pi / 2)) + b;
end

function App.Easing:inOutSine(b, c, t, d)
	return -c / 2 * (math.cos(math.pi * t / d) - 1) + b;
end

function App.Easing:OutInSine(b, c, t, d)
	if (t < d / 2) then
		return self:outSine(b, c / 2, t * 2, d);
	else
		return self:inSine(b + c / 2, c / 2, (t * 2) -d, d);
	end
end

-- Exponential easing
function App.Easing:inExp(b, c, t, d)
	if (t == 0) then
		return b;
	else
		return c * math.pow(2, 10 * (t / d - 1)) + b - c * 0.001;
	end
end

function App.Easing:outExp(b, c, t, d)
	if (t == d) then
		return b + c;
	else
		return c * 1.001 * (-math.pow(2, -10 * t / d) + 1) + b;
	end
end

function App.Easing:inOutExp(b, c, t, d)
	if (t == 0) then return b end
	if (t == d) then return b + c end
	t = t / d * 2;
	if (t < 1) then
		return c / 2 * math.pow(2, 10 * (t - 1)) + b - c * 0.0005;
	else
		t = t - 1;
		return c / 2 * 1.0005 * (-math.pow(2, -10 * t) + 2) + b;
	end
end

function App.Easing:outInExp(b, c, t, d)
	if (t < d / 2) then
		return self:outExp(b, c / 2, t * 2, d);
	else
		return self:inExp(b + c / 2, c / 2, (t * 2) - d, d);
	end
end

-- Cirular easing
function App.Easing:inCircular(b, c, t, d)
	local t = t / d;
	return(-c * (math.sqrt(1 - math.pow(t, 2)) - 1) + b);
end

function App.Easing:outCircular(b, c, t, d)
	local t = t / d - 1;
	return(c * math.sqrt(1 - math.pow(t, 2)) + b);
end

function App.Easing:inOutCircular(b, c, t, d)
	local t = t / d * 2;
	if (t < 1) then
		return -c / 2 * (math.sqrt(1 - t * t) - 1) + b;
	else
		t = t - 2;
		return c / 2 * (math.sqrt(1 - t * t) + 1) + b;
	end
end

function App.Easing:outInCircular(b, c, t, d)
	if (t < d / 2) then
		return self:outCircular(b, c / 2, t * 2, d);
	else
		return self:inCircular(b + c / 2, c / 2, (t * 2) - d, d);
	end
end

-- Bounce easing
function App.Easing:outBounce(b, c, t, d)
	local t = t / d;
	if (t < 1 / 2.75) then
		return c * (7.5625 * t * t) + b;
	elseif (t < 2 / 2.75) then
		t = t - (1.5 / 2.75);
		return c * (7.5625 * t * t + 0.75) + b;
	elseif (t < 2.5 / 2.75) then
		t = t - (2.25 / 2.75);
		return c * (7.5625 * t * t + 0.9375) + b;
	else
		t = t - (2.625 / 2.75);
		return c * (7.5625 * t * t + 0.984375) + b;
	end
end

function App.Easing:inBounce(b, c, t, d)
	return c - OUTBOUNCE(d - t, 0, c, d) + b;
end

function App.Easing:inOutBounce(b, c, t, d)
	if (t < d / 2) then
		return INBOUNCE(t * 2, 0, c, d) * 0.5 + b;
	else
		return OUTBOUNCE(t * 2 - d, 0, c, d) * 0.5 + c * .5 + b;
	end
end

function App.Easing:outInBounce(b, c, t, d)
	if (t < d / 2) then
		return OUTBOUNCE(b, c / 2, t * 2, d);
	else
		return INBOUNCE(b + c / 2, c / 2, (t * 2) - d, d);
	end
end

-- Back easing
function App.Easing:inBack(b, c, t, d, s)
	local s = s and s or 1.70158;
	local t = t / d;
	return c * t * t * ((s + 1) * t - s) + b;
end

function App.Easing:outBack(b, c, t, d, s)
	local s = s and s or 1.70158;
	local t = t / d - 1;
	return c * (t * t * ((s + 1) * t + s) + 1) + b;
end

function App.Easing:inOutBack(b, c, t, d, s)
	local s = s and s or 1.70158;
	s = s * 1.525;
	local t = t / d * 2;
	if (t < 1) then
		return c / 2 * (t * t * ((s + 1) * t - s)) + b;
	else
		t = t - 2;
		return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b;
	end
end

function App.Easing:outInBack(b, c, t, d, s)
	if (t < d / 2) then
		return self:outBack(b, c / 2, t * 2, d, s);
	else
		return self:inBack(b + c / 2, c / 2, (t * 2) - d, d, s);
	end
end

-- Elastic easing
function App.Easing:inElastic(b, c, t, d, a, p)
	local t = t;
	if (t == 0) then return b end
	local t = t / d;
	if (t == 1)  then return b + c end
	local p = p and p or d * 0.3;
	local s;
	local a = a;
	if (not a or a < math.abs(c)) then
		a = c;
		s = p / 4;
	else
		s = p / (2 * math.pi) * math.asin(c/a);
	end
	t = t - 1;
	return -(a * math.pow(2, 10 * t) * math.sin((t * d - s) * (2 * math.pi) / p)) + b;
end

function App.Easing:outElastic(b, c, t, d, a, p)
	local t = t;
	if (t == 0) then return b end
	local t = t / d;
	if (t == 1) then return b + c end
	local p = p and p or d*0.3;
	local s;
	local a = a;
	if (not a or a < math.abs(c)) then
		a = c;
		s = p / 4;
	else
		s = p / (2 * pi) * math.asin(c/a);
	end
	return a * math.pow(2, -10 * t) * math.sin((t * d - s) * (2 * math.pi) / p) + c + b;
end

function App.Easing:inOutElastic(b, c, t, d, a, p)
	local t = t;
	if (t == 0) then return b end
	local t = t / d * 2;
	if (t == 2) then return b + c end
	local p = p and p or d*0.3*1.5;
	local a  = a and a or 0;
	local s;
	if (not a or a < math.abs(c)) then
		a = c;
		s = p / 4;
	else
		s = p / (2 * math.pi) * math.asin(c / a);
	end

	if (t < 1) then
		t = t - 1;
		return -0.5 * (a * math.pow(2, 10 * t) * math.sin((t * d - s) * (2 * math.pi) / p)) + b;
	else
		t = t - 1;
		return a * math.pow(2, -10 * t) * math.sin((t * d - s) * (2 * math.pi) / p ) * 0.5 + c + b;
	end
end

function App.Easing:outInElastic(b, c, t, d, a, p)
	if (t < d / 2) then
		return self:outElastic(b, c / 2, t * 2, d, a, p);
	else
		return self:inElastic(b + c / 2, c / 2, (t * 2) - d, d, a, p);
	end
end

function App.Easing:animate(easing, startValue, amplitude, elapsedTime, duration, amplitude, period)
	if (self[easing]) then
		return self[easing](self, elapsedTime, startValue, amplitude, duration, amplitude, period);
	end
end
