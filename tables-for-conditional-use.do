// DO NOT FORGET TO SET PATH!
use "101innov.dta", clear

local phase_row analysis
local phase_col write

qui ds tool_`phase_row'_*, has(type byte)
local vlist_row `r(varlist)'
qui ds tool_`phase_col'_*, has(type byte)
local vlist_col `r(varlist)'

local llr=2+wordcount("`vlist_row'")
local llc=2+wordcount("`vlist_col'")

set trace on
set tracedepth 1
mata: T=J(`llr',`llc',.);
local Lr=length("tool_`phase_row'_")+1
local Lc=length("tool_`phase_col'_")+1
local rownames ""
local colnames ""
local ii 0
forval row=1/`llr'	{
	local n=substr("`: word `row' of `vlist_row''",`Lr',.)
	local rownames `rownames' `n'
//	macro list _rownames
	local `++ii'
	forval col=1/`llc'	{
		if `ii'==`col'	{
			local n=substr("`: word `col' of `vlist_col''",`Lc',.)
			local colnames `colnames' `n'
//			macro list _colnames
		}
		// if one-but-last column
		if `col'==`=`llc'-1'	{
			if `row'>=`=`llr'-1'	continue
			summ `: word `row' of `vlist_row'', mean
			scalar p=r(mean)
			mata: T[`row',`col']=st_numscalar("p")
			continue
		}
		// if last column
		if `col'==`llc'	{
			if `row'>=`=`llr'-1'	continue
			summ `: word `row' of `vlist_row'', mean
			scalar s=r(sum)
			mata: T[`row',`col']=st_numscalar("s")
			continue
		}
		// if one-but-last row
		if `row'==`=`llr'-1'	{
			if `col'>=`=`llc'-1'	continue
			summ `: word `col' of `vlist_col'', mean
			scalar p=r(mean)
			mata: T[`row',`col']=st_numscalar("p")
			continue
		}
		// if last row
		if `row'==`llr'	{
			if `col'>=`=`llc'-1'	continue
			summ `: word `col' of `vlist_col'', mean
			scalar s=r(sum)
			mata: T[`row',`col']=st_numscalar("s")
			continue
		}
		summ `: word `col' of `vlist_col'' if `: word `row' of `vlist_row''==1, mean
		scalar p=r(mean)
		mata: T[`row',`col']=st_numscalar("p")

	}
}
set trace off
mata:st_matrix("T",T)
matrix rownames T=`rownames' Average Users
matrix colnames T=`colnames' Average Users
matrix list T, format(%3.2f)

