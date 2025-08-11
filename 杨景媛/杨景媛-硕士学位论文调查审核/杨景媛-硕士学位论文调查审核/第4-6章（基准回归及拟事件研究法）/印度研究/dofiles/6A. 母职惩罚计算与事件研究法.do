*---------------------------------------*
*				印度样本(DHS)				*
*				 母职惩罚					*
*				  杨景媛		 			*
*				2024.03.14				*
*---------------------------------------*

cd $temp


// 1. 母职惩罚变量计算
{
use $data/pseudo, clear
gen T4 = interviewy - firstbirth
gen T3 = T4 - 10 if interviewy == 2015
replace T3 = T4 - 11 if interviewy == 2016

reshape long dv work T, i(caseid) j(wave)

gen T_4 = 1 if T <= -4
	replace T_4 = 0 if T_4 == .
gen T_3 = 1 if T == -3
	replace T_3 = 0 if T_3 == .
gen T_2 = 1 if T == -2
	replace T_2 = 0 if T_2 == .
gen T_1 = 1 if T == -1
	replace T_1 = 0 if T_1 == .
	
forvalues i=0(1)4{
	gen T`i' = 1 if T == `i'
	replace T`i' = 0 if T`i' == .
}

replace T4 = 1 if T >= 4

encode caseid, gen(id)
xtset id wave

save $data/temppseudo, replace

forvalues i=1(1)3{
use $data/temppseudo, clear
keep if state == `i'
reghdfe work T_4 T_3 T_2 T0 T1 T2 T3 T4 if childnum <= 2, a(wave UR birthy edu)
est sto m1

// coefplot m1, drop(_cons) vertical ciopts(recast(rcap))name(state`i', replace) 

gen coefT_4 = _b[T_4]
gen coefT_3 = _b[T_3]
gen coefT_2 = _b[T_2]
gen coefT0 = _b[T0]
gen coefT1 = _b[T1]
gen coefT2 = _b[T2]
gen coefT3 = _b[T3]
gen coefT4 = _b[T4]

collapse (mean) coefT_4 coefT_3 coefT_2 coefT0 coefT1 coefT2 coefT3 coefT4 , by(state)

gen diff_4 = 0 - coefT_4
gen diff_3 = 0 - coefT_3
gen diff_2 = 0 - coefT_2
gen diff0 = 0 - coefT0
gen diff1 = 0 - coefT1
gen diff2 = 0 - coefT2
gen diff3 = 0 - coefT3
gen diff4 = 0 - coefT4

egen cp1 = rowmean(diff_4 diff_3 diff_2)
egen cp2 = rowmean(diff0 diff1 diff2 diff3 diff4)
gen cp = cp2 - cp1
keep state cp

save state`i', replace

}


forvalues i=5(1)17{
use $data/temppseudo, clear
keep if state == `i'
reghdfe work T_4 T_3 T_2 T0 T1 T2 T3 T4 if childnum <= 2, a(wave UR birthy edu)
est sto m1

// coefplot m1, drop(_cons) vertical ciopts(recast(rcap))name(state`i', replace) 

gen coefT_4 = _b[T_4]
gen coefT_3 = _b[T_3]
gen coefT_2 = _b[T_2]
gen coefT0 = _b[T0]
gen coefT1 = _b[T1]
gen coefT2 = _b[T2]
gen coefT3 = _b[T3]
gen coefT4 = _b[T4]

collapse (mean) coefT_4 coefT_3 coefT_2 coefT0 coefT1 coefT2 coefT3 coefT4 , by(state)

gen diff_4 = 0 - coefT_4
gen diff_3 = 0 - coefT_3
gen diff_2 = 0 - coefT_2
gen diff0 = 0 - coefT0
gen diff1 = 0 - coefT1
gen diff2 = 0 - coefT2
gen diff3 = 0 - coefT3
gen diff4 = 0 - coefT4

egen cp1 = rowmean(diff_4 diff_3 diff_2)
egen cp2 = rowmean(diff0 diff1 diff2 diff3 diff4)
gen cp = cp2 - cp1
keep state cp

save state`i', replace

}

forvalues i=19(1)24{
use $data/temppseudo, clear
keep if state == `i'
reghdfe work T_4 T_3 T_2 T0 T1 T2 T3 T4 if childnum <= 2, a(wave UR birthy edu)
est sto m1

// coefplot m1, drop(_cons) vertical ciopts(recast(rcap))name(state`i', replace) 

gen coefT_4 = _b[T_4]
gen coefT_3 = _b[T_3]
gen coefT_2 = _b[T_2]
gen coefT0 = _b[T0]
gen coefT1 = _b[T1]
gen coefT2 = _b[T2]
gen coefT3 = _b[T3]
gen coefT4 = _b[T4]

collapse (mean) coefT_4 coefT_3 coefT_2 coefT0 coefT1 coefT2 coefT3 coefT4 , by(state)

gen diff_4 = 0 - coefT_4
gen diff_3 = 0 - coefT_3
gen diff_2 = 0 - coefT_2
gen diff0 = 0 - coefT0
gen diff1 = 0 - coefT1
gen diff2 = 0 - coefT2
gen diff3 = 0 - coefT3
gen diff4 = 0 - coefT4

egen cp1 = rowmean(diff_4 diff_3 diff_2)
egen cp2 = rowmean(diff0 diff1 diff2 diff3 diff4)
gen cp = cp2 - cp1
keep state cp

save state`i', replace

}


forvalues i=27(1)30{
use $data/temppseudo, clear
keep if state == `i'
reghdfe work T_4 T_3 T_2 T0 T1 T2 T3 T4 if childnum <= 2, a(wave UR birthy edu)
est sto m1

// coefplot m1, drop(_cons) vertical ciopts(recast(rcap))name(state`i', replace) 

gen coefT_4 = _b[T_4]
gen coefT_3 = _b[T_3]
gen coefT_2 = _b[T_2]
gen coefT0 = _b[T0]
gen coefT1 = _b[T1]
gen coefT2 = _b[T2]
gen coefT3 = _b[T3]
gen coefT4 = _b[T4]

collapse (mean) coefT_4 coefT_3 coefT_2 coefT0 coefT1 coefT2 coefT3 coefT4 , by(state)

gen diff_4 = 0 - coefT_4
gen diff_3 = 0 - coefT_3
gen diff_2 = 0 - coefT_2
gen diff0 = 0 - coefT0
gen diff1 = 0 - coefT1
gen diff2 = 0 - coefT2
gen diff3 = 0 - coefT3
gen diff4 = 0 - coefT4

egen cp1 = rowmean(diff_4 diff_3 diff_2)
egen cp2 = rowmean(diff0 diff1 diff2 diff3 diff4)
gen cp = cp2 - cp1
keep state cp

save state`i', replace

}


forvalues i=32(1)33{
use $data/temppseudo, clear
keep if state == `i'
reghdfe work T_4 T_3 T_2 T0 T1 T2 T3 T4 if childnum <= 2, a(wave UR birthy edu)
est sto m1

// coefplot m1, drop(_cons) vertical ciopts(recast(rcap))name(state`i', replace) 

gen coefT_4 = _b[T_4]
gen coefT_3 = _b[T_3]
gen coefT_2 = _b[T_2]
gen coefT0 = _b[T0]
gen coefT1 = _b[T1]
gen coefT2 = _b[T2]
gen coefT3 = _b[T3]
gen coefT4 = _b[T4]

collapse (mean) coefT_4 coefT_3 coefT_2 coefT0 coefT1 coefT2 coefT3 coefT4 , by(state)

gen diff_4 = 0 - coefT_4
gen diff_3 = 0 - coefT_3
gen diff_2 = 0 - coefT_2
gen diff0 = 0 - coefT0
gen diff1 = 0 - coefT1
gen diff2 = 0 - coefT2
gen diff3 = 0 - coefT3
gen diff4 = 0 - coefT4

egen cp1 = rowmean(diff_4 diff_3 diff_2)
egen cp2 = rowmean(diff0 diff1 diff2 diff3 diff4)
gen cp = cp2 - cp1
keep state cp

save state`i', replace

}


// graph combine state5 state7 state11 state12 state16 state19 state20 state27 state29 state33


cd $temp
clear
fs state*.dta
append using `r(files)'
save india_stateCP, replace

use $data/temppseudo, clear
bysort state :egen xxx = count(id)
collapse (count) id, by(state)
keep if id >= 900
merge 1:1 state using india_stateCP
keep if _merge == 3
drop _merge id
gen stateX = state
drop if cp < 0

save $data/indiaCP, replace

}  // 中位数大概是0.24





// 2. 母职惩罚事件研究法
{
global Rpath "/Users/yuan/Desktop/论文核查/杨景媛-硕士学位论文调查审核/R语言绘图/印度"

use $data/temppseudo, clear
merge m:1 state using $data/indiaCP
keep if _merge == 3
save tempCP, replace

tabstat cp, by(edu)

* 母职惩罚低
use tempCP, clear
reghdfe dv T_4 T_3 T_2 T0 T1 T2 T3 T4 T5 T6 T7 T8 if cp<=0.045 & edu == 3, a(caseid birthy state UR interviewy caste)
est sto m1
parmest, saving("ols_estimate.dta", replace) format(estimate %8.3f std %8.3f t %8.3f) level(90)
use ols_estimate, clear
keep parm estimate min90 max90
gen 分类 = "低母职惩罚地区"
gen 受教育程度 = "高受教育程度"
replace parm = "T_1" if parm == "_cons"
replace estimate = 0 if parm == "T_1"
replace min90 = 0 if parm == "T_1"
replace max90 = 0 if parm == "T_1"
save temp1, replace

use tempCP, clear
reghdfe dv T_4 T_3 T_2 T0 T1 T2 T3 T4 T5 T6 T7 T8 if cp<=0.045 & edu < 3, a(caseid birthy state UR interviewy caste)
est sto m1
parmest, saving("ols_estimate.dta", replace) format(estimate %8.3f std %8.3f t %8.3f) level(90)
use ols_estimate, clear
keep parm estimate min90 max90
gen 分类 = "低母职惩罚地区"
gen 受教育程度 = "平均受教育程度"
replace parm = "T_1" if parm == "_cons"
replace estimate = 0 if parm == "T_1"
replace min90 = 0 if parm == "T_1"
replace max90 = 0 if parm == "T_1"
save temp2, replace


* 母职惩罚高
use tempCP, clear
reghdfe dv T_4 T_3 T_2 T0 T1 T2 T3 T4 T5 T6 T7 T8 if cp>0.045 & edu == 3, a(caseid birthy state UR interviewy caste)
est sto m1
parmest, saving("ols_estimate.dta", replace) format(estimate %8.3f std %8.3f t %8.3f) level(90)
use ols_estimate, clear
keep parm estimate min90 max90
gen 分类 = "高母职惩罚地区"
gen 受教育程度 = "高受教育程度"
replace parm = "T_1" if parm == "_cons"
replace estimate = 0 if parm == "T_1"
replace min90 = 0 if parm == "T_1"
replace max90 = 0 if parm == "T_1"
save temp3, replace

use tempCP, clear
reghdfe dv T_4 T_3 T_2 T0 T1 T2 T3 T4 T5 T6 T7 T8 if cp>0.045 & edu < 3, a(caseid birthy state UR interviewy caste)
est sto m1
parmest, saving("ols_estimate.dta", replace) format(estimate %8.3f std %8.3f t %8.3f) level(90)
use ols_estimate, clear
keep parm estimate min90 max90
gen 分类 = "高母职惩罚地区"
gen 受教育程度 = "平均受教育程度"
replace parm = "T_1" if parm == "_cons"
replace estimate = 0 if parm == "T_1"
replace min90 = 0 if parm == "T_1"
replace max90 = 0 if parm == "T_1"
save temp4, replace


append using temp1
append using temp2
append using temp3



export delimited using "$Rpath/3. 母职惩罚/cp_es_india.csv",replace
}












