-- This file:
--   http://angg.twu.net/LUA/RAng1.lua.html
--   http://angg.twu.net/LUA/RAng1.lua
--           (find-angg "LUA/RAng1.lua")
-- Author: Eduardo Ochs <eduardoochs@gmail.com>
--
-- Replace things in angle brackets.
--
-- (defun o  () (interactive) (find-angg "LUA/UbExpr1.lua"))
-- (defun l  () (interactive) (find-angg "LUA/UbExpr2.lua"))
-- (defun r  () (interactive) (find-angg "LUA/RAng1.lua"))
-- (defun rf () (interactive) (find-angg "LUA/RAngFormulas1.lua"))

-- «.RAng»		(to "RAng")
-- «.RAng-test1»	(to "RAng-test1")
-- «.RAng-test2»	(to "RAng-test2")
-- «.RAng-test3»	(to "RAng-test3")
-- «.RAng-test4»	(to "RAng-test4")

require "Pict2e1"    -- (find-angg "LUA/Pict2e1.lua")
require "UbExpr1"    -- (find-angg "LUA/UbExpr1.lua")
require "UbExpr2"    -- (find-angg "LUA/UbExpr2.lua")



-- «RAng»  (to ".RAng")
RAng = Class {
  type = "RAng",
  strtof = function (f0)
      if type(f0) == "function" then return f0 end
      if type(f0) == "string" then
        return function (s) return Code.ve(f0)(s) end
      end
      error()
    end,
  gsub = function (str, f)
      f = RAng.strtof(f)
      return (str:gsub("<(.-)>", f))
    end,
  --
  expr = function (str)
      return RAng.gsub(str, "s => tostring(expr(s))")
    end,
  set = function (str)
      local sl = Set.new()
      RAng.gsub(str, function (s) sl:add(s) end)
      return sl
    end,
  setl = function (str)
      local sl = SetL.new()
      RAng.gsub(str, function (s) sl:add(s) end)
      return sl
    end,
  gaify = function (str)
      return RAng.gsub(str, [[ s => '\\ga{'..s..'}' ]])
    end,
  sas = function (str, f)
      local out = ""
      for k,v in RAng.set(str):gen() do
        out = out .. format("  \\sa{%s}{%s}\n", k, tostring(f(k)))
      end
      return out
    end,
  sagaify = function (str, f)
      return RAng.sas(str, f) .. RAng.gaify(str)
    end,
  sagaifys = function (str, S_or_nil)
      local f = function (s) return (S_or_nil or id)(expr(s)) end
      return RAng.sas(str, f) .. RAng.gaify(str)
    end,
  --
  new = function (src) return RAng {src=rtrim(src)} end,
  __tostring = function (ra) return "RAng:\n"..ra.src end,
  __index = {
    topict = function (ra, S)
        return PictList {
            RAng.sagaifys(ra.src, S)
          }
      end,
  },
}

-- «RAng-test1»  (to ".RAng-test1")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "RAng1.lua"

f = function (str) return "(:"..str..":)" end
= RAng.gsub("foo<a><b>bar", f)
f = function (str) print(str) end
= RAng.gsub("foo<a><b>bar", f)
f = function (str) return expr(str) end
= RAng.gsub("foo<a><1+2>bar", f)
f = function (str) return tostring(expr(str)) end

= RAng.strtof("a => 10*a")
= RAng.strtof("a => 10*a")(3)

= Code.ve("a => 10*a")
= Code.ve("a => 10*a")(3)

= RAng.gsub("foo<a><1+2>bar", f)
= RAng.gsub("foo<a><1+2>bar", " s => expr(s) ")
= RAng.gsub("foo<a><1+2>bar", "s => expr(s)")
= RAng.gsub("foo<a><1+2>bar", "s => tostring(expr(s))")
= RAng.expr("foo<a><1+2>bar")
= RAng.setl("foo<a><1+2>bar")
= RAng.setl("foo<b><a><b>bar"):ksc(" ")
= RAng.gsub("foo<b><a><b>bar", "s => '\\\\ga{'..s..'}'")
= RAng.gsub("foo<b><a><b>bar", [[ s => '\\ga{'..s..'}' ]])
= RAng.gaify("foo<b><a><b>bar")

 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "RAng1.lua"
sl = RAng.set ("foo<4+5><2+3><4+5>bar")
sl = RAng.setl("foo<4+5><2+3><4+5>bar")
for k,v in sl:gen() do print(k, v) end

= RAng.sas    ("foo<4+5><2+3><4+5>bar", expr)
= RAng.gaify  ("foo<4+5><2+3><4+5>bar")
= RAng.sagaify("foo<4+5><2+3><4+5>bar", expr)
f = function (str) return "."..tostring(expr(str)).."." end
= RAng.sagaify("foo<4+5><2+3><4+5>bar", f)

--]==]



-- «RAng-test2»  (to ".RAng-test2")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "RAng1.lua"
dofile "UbExpr1.lua"     -- (find-angg "LUA/UbExpr1.lua")
dofile "UbExpr2.lua"     -- (find-angg "LUA/UbExpr2.lua")
dofile "Pict2e1.lua"     -- (find-angg "LUA/Pict2e1.lua")

define_MV1()
t = "t"

defsubst("S2", [[
      f(expr1)  := sen(S2(expr1))
      fp(expr1) := cos(S2(expr1))
      g(expr1)  := Mul(20, S2(expr1))
      gp(expr1) := 20
      x         := t
  ]])

= MV1
= S2(MV1)

RC_src = [[ \frac{d}{d<x>} <f(g(x))> = <Mul(fp(g(x)), gp(x))> ]]

= f(g(x))
= Mul(fp(g(x)), gp(x))

=    expr("Mul(fp(g(x)), gp(x))")
= S2(expr("Mul(fp(g(x)), gp(x))"))
= RAng.sagaify (RC_src, expr)
= RAng.sagaify (RC_src, function (s) return S2(expr(s)) end)
= RAng.sagaifys(RC_src)
= RAng.sagaifys(RC_src, S2)

= RAng.new(RC_src)
= RAng.new(RC_src):topict()
= RAng.new(RC_src):topict(S2)

= f(g(x))

--]==]


-- «RAng-test3»  (to ".RAng-test3")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "RAng1.lua"

define_MV1()
t = "t"

defsubst("S2", [[
      f(expr1)  := sen(S2(expr1))
      fp(expr1) := cos(S2(expr1))
      g(expr1)  := Mul(20, S2(expr1))
      gp(expr1) := 20
      x         := t
  ]])

RC = RAng.new [[
  \frac{d}{d<x>} <f(g(x))> = <Mul(fp(g(x)), gp(x))>
]]
= RC:topict()
= RC:topict(S2)
= RC:topict(S2):sa("[RC][S2]")


--]==]


-- «RAng-test4»  (to ".RAng-test4")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "RAng1.lua"
define_MV1()

DFI = RAng.new [[
  \begin{array}{lrcl}
    \text{Se:}    &                <f(g(x))> &\eqnp{1}& <x> \\
    \text{Então:} & \frac{d}{d<x>} <f(g(x))> &\eqnp{2}& \frac{d}{d<x>} <x> \\
                                            &&\eqnp{3}& 1 \\
                  & \frac{d}{d<x>} <f(g(x))> &\eqnp{4}& <Mul(fp(g(x)),gp(x))> \\
                  & <Mul(fp(g(x)),gp(x))>    &\eqnp{5}& 1 \\
                  & <gp(x)>                  &\eqnp{6}& \D \frac{1}{<fp(g(x))>} \\
  \end{array}}
]]

DFIminus = RAng.new [[
  \begin{array}{lrcl}
    \text{Se:}    & f(g(x))       &\eqnp{1}& x \\
    \text{Então:} & g'(x)         &\eqnp{6}& \D \frac{1}{f'(g(x))} \\
  \end{array}}
]]


-- (c2m221dfip 3 "defs-DFIs")
-- (c2m221dfia   "defs-DFIs")
-- (find-angg "LUA/UbExpr2.lua")

lnp = function (x) return app("\\ln'", x) end

defsubst("S1", [[
      f(expr1)  := exp(expr1)
      fp(expr1) := exp(expr1)
      g(expr1)  := ln(expr1)
      gp(expr1) := lnp(expr1)
  ]])

= DFI:topict()  :sa("[DFI]")
= DFI:topict(S1):sa("[DFI][S1]")




--]==]





-- Local Variables:
-- coding:  utf-8-unix
-- End:

