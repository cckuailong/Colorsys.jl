#=
Conversion functions between any two of the color systems.

All inputs and outputs are three floats in the range [0.0...1.0]
(with the exception of I and Q, which covers a slightly larger range
 also with the exception of R, G and B, which range from 0 to 255
 also with the exception of H, which range from 0 to 360).

Inputs outside the valid range may cause exceptions or invalid outputs.

Supported color systems:
RGB: Red, Green, Blue components
YIQ: Luminance, Chrominance (used by composite video signals)
HLS: Hue, Luminance, Saturation
HSV: Hue, Saturation, Value
=#
# macro
const one_third = 1/3
const one_sixth = 1/6
const two_third = 2/3
# Util Functions
function _v(m1, m2, hue)
    hue = hue - floor(hue)
    if hue < one_sixth
        return m1+(m2-m1)*hue*6
    end
    if hue < .5
        return m2
    end
    if hue < two_third
        return m1+(m2-m1)*(two_third-hue)*6
    end
    return m1
end

#=
YIQ: used by composite video signals (linear combinations of RGB)
Y: perceived grey level (0.0 == black, 1.0 == white)
I, Q: color components
=#
function rgb2yiq(r, g, b)
    r1,g1,b1 = [r,g,b]/255
    return .3*r1+.59*g1+.11*b1, .6*r1-.28*g1-.32*b1, .21*r1-.52*g1+.31*b1
end

function yiq2rgb(y, i, q)
    r,g,b = y+.948262*i+.624013*q, y-.276066*i-.639810*q, y-1.105450*i+1.729860*q
    r = r<0 ? 0 : (r>1 ? 1 : r)
    g = g<0 ? 0 : (g>1 ? 1 : g)
    b = b<0 ? 0 : (b>1 ? 1 : b)
    return trunc(Int,r*255), trunc(Int,g*255), trunc(Int,b*255)
end

#=
HLS: Hue, Luminance, Saturation
H: position in the spectrum(0~360)
L: color lightness
S: color saturation
=#
function rgb2hls(r, g, b)
    r1,g1,b1 = [r,g,b]/255
    maxc,minc = max([r1,g1,b1]...), min([r1,g1,b1]...)
    l = (maxc+minc)/2
    if minc == maxc
        return .0, l, .0
    end
    s = l<=.5 ? (maxc-minc)/(maxc+minc) : (maxc-minc)/(2-maxc-minc)
    rc,gc,bc = [(maxc-r1),(maxc-g1),(maxc-b1)]/(maxc-minc)
    h = r1==maxc ? (bc-gc) : (g1==maxc ? (2+rc-bc) : (4+gc-rc))
    h0 = h/6
    h = h0 - floor(h0)
    return h*360, l, s
end

function hls2rgb(h, l, s)
    if s == 0
        return trunc(Int,l), trunc(Int,l), trunc(Int,l)
    end
    m2 = l<=.5 ? (l*(1+s)) : (l+s-l*s)
    m1 = 2*l - m2
    h /= 360
    return trunc(Int,_v(m1,m2,h+one_third)*255), trunc(Int,_v(m1,m2,h)*255), trunc(Int,_v(m1,m2,h-one_third)*255)
end

#=
HSV: Hue, Saturation, Value
H: position in the spectrum(0~360)
S: color saturation ("purity")
V: color brightness
=#
function rgb2hsv(r, g, b)
    r1,g1,b1 = [r,g,b]/255
    maxc = max([r1,g1,b1]...)
    minc = min([r1,g1,b1]...)
    if maxc == minc
        return .0, .0, maxc
    end
    s = (maxc-minc)/maxc
    rc,gc,bc = [(maxc-r1),(maxc-g1),(maxc-b1)]/(maxc-minc)
    h = r1==maxc ? (bc-gc) : (g1==maxc ? (2+rc-bc) : (4+gc-rc))
    h0 = h / 6
    h = h0 - floor(h0)
    return h*360, s, maxc
end

function hsv2rgb(h, s, v)
    h /= 360
    if s == 0
        return trunc(Int,v*255), trunc(Int,v*255), trunc(Int,v*255)
    end
    i = trunc(Int,h*6)
    f = h*6 - i
    p,q,t = [(1-s),(1-s*f),(1-s*(1-f))]*v
    i %= 6
    if i == 0
        return trunc(Int,v*255), trunc(Int,t*255), trunc(Int,p*255)
    elseif i == 1
        return trunc(Int,q*255), trunc(Int,v*255), trunc(Int,p*255)
    elseif i == 2
        return trunc(Int,p*255), trunc(Int,v*255), trunc(Int,t*255)
    elseif i == 3
        return trunc(Int,p*255), trunc(Int,q*255), trunc(Int,v*255)
    elseif i == 4
        return trunc(Int,t*255), trunc(Int,p*255), trunc(Int,v*255)
    elseif i == 5
        return trunc(Int,v*255), trunc(Int,p*255), trunc(Int,q*255)
    else
        return 0, 0, 0
    end
end

function yiq2hls(y, i, q)
    r,g,b = yiq2rgb(y,i,q)
    return rgb2hls(r,g,b)
end

function yiq2hsv(y, i, q)
    r,g,b = yiq2rgb(y,i,q)
    return rgb2hsv(r,g,b)
end

function hls2yiq(h, l, s)
    r,g,b = hls2rgb(h,l,s)
    return rgb2yiq(r,g,b)
end

function hls2hsv(h, l, s)
    r,g,b = hls2rgb(h,l,s)
    return rgb2hsv(r,g,b)
end

function hsv2yiq(h,s,v)
    r,g,b = hsv2rgb(h,s,v)
    return rgb2yiq(r,g,b)
end

function hsv2hls(h,s,v)
    r,g,b = hsv2rgb(h,s,v)
    return rgb2hls(r,g,b)
end
println(rgb2hsv(120, 120, 120))
