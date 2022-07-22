-- This file:
--   http://angg.twu.net/LUA/RAngFormulas1.lua.html
--   http://angg.twu.net/LUA/RAngFormulas1.lua
--           (find-angg "LUA/RAngFormulas1.lua")
-- Author: Eduardo Ochs <eduardoochs@gmail.com>
--
-- (defun o  () (interactive) (find-angg "LUA/UbExpr1.lua"))
-- (defun l  () (interactive) (find-angg "LUA/UbExpr2.lua"))
-- (defun r  () (interactive) (find-angg "LUA/RAng1.lua"))
-- (defun rf () (interactive) (find-angg "LUA/RAngFormulas1.lua"))

require "Pict2e1"    -- (find-angg "LUA/Pict2e1.lua")
require "UbExpr1"    -- (find-angg "LUA/UbExpr1.lua")
require "UbExpr2"    -- (find-angg "LUA/UbExpr2.lua")
require "RAng1"      -- (find-angg "LUA/RAng1.lua")


-- See:
-- (find-angg "LUA/RAng1.lua" "RAng-test4")
-- (c2m221dfip 3 "defs-DFIs")
-- (c2m221dfia   "defs-DFIs")
-- (c2m221ftp 2 "TFC2")
-- (c2m221fta   "TFC2")
-- (c2m221fda   "TFC2")
-- (c2m221dfip 4 "exercicio-1-resps")
-- (c2m221dfia   "exercicio-1-resps")

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




-- Local Variables:
-- coding:  utf-8-unix
-- End:
