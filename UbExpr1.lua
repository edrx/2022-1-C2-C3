-- This file:
--   http://angg.twu.net/LUA/UbExpr1.lua.html
--   http://angg.twu.net/LUA/UbExpr1.lua
--           (find-angg "LUA/UbExpr1.lua")
-- Author: Eduardo Ochs <eduardoochs@gmail.com>
--
-- Expressions with underbraces.
--
-- (defun o  () (interactive) (find-angg "LUA/UbExpr1.lua"))
-- (defun l  () (interactive) (find-angg "LUA/UbExpr2.lua"))
-- (defun r  () (interactive) (find-angg "LUA/RAng1.lua"))
-- (defun rf () (interactive) (find-angg "LUA/RAngFormulas1.lua"))



UbExpr = Class {
  type = "UbExpr",
  from = function (u, fmt, ...)
      return UbExpr {u=u, fmt=fmt, ...}
    end,
  __tostring = function (ue) return ue:tostring2() end,
  __index = {
    get = function (ue, str)
        local a = str:match("^<(%d)>$")
        if a then return tostring(ue[tonumber(a)]) or error("No field "..tostring(str)) end
        if str == "<u>" and ue.u then return tostring(ue.u) end
        error(format("UbExpr object can't handle :get(\"%s\")", str)) 
      end,
    format0 = function (ue, fmt)
        local f = function (str) return ue:get(str) end
        return (fmt:gsub("<.->", f))
      end,
    format1 = function (ue, fieldname)
        if ue[fieldname] then return ue:format0(ue[fieldname]) end
      end,
    formatn = function (ue, ...)
        local fieldnames = {...}
        for i,fieldname in ipairs(fieldnames) do
          local result = ue:format1(fieldname)
          if result then return result end
        end
        error("None of these fields exist: "..mytostring(fieldnames))
      end,
    tostring1 = function (ue)
        return ue:formatn("fmt")
      end,
    tostring2 = function (ue)
        if ue.u then
          local over, under = ue:tostring1(), tostring(ue.u)
          return format("\\und{%s}{%s}", over, under)
        else
          return ue:tostring1()
        end
      end,
    tostring = function (ue) return ue:tostring2() end,
    topict = function (ue) return PictList({ue:tostring()}) end,
    sa = function (ue, name) return ue:topict():sa(name) end,
  },
}



--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "UbExpr1.lua"
es = UbExpr {"foo", "bar", bpa="<2>+<1>", asb="<1>*<2>"}
= es:get("<2>")
= es:format0(es.bpa)
= es:format1("bpa")
= es:format1("asb")
= es:formatn("foo", "bpa", "bletch")
= es:formatn("foo", "asb", "bpa", "bletch")

aa = UbExpr {fmt="<1> + <2>", 22, 33}
bb = UbExpr {fmt="<1> · <2>", 44, 55, u=aa}
= aa
= bb

plus  = function (u, a, b) return UbExpr.from(u, "<1> + <2>", a, b) end
times = function (u, a, b) return UbExpr.from(u, "<1> · <2>", a, b) end
equal = function (u, a, b) return UbExpr.from(u, "<1> = <2>", a, b) end
paren = function (u, a)    return UbExpr.from(u, "(<1>)", a) end
und   = function (u, a)    return UbExpr.from(u, "<1>", a) end
app   = function (u, f, a) return UbExpr.from(u, "<1>(<2>)", f, a) end
ddvar = function (u, var, body) return UbExpr.from(u, "\\frac{d}{d<1>} <2>", var, body) end
sin   = function (u, a)   return UbExpr.from(u, "\\sin(<1>)", a) end
cos   = function (u, a)   return UbExpr.from(u, "\\cos(<1>)", a) end
= plus(nil, 22, 33)
= ddvar(nil, "x", plus(22, 33))
= ddvar(nil, "x", paren(plus(22, 33)))
= ddvar(nil, "x", "foo")



agx,afgx,aleft = nil
afpgx,agpx,aright,aeq = nil

ax     = "x"
agx    = times(nil, "42", "x")
afgx   = app  (nil, "\\sin", agx)
aleft  = ddvar(nil, "x", afgx)
afpgx  = app  (nil, "\\cos", agx)
agpx   = 42
aright = times(nil, afpgx, agpx)
aeq    = equal(nil, aleft, aright)

= aeq

ex     = und  (ax,    "x")
egx    = app  (agx,   "g", ex)
efgx   = app  (afgx,  "f", egx)
eleft  = ddvar(aleft, ex,  efgx)

efpgx  = app  (afpgx, "f'", egx)
egpx   = app  (agpx,  "g'", ex)
eright = times(aright, efpgx, egpx)
eeq    = equal(aeq,    eleft, eright)

= eeq



= edfgx

e4 = app(nil, "g", "x")
e5 = app(nil, "f'", e4)
e6 = app(nil, "g'", "x")
e7 = times(nil, e5, e6)
e8 = equal(nil, e3, e7)

= e8

e3 = ddvar(nil, ex, e2)
= e1
= e2
= e3

--]]









-- Local Variables:
-- coding:  utf-8-unix
-- End:

