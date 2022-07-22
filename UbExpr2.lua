-- This file:
--   http://angg.twu.net/LUA/UbExpr2.lua.html
--   http://angg.twu.net/LUA/UbExpr2.lua
--           (find-angg "LUA/UbExpr2.lua")
-- Author: Eduardo Ochs <eduardoochs@gmail.com>
--
-- This handles expressions for Calculus 2. 
--
-- See: (find-angg "LUA/UbExpr1.lua")
--      (find-anggfile "LUA/RAng1.lua")
--
-- (defun o  () (interactive) (find-angg "LUA/UbExpr1.lua"))
-- (defun l  () (interactive) (find-angg "LUA/UbExpr2.lua"))
-- (defun r  () (interactive) (find-angg "LUA/RAng1.lua"))
-- (defun rf () (interactive) (find-angg "LUA/RAngFormulas1.lua"))
--
-- (find-sh0 "cd ~/LUA/; cp -v Pict2e1.lua UbExpr1.lua UbExpr2.lua ~/LATEX/")
--
-- «.basic»		(to "basic")
-- «.define_MV1»	(to "define_MV1")
-- «.basic-tests»	(to "basic-tests")
-- «.subst»		(to "subst")
-- «.subst-tests»	(to "subst-tests")
-- «.defsubst-test»	(to "defsubst-test")




-- «basic»  (to ".basic")
-- (find-angg "LUA/UbExpr1.lua")
require           "UbExpr1"

app   = function (f, x) return UbExpr.from(nil, "<1>(<2>)",  f, x) end
mul   = function (a, b) return UbExpr.from(nil, "<1> <2>",   a, b) end
Mul   = function (a, b) return UbExpr.from(nil, "<1> · <2>", a, b) end
plus  = function (a, b) return UbExpr.from(nil, "<1> + <2>", a, b) end
minus = function (a, b) return UbExpr.from(nil, "<1> - <2>", a, b) end
exp   = function (a)    return UbExpr.from(nil, "e^{<1>}",   a)    end
paren = function (a)    return UbExpr.from(nil, "(<1>)",     a)    end
Paren = function (a)    return UbExpr.from(nil, "\\left(<1>\\right)", a) end
sen   = function (x)    return app("\\sen",  x) end
sin   = function (x)    return app("\\sin",  x) end
cos   = function (x)    return app("\\cos",  x) end
tan   = function (x)    return app("\\tan",  x) end
ln    = function (x)    return app("\\ln",   x) end
Intx  = function (a, b, body) return UbExpr.from(nil, "\\D \\Intx{<1>}{<2>}{<3>}", a, b, body) end
Intu  = function (a, b, body) return UbExpr.from(nil, "\\D \\Intu{<1>}{<2>}{<3>}", a, b, body) end
difx  = function (a, b, body) return UbExpr.from(nil,     "\\difx{<1>}{<2>}{<3>}", a, b, body) end
difu  = function (a, b, body) return UbExpr.from(nil,     "\\difu{<1>}{<2>}{<3>}", a, b, body) end
eq5  = function (a, b, c, d, e)
    return UbExpr.from(nil, [[
      \begin{array}{rcl}
        <1> &=& <2> \\
            &=& <3> \\
            &=& <4> \\
            &=& <5> \\
      \end{array} ]], a, b, c, d, e)
  end

isstring    = function (o) return type(o) == "string" end
isnumber    = function (o) return type(o) == "number" end
isatom      = function (o) return (isstring(o) or isnumber(o)) and o end
isvar       = function (o) return isstring(o) and o end
isapp_fmt   = app("f", "a").fmt
isapp_otype = otype(app("f", "a"))
isapp       = function (o) return otype(o) == isapp_otype and o.fmt == isapp_fmt end
isapp_f     = function (o) return isapp(o) and o[1] end
isapp_arg   = function (o) return isapp(o) and o[2] end
mapsubst    = function (S, o)
    o = shallowcopy(o)
    for i=1,#o do o[i] = S(o[i]) end
    return o
  end


-- «define_MV1»  (to ".define_MV1")
--
define_MV1 = function ()
    f     = function (x) return app("f",  x) end
    fp    = function (x) return app("f'", x) end
    g     = function (x) return app("g",  x) end
    gp    = function (x) return app("g'", x) end
    a,b,x,u = "a", "b", "x", "u"
    --
    -- From: (c2m221atisp 8 "formulas-mv-2022.1")
    --       (c2m221atisa   "formulas-mv-2022.1")
    MV1 = eq5(Intx  (a, b, mul(fp(g(x)), gp(x))),
              difx  (a, b, f(g(x))),
              minus (f(g(b)), f(g(a))),
              difu  (g(a), g(b), f(u)),
              Intx  (g(a), g(b), fp(u)))
  end


-- «basic-tests»  (to ".basic-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "UbExpr2.lua"
define_MV1()
= MV1

S0 = function (o)
    return ((isvar  (o) == "a") and 44)
        or ((isapp_f(o) == "f") and Mul(42, isapp_arg(o)))
        or (isatom(o) and o)
        or mapsubst(S0, o)
  end

S1 = function (o)
    return ((isvar  (o) == "a") and 2)
        or ((isvar  (o) == "b") and 3)
        or ((isapp_f(o) == "f")  and sen(S1(isapp_arg(o))))
        or ((isapp_f(o) == "f'") and cos(S1(isapp_arg(o))))
        or ((isapp_f(o) == "g")  and Mul(42, S1(isapp_arg(o))))
        or ((isapp_f(o) == "g'") and 42)
        or (isatom(o) and o)
        or mapsubst(S1, o)
  end

= isapp_f(g(42))
= isapp_f(gp(42)) == "g'"
= sen(42)
= cos(42)

= MV1
= S1(MV1)

--]==]


-- «subst»  (to ".subst")
-- (find-angg "LUA/Code.lua" "Code")
--

substdefault = function (o, S)
    return (isatom(o) and o) or mapsubst(S, o)
  end

substvar = function (o, varname, body)
    if isvar(o) == varname then return expr(body) end
  end
substf = function (o, funname, body)
    if isapp_f(o) == funname then
      return Code.ve(" expr1 => "..body)(isapp_arg(o))
    end
  end

substsplit = function (arrowstr)
    local left,right = arrowstr:match("^%s*(%S+)%s*:=(.*)$")
    if not left then error() end
    return left,right
  end
subst = function (o, arrowstr)
    local left,right = substsplit(arrowstr)
    local funname = left:match("^([^()]+)%(")
    if funname then return substf(o, funname, right) end
    return substvar(o, left, right)
  end

substbig = function (o, bigstr, S)
    for i,li in ipairs(splitlines(bigstr)) do
      if li:match("%S") then
        local result = subst(o, li)
        if result then return result end
      end
    end
    return substdefault(o, S)
  end

defsubst0 = function (name, bigstr)
    local fmt = "%s = function (o) return substbig(o, [[\n%s]], %s) end"
    return format(fmt, name, bigstr, name)
  end
defsubst = function (name, bigstr) eval(defsubst0(name, bigstr)) end

-- «subst-tests»  (to ".subst-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "UbExpr2.lua"
define_MV1()

= substsplit(" a := 42 ")
= substvar("a", "a", "sen(42)")
= substvar("b", "a", "sen(42)")
= substf(f(22), " f(expr1) := Mul(42, expr1) ")

S1 = function (o)
    return subst(o, " a         := 2                  ")
        or subst(o, " b         := 3                  ")
        or subst(o, " f(expr1)  := Mul(42, S1(expr1)) ")
        or subst(o, " f'(expr1) := 42                 ")
        or substdefault(o, S1)
  end

= S1(f(33))
= S1(f(f(33)))
= MV1
= S1(MV1)

Paren(MV1)

S2 = function (o)
    return substbig(o, [[
      a         := 2
      b         := 3
      f(expr1)  := Mul(42, S1(expr1))
      f'(expr1) := 42
    ]], S2)
  end
= S2(MV1)

--]==]


-- «defsubst-test»  (to ".defsubst-test")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "UbExpr2.lua"
define_MV1()

= defsubst0("S2", [[
      a         := 2
      b         := 3
      f(expr1)  := Mul(42, S2(expr1))
      f'(expr1) := 42
  ]])

defsubst("S2", [[
      a         := 2
      b         := 3
      f(expr1)  := Mul(42, S2(expr1))
      f'(expr1) := 42
  ]])

= MV1
= S2(MV1)

--]==]





-- (c2m221prp 4 "UbExpr-test")
-- (c2m221pra   "UbExpr-test")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "UbExpr2.lua"
dofile "Pict2e1.lua"
define_MV1()

= MV1
= MV1:topict()
= MV1:topict():dd()
= MV1:topict():sa("foo")
= Paren(MV1):topict():sa("foo")
= Paren(MV1):sa("foo")

--]==]







-- Local Variables:
-- coding:  utf-8-unix
-- End:

