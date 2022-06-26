-- This file:
--   http://angg.twu.net/LATEX/2022-1-C2-intro.lua.html
--   http://angg.twu.net/LATEX/2022-1-C2-intro.lua
--           (find-angg "LATEX/2022-1-C2-intro.lua")
-- Author: Eduardo Ochs <eduardoochs@gmail.com>
--
-- (defun e () (interactive) (find-angg "LATEX/2022-1-C2-intro.tex"))
-- (defun l () (interactive) (find-angg "LATEX/2022-1-C2-intro.lua"))

-- (find-sh0 "cp -v ~/LUA/Pict2e1.lua   ~/LATEX/")
-- (find-sh0 "cp -v ~/LUA/Pict2e1-1.lua ~/LATEX/")
-- (find-angg "LUA/Pict2e1-1.lua" "Nodes-test6")

require "Pict2e1"      -- (find-angg "LUA/Pict2e1.lua")
require "Pict2e1-1"    -- (find-angg "LUA/Pict2e1-1.lua")


PradClass.__index.sa = function (pis, name)
    local b = "\\sa{"..name.."}{{"
    local e = "}}"
    return PradSub({b=b, pis, e=e})
  end

-- Based on: (find-angg "LUA/Pict2e1-1.lua" "Nodes-test6")
--
test6_def_nts = function ()

  nds_addtexs = function ()
      nds:addtexs [[ dd \frac{d}{d\_}  sin \sin   cos \cos ]]
      nds:addtexs [[ *   ·   *1 ·    *2 ·                  ]]
      nds:addtexs [[ x1  x   x2 x    x3 x  x4 x            ]]
      nds:addtexs [[ t1  t   t2 t    t3 t                  ]]
      nds:addtexs [[ g1  g   g2 g                          ]]
      nds:addtexs [[ 42a 42  42b 42  42c 42                ]]
    end
  
  nds = Nodes.new()
  nds:addnodes(4, "                          6:=:                           ")
  nds:addnodes(3, "       1:dd:=                           11:*:=           ")
  nds:addnodes(2, " 0:x1:dd    2:f:dd             7:f':*         12:g':*    ")
  nds:addnodes(1, "                 4:g1:f          9:g2:f'        13:x4:g' ")
  nds:addnodes(0, "                    5:x2:g1         10:x3:g2             ")
  nds_addtexs()
  nds_0 = nds
  
  nds = Nodes.new()
  nds:addnodes(4, "                          6:=:                           ")
  nds:addnodes(3, "       1:dd:=                           11:*:=           ")
  nds:addnodes(2, " 0:t1:dd   2:sin:dd           7:cos:*         12:42c:*   ")
  nds:addnodes(1, "               4:g1:sin          9:g2:cos                ")
  nds:addnodes(0, "                    5:x2:g1         10:x3:g2             ")
  nds_addtexs()
  nds_1 = nds
  
  nds = Nodes.new()
  nds:addnodes(4, "                          6:=:                           ")
  nds:addnodes(3, "       1:dd:=                           11:*:=           ")
  nds:addnodes(2, " 0:t1:dd   2:sin:dd           7:cos:*         12:42c:*   ")
  nds:addnodes(1, "               4:*1:sin            9:*2:cos              ")
  nds:addnodes(0, "          3:42a:*1  5:x2:*1     8:42b:*2  10:x3:*2       ")
  nds_addtexs()
  nds_2 = nds
  
  nds = Nodes.new()
  nds:addnodes(4, "                          6:=:                                  ")
  nds:addnodes(3, "       1:dd:=                                       11:*:=      ")
  nds:addnodes(2, " 0:t1:dd   2:sin:dd             7:cos:*                12:42c:* ")
  nds:addnodes(1, "                 4:*1:sin              9:*2:cos                 ")
  nds:addnodes(0, "             3:42a:*1   5:t2:*1    8:42b:*2  10:t3:*2           ")
  nds_addtexs()
  nds_3 = nds
  
  -- Nodes with tags:
  nts_0 = nds_0:withsnodetags("dd *      ")
  nts_1 = nds_0:withsnodetags("x1 f f' g'")
  nts_2 = nds_1:withsnodetags("g1 g2     ")
  nts_3 = nds_2:withsnodetags("x2 x3     ")
  nts_4 = nds_3:withsnodetags("          ")

  nsa = function (nds, name) return nds:totex():pgat("p"):sa(name) end

end





--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "2022-1-C2-intro.lua"
test6_def_nts()
= nds_2
= nts_4
= nts_4:totex()
= nts_4:totex():pgat("p")
= nts_4:totex():pgat("p"):sa("F03")
= nsa(nts_4, "F03")

p = PictList {
    nsa(nts_0, "00"),
    nsa(nts_1, "01"),
    nsa(nts_2, "02"),
    nsa(nts_3, "03"),
    nsa(nts_4, "04"),
  }
= p
= p:tostringp()

--]]



-- Local Variables:
-- coding:  utf-8-unix
-- End:
