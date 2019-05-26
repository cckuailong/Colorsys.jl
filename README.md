# Colorsys.jl
[![Build Status](https://travis-ci.com/cckuailong/Colorsys.jl.svg?branch=master)](https://travis-ci.com/cckuailong/Colorsys.jl)
[![Coveralls](https://coveralls.io/repos/github/cckuailong/Colorsys.jl/badge.svg?branch=master)](https://coveralls.io/github/cckuailong/Colorsys.jl?branch=master)
## What is Colorsys.jl
Colorsys.jl is a Julia package(or lib) for everyone to
transform one color system to another. The transformation
is among RGB, YIQ, HLS and HSV.
## Install
```
import Pkg
Pkg.clone("https://github.com/cckuailong/Colorsys.jl.git")
```
## Import
```
using Colorsys
```
## How to use it
### Parameter Range
All inputs and outputs are three floats in the range [0.0...1.0]
(with the exception of I and Q, which covers a slightly larger range
also with the exception of R, G and B, which range from 0 to 255
also with the exception of H, which range from 0 to 360).

```
range of each parameter
R, G, B :    0 ~ 255
I, Q :      -1 ~ 1.X
H :          0 ~ 360
Y, S, V, L : 0 ~ 1
```
### Examples
1. RGB to YIQ
```
y, i, q = Colorsys.rgb2yiq(r, g, b)
```
2. YIQ to RGB
```
r, g, b = Colorsys.yiq2rgb(y, i, q)
```
3. RGB to HLS
```
h, l, s = Colorsys.rgb2hls(r, g, b)
```
4. HLS to RGB
```
r, g, b = Colorsys.hls2rgb(h, l, s)
```
5. RGB to HSV
```
h, s, v = Colorsys.rgb2hsv(r, g, b)
```
6. HSV to RGB
```
r, g, b = Colorsys.hsv2rgb(h, s, v)
```
7. Yiq to Hls
```
h, l, s = Colorsys.yiq2hls(y, i, q)
```
8. YIQ to HSV
```
h, s, v = Colorsys.yiq2hsv(y, i, q)
```
9. HLS to YIQ
```
y, i, q = Colorsys.hls2yiq(h, l, s)
```
10. HLS to HSV
```
h, s, v = Colorsys.hls2hsv(h, l, s)
```
11. HSV to YIQ
```
y, i, q = Colorsys.hsv2yiq(h, s, v)
```
12. HSV to HLS
```
h, l, s = Colorsys.hsv2hls(h, s, v)
```
## Contact
Any questions, welcome to email me at 346813862Hjj@gmail.com

My Blog is lovebear.top
