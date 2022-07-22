-- This file:
--   http://angg.twu.net/LUA/Lazy3.lua.html
--   http://angg.twu.net/LUA/Lazy3.lua
--           (find-angg "LUA/Lazy3.lua")
-- Author: Eduardo Ochs <eduardoochs@gmail.com>
--
-- (defun a  () (interactive) (find-angg "LUA/Pict2e1.lua"))
-- (defun b  () (interactive) (find-angg "LUA/Pict2e1-1.lua"))
-- (defun ab () (interactive) (find-2b '(a) '(b)))
-- (defun et () (interactive) (find-angg "LATEX/2022pict2e.tex"))
-- (defun eb () (interactive) (find-angg "LATEX/2022pict2e-body.tex"))
-- (defun ao () (interactive) (find-angg "LATEX/2022pict2e.lua"))
-- (defun v  () (interactive) (find-pdftools-page "~/LATEX/2022pict2e.pdf"))
-- (defun tb () (interactive) (find-ebuffer (eepitch-target-buffer)))
-- (defun etv () (interactive) (find-wset "13o2_o_o" '(tb) '(v)))
-- (setenv "PICT2ELUADIR" "~/LATEX/")
--
-- (defun l2 () (interactive) (find-angg "LUA/Lazy2.lua"))
-- (defun l3 () (interactive) (find-angg "LUA/Lazy3.lua"))
-- (defun l4 () (interactive) (find-angg "LUA/Lazy4.lua"))

-- «.basic-ops»		(to "basic-ops")
-- «.Ang»		(to "Ang")
-- «.Ang-tests»		(to "Ang-tests")
-- «.underline-eval»	(to "underline-eval")
-- «.2022-1-C2-P1-fp»	(to "2022-1-C2-P1-fp")


require "Lazy2"    -- (find-angg "LUA/Lazy2.lua")
require "Pict2e1"  -- (find-angg "LUA/Pict2e1.lua")

-- (find-angg "LUA/Pict2e1.lua" "Pict2e-methods" "bshow =")
-- (find-angg "LUA/Lazy2.lua" "Lazy-topict")

Lazy.__index.texpreamble = [[
  \def\und#1#2{\underbrace{           #1}_{foo: #2}}
  \def\und#1#2{\underbrace{\mathstrut #1}_{#2}}
]]

-- «basic-ops»  (to ".basic-ops")
-- (find-angg "LUA/C2Subst1.lua" "basic-ops")
--
funs " ddx eq mul f g fp gp und "
vars " x y t "
fun("mul",   "<1> <2>")
fun("Mul",   "<1> · <2>")
fun("und",   "\\und{<1>}{<2>}")
fun("uu",    "\\und{<1>}{}")
fun("ddx",   "\\frac{d}{dx} <1>")
fun("ddvar", "\\frac{d}{d<1>} <2>")

fun("plus",  "<1> + <2>")
fun("minus", "<1> - <2>")
fun("eq",    "<1> = <2>")
fun("exp",   "e^{<1>}")
fun("pot",   "{<1>}^{<2>}")
fun("frac",  "\\frac{<1>}{<2>}")
fun("sqrt",  "\\sqrt{<1>}")
fun("paren", "(<1>)")
fun("Paren", "\\left(<1>\\right)")

fun("sen",   "\\sen <1>")
fun("sin",   "\\sin <1>")
fun("cos",   "\\cos <1>")
fun("tan",   "\\tan <1>")
fun("ln",    "\\ln <1>")
fun("lnp",   "\\ln' <1>")
fun("mod",   "|<1>|")
fun("uminus", "-<1>")

fun("sen",   "\\sen(<1>)")
fun("sin",   "\\sin(<1>)")
fun("cos",   "\\cos(<1>)")
fun("tan",   "\\tan(<1>)")

funs"f g h F G H"
vars"a b c t u x y z w"

fun("fp",    "f'(<1>)")
fun("gp",    "g'(<1>)")

fun("Intx",  "\\D \\Intx{<1>}{<2>}{<3>}")
fun("Intu",  "\\D \\Intu{<1>}{<2>}{<3>}")
fun("difx",      "\\difx{<1>}{<2>}{<3>}")
fun("difu",      "\\difu{<1>}{<2>}{<3>}")
fun("ddvar", "\\frac{d}{d<1>}<2>")
fun("intvar", "\\intvar{<1>}{<2>}")
fun("Intvar", "\\D \\Intvar{<1>}{<2>}{<3>}{<4>}")
fun("difvar", "\\difvar{<1>}{<2>}{<3>}{<4>}")

fun("intx",  "\\D \\intx{<1>}")
fun("intu",  "\\D \\intu{<1>}")
fun("inty",  "\\D \\inty{<1>}")

fun("substline", " <1> := <2> ")
-- expr1 = "\\Expr"
-- x0    = "x_0"


-- «Ang»  (to ".Ang")
-- (find-angg "LUA/Lazy2.lua" "Lazy-topict")
-- Superseded by: (find-angg "LUA/Lazy2.lua" "LazyAng-tests")
Ang = Class {
  type = "Ang",
  from = function (bigstr)
      local f = function (s) return totex(expr(s)) end
      local newstr = bigstr:gsub("<(.-)>", f)
      return Ang {bigstr=bigstr, newstr=newstr}
    end,
  __index = {
    show = function (ang)
        return Show.try(ang.newstr)
      end,
    sa = function (ang, name)
        return PictList({ ang.newstr }):sa(name)
      end,
  },
}

-- «Ang-tests»  (to ".Ang-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy3.lua"
ang = Ang.from([[
  Hello! $<RC>$
]])
= ang:show()
 (etv)

--]==]


-- (find-angg "LUA/Lazy2.lua" "Subst-tests")
vars " a b c u "

RC  = eq( ddx(f(g(x))),
          Mul(fp(g(x)), gp(x))
        )
MV2 = eq( Intvar(x, a, b, Mul(fp(g(x)), gp(x))),
          Intvar(u, g(a), g(b), fp(u))
        )

-- (c2m221p1p 3 "fracoes-parciais")
-- (c2m221p1a   "fracoes-parciais")
FP1   = eq(intx(frac(1,x)), ln(mod(x)))
FP2   = eq(intx(frac(1,plus(x,a))), intx(frac(1,u)))
FP234 = eq(intx(frac(1,plus(x,a))), ln(mod(plus(x,a))))

S1 = Subst.from [[
    if isapp(f)  then return sen(Sarg()) end
    if isapp(fp) then return cos(Sarg()) end
    if isapp(g)  then return mul(42,Sarg()) end
    if isapp(gp) then return 42 end
    if isvar(x)  then return t end
  ]]

define_SFPs = function ()
    sn = SubstName.from("SFPa", "SFP _a", [[
      if isapp(g)  then return plus(x, a) end
      if isapp(gp) then return 1 end
    ]], [[
       g(x) := x+a \\
      g'(x) := 1 \\
    ]])
    sn:output()
    sn:eval("verbose")
    --
    sn = SubstName.from("SFPb", "SFP _b", [[
      if isapp(g)  then return plus(x, a) end
      if isapp(gp) then return 1 end
      if isvar(a)  then return b end
      if isvar(b)  then return c end
    ]], [[
       g(x) := x+a \\
      g'(x) := 1 \\
          a := b \\
          b := c \\
    ]])
    sn:output()
    sn:eval("verbose")
    --
    sn = SubstName.from("SFPc", "SFP _c", [[
      if isapp(g)  then return plus(Sarg(), a) end
      if isapp(gp) then return 1 end
      if isapp(fp) then return frac(1, Sarg()) end
      if isvar(a)  then return b end
      if isvar(b)  then return c end
    ]])
    sn:output()
    sn:eval("verbose")
  end

--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy3.lua"
out = ""
output = function (str) out = out..str.."\n"; print(str) end
define_SFPs()

= FP1:tree()
= FP1:show()
= Paren(FP234)
= Paren(FP234):totex()

ang = Ang.from([[
  <out>
  $\scalebox{0.6}{$\begin{array}{cl}
      & [MV2] = <Paren(MV2)>          \\\relax
      & [FP1] = <Paren(FP1)>          \\\relax
      & [FP2] = <Paren(FP2)>          \\\relax
      & [FP234] = <Paren(FP234)>      \\\\
    \ga{[SFPa]} = \ga{[SFPa] big} & [MV2]<SFPa.s> = <Paren(SFPa(MV2))> \\\relax
    \ga{[SFPb]} = \ga{[SFPb] big} & [MV2]<SFPb.s> = <Paren(SFPb(MV2))> \\\relax
    \ga{[SFPc]} = \ga{[SFPc] big} & [MV2]<SFPc.s> = <Paren(SFPc(MV2))> \\\relax
    \end{array}
    $}
  $
]])
= ang:show()
= Show.log
 (etv)


 (etv)

= FP2
= FP2:tree()
= FP2:show()
= RC
= MV2
= MV2:show()
 (etv)

sn = SubstName.from("S1a", "S1 _a", [[
    if isapp(g)  then return plus(x, a) end
    if isapp(gp) then return 1 end
    -- if isvar(x)  then return t end
]])
sn:output()
sn:eval("verbose")
= S1a(MV2)
= S1a(MV2):tree()
= S1a(MV2):show()
 (etv)

sn = SubstName.from("S1b", "S1 _b", [[
    if isapp(g)  then return plus(x, a) end
    if isapp(gp) then return 1 end
    if isvar(a)  then return b end
    if isvar(b)  then return c end
]])
sn:output()
sn:eval("verbose")
= S1b(MV2)
= S1b(MV2):tree()
= S1b(MV2):show()
 (etv)

sn = SubstName.from("S1c", "S1 _c", [[
    if isapp(g)  then return plus(Sarg(), a) end
    if isapp(gp) then return 1 end
    if isapp(fp) then return frac(1, Sarg()) end
    if isvar(a)  then return b end
    if isvar(b)  then return c end
]])
sn:output()
sn:eval("verbose")
= S1c(MV2)
= S1c(MV2):tree()
= S1c(MV2):show()
 (etv)


-- Debug:
dofile "Repl1.lua"
r = EdrxRepl.new()
r:repl()

= MV2

dg = dgis
= dg
= dg[7]:info()
= dg[8]:info()
= dg[9]:info()
= dg[10]:info()
= dg[10]:vs()
= dg[10]:vs().arr
= PPP(dg[10]:vs().arr)

PPP(MV2)
= MV2:tree()





= und(x,y)
= und(x,y):totex()
= und(x,y):topictddpp()
= und(x,y):show()
-- = RC:show()
= S1(RC):show()
 (etv)

= S1
= S1:code()
=    RC :totree()
= S1(RC):totree()


o = f(x,mul(g(22), x))
= o
= o:totex()
= o:topict()
= o:topictddpp()
= o:show()
 (etv)


--]==]


-- «underline-eval»  (to ".underline-eval")

RCU = uu(eq(uu(ddvar(uu(x), uu(f(uu(g(uu(x))))))),
            uu(Mul(uu(fp(uu(g(uu(x))))), uu(gp(uu(x)))))))

SUE_S = S1
SDELU = Subst.from [[
    if isapp(uu) then return Sarg() end
  ]]
SUE = Subst.from [[
    if isapp(uu) then return und(Sarg(), SUE_S(SDELU(arg()))) end
  ]]

--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy3.lua"

=          RCU:tree()
=    SDELU(RCU):tree()
= S1(SDELU(RCU)):tree()


= SUE(RCU):tree()
= SDELU(RCU):show()
= S1(SDELU(RCU)):show()
 (etv)

=       RCU:show()

= SUE(RCU):show()
 (etv)

--]==]


-- «2022-1-C2-P1-fp»  (to ".2022-1-C2-P1-fp")
-- (c2m221p1p 3 "fracoes-parciais")
-- (c2m221p1a   "fracoes-parciais")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy3.lua"
vars " a b c u "

= MV2
= MV2:show()
 (etv)

FP2 = eq(Intx(b,c,frac(1,plus(x,a))),
         Intu(plus(b,a),plus(c,a),frac(1,u)))
= FP2
= FP2:tree()
= FP2:totex()
= FP2:show()
 (etv)
= Show.log

--]==]




-- Local Variables:
-- coding:  utf-8-unix
-- End:
