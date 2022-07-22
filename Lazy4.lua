-- This file:
--   http://angg.twu.net/LUA/Lazy4.lua.html
--   http://angg.twu.net/LUA/Lazy4.lua
--           (find-angg "LUA/Lazy4.lua")
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

-- «.output»			(to "output")
-- «.fracoes-parciais»		(to "fracoes-parciais")
-- «.fracoes-parciais-test»	(to "fracoes-parciais-test")
-- «.MT2»			(to "MT2")
-- «.MT2-tests»			(to "MT2-tests")
-- «.EDOVSG»			(to "EDOVSG")
-- «.EDOVS»			(to "EDOVS")


require "Lazy2"     -- (find-angg "LUA/Lazy2.lua")
require "Lazy3"     -- (find-angg "LUA/Lazy2.lua")
require "Pict2e1"   -- (find-angg "LUA/Pict2e1.lua")
require "Verbatim1" -- (find-angg "LUA/Verbatim.lua")

-- (find-angg "LUA/Lazy2.lua" "SubstName-tests")

-- «output»  (to ".output")
out = ""
if not output then
  output = function (str, verbose)
      if verbose then print(); print(str) end
      out = out.."\n"..str
    end
  verbose = false
end



-- (find-angg "LUA/Lazy2.lua" "LazyAng")
-- (find-angg "LUA/Lazy2.lua" "SubstName-tests")
defexpr = function (name, bodyaddons, expr0)
    _G[name]      = expr0
    output(CName.expand(name, bodyaddons, [=[\sa{[<n>]}{\CFname{<b>}{<a>}}]=]))
    var(name.."_", CName.expand(name, bodyaddons, [[\CFname{<b>}{<a>}]]))
  end
defang = function (name, bodyaddons, fmt0)
    la = LazyAng.from(name, bodyaddons, fmt0)
    la:output(verbose)
    la:eval(verbose)
  end
defsubst = function (name, bodyaddons, code, texdefbody)
    sn = SubstName.from(name, bodyaddons, code, texdefbody)
    sn:output(verbose)
    sn:eval(verbose)
  end

-- verbose = true

defexpr("RC",  "RC",    eq( ddx(f(g(x))), Mul(fp(g(x)), gp(x))))
defexpr("MV2", "MV _2", eq( Intvar(x, a, b, Mul(fp(g(x)), gp(x))),
                            Intvar(u, g(a), g(b), fp(u))))

-- «fracoes-parciais»  (to ".fracoes-parciais")
-- (c2m221p1p 3 "fracoes-parciais")
-- (c2m221p1a   "fracoes-parciais")
defexpr("FP1", "FP _1", eq(intx(frac(1,x)), ln(mod(x))))
defexpr("FP2", "FP _2", eq(intx(frac(1,plus(x,a))), intx(frac(1,u))))
defexpr("FP234", "FP _{234}", eq(intx(frac(1,plus(x,a))), ln(mod(plus(x,a)))))

S1 = Subst.from [[
    if isapp(f)  then return sen(Sarg()) end
    if isapp(fp) then return cos(Sarg()) end
    if isapp(g)  then return mul(42,Sarg()) end
    if isapp(gp) then return 42 end
    if isvar(x)  then return t end
  ]]

defsubst("SFPa", "SFP _a", [[
    if isapp(g)  then return plus(Sarg(), a) end
    if isapp(gp) then return 1 end
  ]], [[
     g(x) := x+a \\
    g'(x) := 1 \\
  ]])

defsubst("SFPb", "SFP _b", [[
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

defsubst("SFPc", "SFP _c", [[
    if isapp(g)  then return plus(Sarg(), a) end
    if isapp(gp) then return 1 end
    if isapp(fp) then return frac(1, Sarg()) end
    if isvar(a)  then return b end
    if isvar(b)  then return c end
  ]], [[
     g(x) := x+a \\
    g'(x) := 1 \\
    f'(x) := \frac{1}{x} \\
        a := b \\
        b := c \\
  ]])

defsubst("SFPa3", "SFP _3", [[
    if isvar(a)  then return 3 end
  ]], [[
    a := 3 \\
  ]])
defsubst("SFPa5", "SFP _5", [[
    if isvar(a)  then return 5 end
  ]], [[
    a := 3 \\
  ]])

defexpr("FPa3", "FP _{a=3}", SFPa3(FP234))
defexpr("FPa5", "FP _{a=5}", SFPa5(FP234))

-- «fracoes-parciais-test»  (to ".fracoes-parciais-test")
-- (c2m221p1p 3 "fracoes-parciais")
-- (c2m221p1a   "fracoes-parciais")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy4.lua"
= RC
= RC:tree()
= RC:show()
= RC_:show()
 (etv)

 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy4.lua"
verbose = true
dofile "Lazy4.lua"

 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy4.lua"
ang = Ang.from([[
  <out>
  $\scalebox{0.6}{$\begin{array}{cl}
      & <MV2_>   = <Paren(MV2)>          \\
      & <FP1_>   = <Paren(FP1)>          \\
      & <FP2_>   = <Paren(FP2)>          \\
      & <FP234_> = <Paren(FP234)>      \\\\
    <SFPa_> = <SFPa.bsm> & <SFPa.p(MV2_)> = <Paren(SFPa(MV2))> \\
    <SFPb_> = <SFPb.bsm> & <SFPb.p(MV2_)> = <Paren(SFPb(MV2))> \\
    <SFPc_> = <SFPc.bsm> & <SFPc.p(MV2_)> = <Paren(SFPc(MV2))> \\
      % \ga{[SFPa] verbatim} \\
    \end{array}
    $}
  $
]])
= ang:sa("foo")
= ang:show()
= Show.log
 (etv)

 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy4.lua"
= FP234
= FPa3
= FPa3_
= FPa3_:totex()
= FPa5
= FPa5_:totex()
= SFPa3(FP234)
= SFPa5(FP234)

ang = Ang.from([[
  <out>
  $\begin{array}{c}
     <FPa3_> = <FP234_><SFPa3.bmat> = <Paren(SFPa3(FP234))>  \\
     <FPa5_> = <FP234_><SFPa5.bmat> = <Paren(SFPa5(FP234))>  \\
   \end{array}
  $
]])
= ang:sa("foo")
= ang:show()
= Show.log
 (etv)

= out

--]==]



-- «MT2»  (to ".MT2")
-- (c2m221mt2p 2 "questao-E1")
-- (c2m221mt2a   "questao-E1")

defexpr("MT2", "MT2",
        eq( intx(mul(pot(sen(mul(4,x)),5), cos(mul(4,x)))),
            mul(frac(1,4),intu(uu(pot(uu(u),5))))
          ))

defexpr("MT2", "MT2",
        eq( intx(mul(pot(sen(mul(4,x)),5), cos(mul(4,x)))),
            mul(frac(1,4),intu(pot(u,5)))
          ))

defsubst("SMV2a", "SMV2 _a", [[
    if isapp(g)  then return sen(mul(4,Sarg())) end
    if isapp(gp) then return mul(4,cos(mul(4,Sarg()))) end
  ]], [[
     g(x) := \sen(4x) \\
    g'(x) := 4\cos(4x) \\
  ]])

defsubst("SMV2b", "SMV2 _b", [[
    if isapp(g)  then return sen(mul(4,Sarg())) end
    if isapp(gp) then return mul(4,cos(mul(4,Sarg()))) end
    if isapp(fp) then return pot(Sarg(),5) end
  ]], [[
     g(x) := \sen(4x) \\
    g'(x) := 4\cos(4x) \\
    f'(u) := u^5 \\
  ]])

defsubst("SMV2c", "SMV2 _c", [[
    if isapp(g)  then return sen(mul(4,Sarg())) end
    if isapp(gp) then return mul(4,cos(mul(4,Sarg()))) end
    if isapp(fp) then return mul(frac(1,4),pot(Sarg(),5)) end
  ]], [[
     g(x) := \sen(4x) \\
    g'(x) := 4\cos(4x) \\
    f'(u) := \frac{1}{4}u^5 \\
  ]])

-- defexpr("MV2u", "MV _2", eq( Intvar(x, a, b, Mul(fp(g(x)), gp(x))),
--                              Intvar(u, g(a), g(b), fp(u))))
-- defexpr("MV2u", "MV _2", eq( Intvar(x, a, b, Mul(uu(fp(uu(g(x)))), uu(gp(x)))),
--                              Intvar(u, uu(g(a)), uu(g(b)), uu(fp(u)))))

-- «MT2-tests»  (to ".MT2-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy4.lua"

= MT2:tree()
= MV2:tree()
= SMV2c(MV2):tree()

ang = Ang.from([[
  <out>
  $\scalebox{0.7}{$\begin{array}{c}
     <MT2_> = <Paren(MT2)>  \\
     <MV2_> = <Paren(MV2)>  \\
     <MV2_><SMV2a.bsm> = <Paren(SMV2a(MV2))> \\
     <MV2_><SMV2b.bsm> = <Paren(SMV2b(MV2))> \\
     <MV2_><SMV2c.bsm> = <Paren(SMV2c(MV2))> \\
   \end{array}
   $}
  $
]])
= ang:show()
= Show.log
 (etv)


= MT2
= MV2u:show()
= Show.log
 (etv)

--]==]


-- «EDOVSG»  (to ".EDOVSG")
var("C1", "C_1")
var("C2", "C_2")
var("C3", "C_3")
fun("Hinv", "H^{-1}(<1>)")
output [[ \def\mcc#1{\multicolumn{1}{c}{#1}} ]]

defang("EDOVSG", "EDOVSG", [[
  \left(\begin{array}{rcl}
             \D \dydx &=& \D <frac(g(x),h(y))> \\
           <h(y)>\,dy &=& <g(x)>\,dx \\
         <inty(h(y))> &=& <intx(g(x))> \\
           \mcc{\veq} & & \mcc{\veq} \\
\mcc{<plus(H(y),C1)>} & & \mcc{<plus(G(x),C2)>} \\
          <H(y)>      &=& <plus(G(x),minus(C2,C1))> \\
                      &=& <plus(G(x),C3)> \\
         <Hinv(H(y))> &=& <Hinv(plus(G(x),C3))> \\
           \mcc{\veq} & & \\
              \mcc{y} & & \\
   \end{array}
   \right)
]])

defang("EDOVSP", "EDOVSP", [[
  \left(\begin{array}{rcl}
             \D \dydx &=& \D <frac(g(x),h(y))> \\
         <Hinv(H(y))> &=& <Hinv(plus(G(x),C3))> \\
           \mcc{\veq} & & \\
              \mcc{y} & & \\
   \end{array}
   \right)
]])

defsubst("SE1", "SE _1", [[
    if isapp(g)    then return uminus(mul(2,Sarg())) end
    if isapp(G)    then return uminus(pot(Sarg(),2)) end
    if isapp(h)    then return mul(2,Sarg()) end
    if isapp(H)    then return pot(Sarg(),2) end
    if isapp(Hinv) then return uminus(sqrt(Sarg())) end
    if isvar(C1)   then return 4 end
    if isvar(C2)   then return 29 end
    if isvar(C3)   then return 25 end
  ]], [[
     g(x) := -2x \\
     h(y) := 2y \\
     G(x) := -x^2 \\
     H(y) := y^2 \\
     H^{-1}(x) := -\sqrt{x} \\
     C1 := 4 \\
     C2 := 29 \\
     C3 := 25 \\
  ]])

-- «EDOVS»  (to ".EDOVS")
-- (c2m211edovsp 8 "EDOVSG")
-- (c2m211edovsa   "EDOVSG")
-- (find-pdftoolsr-page "~/LATEX/2021-1-C2-edovs.pdf" 8)
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy4.lua"
verbose = true
dofile "Lazy4.lua"

= SE1(22)
= SE1(H(22))

ang = Ang.from([[
  <out>
  % \def\mcc#1{\multicolumn{1}{c}{#1}}
  $\scalebox{0.6}{$
   \begin{array}{rcl}
     <EDOVSG_><SE1.bmat> &=& <SE1(EDOVSG)> \\
     <EDOVSP_> &=& <SE1(EDOVSP)> \\
   \end{array}
   $}
  $
]])
= ang:show()
= Show.log
 (etv)

--]==]





-- Local Variables:
-- coding:  utf-8-unix
-- End:
