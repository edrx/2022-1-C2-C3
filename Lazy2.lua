-- This file:
--   http://angg.twu.net/LUA/Lazy2.lua.html
--   http://angg.twu.net/LUA/Lazy2.lua
--           (find-angg "LUA/Lazy2.lua")
-- Author: Eduardo Ochs <eduardoochs@gmail.com>
--
-- (defun l1 () (interactive) (find-angg "LUA/Lazy1.lua"))
-- (defun l2 () (interactive) (find-angg "LUA/Lazy2.lua"))
-- (defun l3 () (interactive) (find-angg "LUA/Lazy3.lua"))
-- (find-sh0 "cd ~/LUA/; cp -v Lazy2.lua Lazy3.lua Verbatim1.lua ~/LATEX/")

-- «.CName»		(to "CName")
-- «.CName-tests»	(to "CName-tests")
-- «.trimcode»		(to "trimcode")
-- «.trimcode-tests»	(to "trimcode-tests")
-- «.Lazy»		(to "Lazy")
--   «.Lazy-totex»	(to "Lazy-totex")
--   «.Lazy-topict»	(to "Lazy-topict")
-- «.Lazy-tests»	(to "Lazy-tests")
-- «.LazyAng»		(to "LazyAng")
-- «.LazyAng-tests»	(to "LazyAng-tests")
-- «.Subst»		(to "Subst")
-- «.Subst-tests»	(to "Subst-tests")
-- «.SubstName»		(to "SubstName")
-- «.SubstName-tests»	(to "SubstName-tests")

require "Pict2e1"    -- (find-angg "LUA/Verbatim1.lua" "Pict2e1")
require "Verbatim1"  -- (find-angg "LUA/Verbatim1.lua" "Verbatim1")


oerror = function (o, fmt, ...)
    PPP(o)
    -- error(fmt, ...)
    error(format(fmt, myunpack(map(mytostringp, {...}))))
  end

tolua = function (o)
    if type(o) == "number" then return tostring(o) end
    if type(o) == "string" then return format("%q", o) end
    if type(o) ~= "table"  then oerror(o, "Bad type to :tolua") end
    if not o.tolua then oerror(o, "No :tolua") end
    return o:tolua()
  end

totex = function (o)
    if type(o) == "number" then return tostring(o) end
    if type(o) == "string" then return o end
    if not o.totex then oerror(o, "No :totex") end
    return o:totex()
  end


--  _        _                         _      
-- | |_ _ __(_)_ __ ___   ___ ___   __| | ___ 
-- | __| '__| | '_ ` _ \ / __/ _ \ / _` |/ _ \
-- | |_| |  | | | | | | | (_| (_) | (_| |  __/
--  \__|_|  |_|_| |_| |_|\___\___/ \__,_|\___|
--                                            
-- «trimcode»  (to ".trimcode")
trimcode0 = function (bigstr, n)
    local lines = splitlines(rtrim(bigstr))
    lines = map(untabify, lines)
    lines = map(rtrim,    lines)
    if #lines == 0 then return VTable({}) end
    local initspaces = lines[1]:match("^( *)")
    n = n or #initspaces
    local f = function (li) return li:sub(n+1) end
    return VTable(map(f, lines))
  end
trimcode = function (bigstr, n)
    return table.concat(trimcode0(bigstr, n), "\n")
  end

-- «trimcode-tests»  (to ".trimcode-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy2.lua"
foo = [[
    bar
    plic
  ]]
= trimcode0(foo)
= trimcode(foo)

-- Debug:
dofile "Repl1.lua"
r = EdrxRepl.new()
r:repl()

= trimcode0(foo)
dg = dgis
= dg
= dg[9]
= dg[9]:info()

--]==]



-- «CName»  (to ".CName")
-- (find-LATEX "edrxgac2.tex" "C2-substnames")
CName = Class {
  type  = "CName",
  split = function (bodyaddons)
      local body,addons = unpack(split(bodyaddons))
      return body, addons or ""
    end,
  expand = function (name, bodyaddons, fmt)
      local n,b,a = name, CName.split(bodyaddons)
      return (fmt:gsub("<([nba])>", {n=n, b=b, a=a}))
    end,
  format = function (name, bodyaddons, fmt0, ...)
      local n,b,a = name, CName.split(bodyaddons)
      local fmt = fmt0:gsub("<([nba])>", {n=n, b=b, a=a})
      return format(fmt, ...)
    end,
  __index = {
  },
}

-- «CName-tests»  (to ".CName-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy4.lua"
= CName.expand("MV2", "MV _2", [=[\sa{[<n>]}{\CSname{<b>}{<a>}}]=])

var("x0", "x_0")
= x0
= x0:totex()
= MV2_:totex()

--]==]



--  _                    
-- | |    __ _ _____   _ 
-- | |   / _` |_  / | | |
-- | |__| (_| |/ /| |_| |
-- |_____\__,_/___|\__, |
--                 |___/ 
--
-- «Lazy»  (to ".Lazy")
Lazy = Class {
  type    = "Lazy",
  __tostring = function (la) return la:tolua() end,
  __index = {
    tolua = function (la)
        if la.kind == "var" then return la[0] end
        if la.kind == "ang" then return la[0] end
        if la.kind == "fun" then
          local args = mapconcat(tolua, la, ", ")
          return format("%s(%s)", la[0], args)
        end
        oerror(la, "No kind!")
      end,
    totree = function (la) return SynTree.from(la) end,
    tree   = function (la) return SynTree.from(la) end,
    --
    angparse0 = function (la)
        local fmt,values = LazyAng.parse0(la.fmt0)
	la.fmt = fmt
	for i,value in ipairs(values) do la[i] = value end
        return la
      end,
    --
    -- «Lazy-totex»  (to ".Lazy-totex")
    angfieldtrim = function (la, n)
        if type(n) ~= "string" then return n end
        return (n:gsub("^(%d+):.*$", "%1"))
      end,
    getfield = function (la, n)
        local o = la[tonumber(la:angfieldtrim(n))]
        if not o then oerror(la, "No field: %s", n) end
        return o
      end,
    fmtexpand = function (la, fmt, f)
        local gf = function (n) return f(la:getfield(n)) end
        return (fmt:gsub("<(.-)>", gf))
      end,
    totex_fmtexpand = function (la, fmt) return la:fmtexpand(fmt, totex) end,
    totex_args  = function (la) return mapconcat(totex, la, ", ") end,
    totex_pargs = function (la) return "("..la:totex_args()..")" end,
    totex_fun   = function (la) return la[0]..la:totex_pargs() end,
    totex       = function (la)
        local fmt = la.fmt
        if fmt then
          return la:totex_fmtexpand(fmt)
        end
	if not fmt then
          if la.kind == "var" then return la[0] end
          if la.kind == "fun" then return la:totex_fun() end
          oerror(la, "Bad kind!")
        end
      end,
    --
    -- «Lazy-topict»  (to ".Lazy-topict")
    -- (find-angg "LUA/Pict2e1.lua" "Pict2e-methods" "bshow =")
    texpreamble = "",
    topict     = function (la) return PictList({ la:totex() }) end,
    topictddp  = function (la) return la:topict():dd():tostringp() end,
    topictddpp = function (la) return la.texpreamble .. la:topictddp() end,
    show       = function (la) return Show.try(la:topictddpp()) end,
  },
}

--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy2.lua"
funs " ddx eq mul f g fp gp und "
vars " x y "
fun("mul",   "<1> · <2>")
fun("und",   "\\und{<1>}{<2>}")
fun("ddvar", "\\frac{d}{d<1>} <2>")

moo = Lazy {fmt="<1>+<2>", 22, "33"}
= moo:totex()
moo = Lazy {fmt="<1>+<2>", 22, x}
= moo:totex()
= f(x):totex()
= f(x,g(22)):totex()
= f(x,mul(g(22), x)):totex()
= f(x):getfield(0)
= f(x):getfield(1)
PPP(f(x))

moo = Lazy {fmt="<1:BLA()>+<2>", 22, x}
= moo:getfield(1)
= moo:getfield("1")
= moo:getfield("1:BLA()")

= mul(f(g(x)), 22, "foo"):totex()
= mul(f(g(x)), 22):totex()
= mul(x, 22):totex()
= mul(f(g(x)), 22, "foo"):totex()


--]]

ltype = function (o)
    if otype(o) == "Lazy" then return o.kind end
    return otype(o)
  end

fun0 = function (name, fmt)
    return function (...) return Lazy {kind="fun", fmt=fmt, [0]=name, ...} end
  end
var0 = function (name, fmt)
    return Lazy {kind="var", fmt=fmt, [0]=name}
  end

fun = function (name, fmt)
    _G[name] = function (...) return Lazy {kind="fun", fmt=fmt, [0]=name, ...} end
  end
var = function (name, fmt)
    _G[name] = Lazy {kind="var", [0]=name, fmt=fmt}
  end

funs = function (bigstr)
    for _,name in ipairs(split(bigstr)) do fun(name) end
  end
vars = function (bigstr)
    for _,name in ipairs(split(bigstr)) do var(name) end
  end

vareq = function (o1, o2)
    return ltype(o1) == "var"
       and ltype(o2) == "var"
       and o1[0] == o2[0]   -- vars with the same name
  end
funeq = function (o1, o2)
    return ltype(o1) == "fun"
       and ltype(o2) == "fun"
       and o1[0] == o2[0]   -- apps of the same function
  end
funarg = function (o, n)
    if ltype(o) ~= "fun" then oerror(o, "Not a Lazy fun!") end
    return o[n or 1]
  end

-- «Lazy-tests»  (to ".Lazy-tests")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy2.lua"

funs " ddx eq mul f g fp gp und "
vars " x y "
= f(22, "foo")
RC = eq(ddx(f(g(x))), mul(fp(g(x)), gp(x)))
= RC
= RC:tree()

--]]


--  _                       _                
-- | |    __ _ _____   _   / \   _ __   __ _ 
-- | |   / _` |_  / | | | / _ \ | '_ \ / _` |
-- | |__| (_| |/ /| |_| |/ ___ \| | | | (_| |
-- |_____\__,_/___|\__, /_/   \_\_| |_|\__, |
--                 |___/               |___/ 
--
-- «LazyAng»  (to ".LazyAng")
LazyAng = Class {
  type  = "LazyAng",
  parse0 = function (fmt0)
      local n,values = 0, VTable({})
      local addnumber = function (s)
          local value = expr(s)
          if not value then oerror(s, "returned nil") end
          n = n+1
          values[n] = value
          return "<"..n..":"..s..">"
        end
      local fmt = fmt0:gsub("<(.-)>", addnumber)
      return fmt,values
    end,
  from = function (name, bodyaddons, fmt0)
      return LazyAng {
        name=name, bodyaddons=bodyaddons, fmt0=fmt0,
        cfname=cfname, sa=sa
      }
    end,
  __index = {
    -- adapted from: (find-angg "LUA/Lazy2.lua" "SubstName")
    calcbigtex = function (la)
        la.bigtex = ang0(la.name, la.fmt0):totex()
        return la
      end,
    texdefs = function (la)
        local body,addons = unpack(split(la.bodyaddons))
        local name    = la.name
        local bigtex  = la.bigtex
        local cfname  = format("\\CFname{%s}{%s}", body, addons or "")
        local pbig    = format("\\left(\\ga{%s big}\\right)", name)
        local sa_name = format("\\sa{(%s)}{%s}", name, cfname)
        local sa_big  = format("\\sa{%s big}{%s}", name, bigtex)
        local sa_pbig = format("\\sa{(%s) big}{%s}", name, pbig)
        return format("%s\n%s\n%s", sa_name, sa_pbig, sa_big)
      end,
    output = function (la, verbose)
        local outstr = la:calcbigtex():texdefs()
        if verbose then print(outstr) end
        output(outstr)
        return la
      end,
    --
    luadefs = function (la)
        local name = la.name
        local fmt = trimcode [[
          %s = ang0("%s", [=[
          %s
          ]=])
          %s_     = var0("%s_",     "\\ga{(%s)}")
          %s.big  = var0("%s.big",  "\\ga{%s big}")
          %s.pbig = var0("%s.pbig", "\\ga{(%s) big}")
        ]]
        return format(fmt,
                      name, name, rtrim(la.fmt0),
                      name, name, name,
                      name, name, name,
                      name, name, name)
      end,
    eval = function (la, verbose)
        if verbose then print(la:luadefs()) end
        eval(la:luadefs())
        return la
      end,
  },
}

ang0 = function (name, fmt0)
    return Lazy({kind="ang", fmt0=rtrim(fmt0), [0]=name}):angparse0()
  end

ang = function (name, fmt0)
    _G[name] = ang0(name, fmt0)
  end

-- «LazyAng-tests»  (to ".LazyAng-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy2.lua"
dofile "Lazy3.lua"
output = print

la = LazyAng.from("See", "SEE _1", [[
  \text{Se $<fp(gp(x))>$ entao $<fp(y)>$}
]])
= la
= la:calcbigtex():texdefs()
= la:luadefs()
  la:output()
  la:eval()

= See
= See:tree()
= See:totex()
= See.big
= See.big:totex()
= See.pbig
= See.pbig:totex()

sn = SubstName.from("S1a", "S1 _a", [[
    if isapp(f)  then return sen(Sarg()) end
    if isapp(fp) then return cos(Sarg()) end
    if isapp(g)  then return mul(42,Sarg()) end
    if isapp(gp) then return 42 end
    if isvar(x)  then return t end
]], [[
  f(x) := \sen(x) \\
]])
sn:output()
sn:eval("verbose")
= S1a(See)          -- defective: outputs "See"
= S1a(See):tree()
= S1a(See):totex()

--]==]



--  ____        _         _   
-- / ___| _   _| |__  ___| |_ 
-- \___ \| | | | '_ \/ __| __|
--  ___) | |_| | |_) \__ \ |_ 
-- |____/ \__,_|_.__/|___/\__|
--                            
-- This class handles substitution operators, like this,
--   [S1] = [f(x) := sin(42x)]
-- that are defined from a single bigstr with several
-- lines of lua code like this one:
--   if isapp(f) then return sen(mul(42,Sarg())) end
-- For the version with more features, see:
--   (to "SubstName")
--
-- «Subst»  (to ".Subst")
Subst = Class {
  type = "Subst",
  fmt0 = "function (o,isvar,isapp,arg,Sarg)\n%s\n  end",
  fmt1 = "Subst.makerecursive(%s)",
  from = function (bigstr0) return
      Subst({bigstr=rtrim(bigstr0)}):compile()
    end,
  --
  makerecursive = function (S_core)
      local S
      S = function (o)
          if type(o) == "number" then return o end
          if type(o) == "string" then return o end
          local oisvar = function (v) return    vareq(o, v) end
          local oisapp = function (f) return    funeq(o, f("_")) end
          local oarg   = function (n) return   funarg(o, n)  end
          local oSarg  = function (n) return S(funarg(o, n)) end
          local Sresult = S_core(o,oisvar,oisapp,oarg,oSarg)
  	if Sresult then return Sresult end
          local o2 = shallowcopy(o)
          for i=1,#o2 do
            o2[i] = S(o2[i])
          end
          return o2
        end
      return S
    end,
  --
  __call = function (s, ...) return s.S(...) end,
  __tostring = function (s) return s.bigstr end,
  __index = {
    code = function (s)
        return format(Subst.fmt1, format(Subst.fmt0, s.bigstr))
      end,
    compile = function (s) s.S = expr(s:code()); return s end,
  },
}

-- «Subst-tests»  (to ".Subst-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy2.lua"

funs " ddx eq mul sen cos f g fp gp und "
vars " x y "
RC = eq(ddx(f(g(x))), mul(fp(g(x)), gp(x)))
= RC:tree()

S1 = Subst.from [[
    if isapp(f)  then return sen(Sarg()) end
    if isapp(fp) then return cos(Sarg()) end
    if isapp(g)  then return mul(42,Sarg()) end
    if isapp(gp) then return 42 end
    if isvar(x)  then return t end
  ]]

= S1
= S1:code()
=    RC :totree()
= S1(RC):totree()

--]==]


--  ____        _         _   _   _                      
-- / ___| _   _| |__  ___| |_| \ | | __ _ _ __ ___   ___ 
-- \___ \| | | | '_ \/ __| __|  \| |/ _` | '_ ` _ \ / _ \
--  ___) | |_| | |_) \__ \ |_| |\  | (_| | | | | | |  __/
-- |____/ \__,_|_.__/|___/\__|_| \_|\__,_|_| |_| |_|\___|
--                                                       
-- «SubstName»  (to ".SubstName")
-- See: (to "Subst")
--      (find-LATEX "edrxgac2.tex" "C2-substnames")
--      (find-angg "LUA/Verbatim1.lua" "Verbatim-tests")
--
SubstName = Class {
  type    = "SubstName",
  from    = function (name, bodyaddons, code, texdefbody)
      local body,addons = unpack(split(bodyaddons))
      local csname    = format("\\CSname{%s}{%s}", body, addons or "")
      local sa        = format("\\sa{[%s]}{%s}", name, csname)
      return SubstName {
        name=name, bodyaddons=bodyaddons, code=code,
        csname=csname, sa=sa, texdefbody=texdefbody
      }
    end,
  __index = {
    defverbatim = function (sn)
        local name  = format("[%s] verbatim", sn.name)
        local lines = trimcode0(sn.code)
        local vb = Verbatim.from(lines):act("e h c p v bg")
        local sa = vb:sa(name).o
        return sa
      end,
    texdefs = function (sn)
        local out = format("%s\n%s", sn.sa, sn:defverbatim())
        if sn.texdefbody then
          out = out
             .. format("\n\\sa{[%s] bmat}{\\bmat{\n%s}}", sn.name, sn.texdefbody)
             .. format("\n\\sa{[%s] bsm}{\\bsm{\n%s}}", sn.name, sn.texdefbody)
        end
        return out
      end,
    output = function (sn, verbose)
        output(sn:texdefs(), verbose)
        return sn
      end,
    --
    luadefs = function (sn)
        local name = sn.name
        local fmt = trimcode [[
          %s = Subst.from [=[
          %s
          ]=]
          %s.bmat = var0("%s.bmat", "\\ga{[%s] bmat}")
          %s.bsm  = var0("%s.bsm",  "\\ga{[%s] bsm}")
          %s.p = fun0("%s.p", "<1> \\ga{[%s]}")
          %s.P = fun0("%s.P", "\\left(<1>\\right) \\ga{[%s]}")
          %s.s = var0("%s.s", "\\ga{[%s]}")
          %s_  = var0("%s.s", "\\ga{[%s]}")
        ]]
        return format(fmt,
                      name, rtrim(sn.code),
                      name, name, name,
                      name, name, name,
                      name, name, name,
                      name, name, name,
                      name, name, name,
                      name, name, name)
      end,
    eval = function (sn, verbose)
        if verbose then print(sn:luadefs()) end
        eval(sn:luadefs())
        return sn
      end,
  },
}

-- «SubstName-tests»  (to ".SubstName-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy2.lua"
output = print

sn = SubstName.from("S1a", "S1 _a", [[
    if isapp(f)  then return sen(Sarg()) end
    if isapp(fp) then return cos(Sarg()) end
    if isapp(g)  then return mul(42,Sarg()) end
    if isapp(gp) then return 42 end
    if isvar(x)  then return t end
]], [[
  f(x) := \sen(x) \\
]])
sn:output()
sn:eval("verbose")

-- (find-angg "LUA/Lazy3.lua" "basic-ops")
require "Lazy3"

-- funs " ddx eq mul sen cos f g fp gp und "
-- vars " x y "
RC = eq(ddx(f(g(x))), mul(fp(g(x)), gp(x)))
=     RC
=     RC :totree()
= S1a
= S1a:code()
= S1a(RC):totree()

= S1a.p(22)
= S1a.p(22):totex()
= S1a.P(22)
= S1a.P(22):totex()
= S1a.s
= S1a.s:totex()

--]==]




-- Local Variables:
-- coding:  utf-8-unix
-- End:
