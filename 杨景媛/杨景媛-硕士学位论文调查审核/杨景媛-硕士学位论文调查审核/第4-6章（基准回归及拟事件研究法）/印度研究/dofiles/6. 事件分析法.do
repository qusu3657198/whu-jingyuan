*---------------------------------------*
*				印度样本(DHS)				*
*				 pseudo reg				*
*				  杨景媛		 			*
*				2024.03.08				*
*---------------------------------------*


global Rpath "/Users/yuan/Desktop/论文核查/杨景媛-硕士学位论文调查审核/R语言绘图/印度"

cd $temp

* --> step1 数据处理
{
* 先处理2005/2006年数据
use $data/processed2005, clear
keep if fertility == 0
collapse (mean) dv work, by(birthy state UR edu religion caste)
rename dv dv3
rename work work3
save $data/forpseudo05, replace

* 再处理2015/2016年数据
use $data/processed2015, clear
keep caseid interviewy birthy state UR edu v150 childnum religion sedu occ earnmore caste firstbirth dv fertility fertility1 work jobtype
keep if firstbirth >= 2005
rename dv dv4
rename work work4
save $data/forpseudo15, replace

* 数据匹配
use $data/forpseudo15, clear

	merge m:1 birthy state UR edu religion caste using $data/forpseudo05
	keep if _merge == 3
	drop _merge
save $data/pseudo, replace
 
* 事件研究法处理
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
	
forvalues i=0(1)8{
	gen T`i' = 1 if T == `i'
	replace T`i' = 0 if T`i' == .
}

replace T8 = 1 if T >= 8

encode caseid, gen(id)
xtset id wave

save $data/temppseudo, replace
}

* --> 回归
// 1. 整体
{
use $data/temppseudo, clear
reghdfe dv T_4 T_3 T_2 T0 T1 T2 T3 T4 T5 T6 T7 T8 , a(caseid birthy state UR edu interviewy caste)
parmest, saving("ols_estimate.dta", replace) format(estimate %8.3f std %8.3f t %8.3f) level(90)
use ols_estimate, clear
keep parm estimate min90 max90
gen 分类 = "全样本"
replace parm = "T_1" if parm == "_cons"
replace estimate = 0 if parm == "T_1"
replace min90 = 0 if parm == "T_1"
replace max90 = 0 if parm == "T_1"
save temp, replace

export delimited using "$Rpath/1. 整体样本/all_india.csv",replace


// childnum <= 2
use $data/temppseudo, clear
keep if childnum <= 1
reghdfe dv T_4 T_3 T_2 T0 T1 T2 T3 T4 T5 T6 T7 T8 , a(caseid birthy state UR edu interviewy caste)
parmest, saving("ols_estimate.dta", replace) format(estimate %8.3f std %8.3f t %8.3f) level(90)
use ols_estimate, clear
keep parm estimate min90 max90
gen 分类 = "一胎家庭"
replace parm = "T_1" if parm == "_cons"
replace estimate = 0 if parm == "T_1"
replace min90 = 0 if parm == "T_1"
replace max90 = 0 if parm == "T_1"
append using temp

export delimited using "$Rpath/1. 整体样本/bornless_india.csv",replace
}

// 2. 受教育程度差异
{
use $data/temppseudo, clear
keep if edu <= 3 
reghdfe dv T_4 T_3 T_2 T0 T1 T2 T3 T4 T5 T6 T7 T8 , a(caseid birthy state UR edu interviewy caste)
parmest, saving("ols_estimate.dta", replace) format(estimate %8.3f std %8.3f t %8.3f) level(90)
use ols_estimate, clear
keep parm estimate min90 max90
gen 分类 = "低受教育程度"
replace parm = "T_1" if parm == "_cons"
replace estimate = 0 if parm == "T_1"
replace min90 = 0 if parm == "T_1"
replace max90 = 0 if parm == "T_1"
save temp, replace

use $data/temppseudo, clear
keep if edu == 3
reghdfe dv T_4 T_3 T_2 T0 T1 T2 T3 T4 T5 T6 T7 T8 , a(caseid birthy state UR edu interviewy caste)
parmest, saving("ols_estimate.dta", replace) format(estimate %8.3f std %8.3f t %8.3f) level(90)
use ols_estimate, clear
keep parm estimate min90 max90
gen 分类 = "高受教育程度"
replace parm = "T_1" if parm == "_cons"
replace estimate = 0 if parm == "T_1"
replace min90 = 0 if parm == "T_1"
replace max90 = 0 if parm == "T_1"

append using temp

export delimited using "$Rpath/2. 受教育程度/edu_india.csv",replace
}

// 3. 母职惩罚
{
	// 因为母职惩罚需要先计算母职惩罚变量，因此我单独在另一个文件里面完成（变量计算+事件分析）
	// 这里只是列出来（和论文结构一致）
}

// 4. 不同种姓
{
* 高种姓
use $data/temppseudo, clear
keep if caste == 1 & edu == 3
reghdfe dv T_4 T_3 T_2 T0 T1 T2 T3 T4 T5 T6 T7 T8 , a(caseid birthy state UR interviewy)
parmest, saving("ols_estimate.dta", replace) format(estimate %8.3f std %8.3f t %8.3f) level(90)
use ols_estimate, clear
keep parm estimate min90 max90
gen 分类 = "高种姓"
gen 受教育程度 = "高受教育程度"
replace parm = "T_1" if parm == "_cons"
replace estimate = 0 if parm == "T_1"
replace min90 = 0 if parm == "T_1"
replace max90 = 0 if parm == "T_1"
save temp1, replace

use $data/temppseudo, clear
keep if caste == 1 & edu < 3
reghdfe dv T_4 T_3 T_2 T0 T1 T2 T3 T4 T5 T6 T7 T8 , a(caseid birthy state UR interviewy)
parmest, saving("ols_estimate.dta", replace) format(estimate %8.3f std %8.3f t %8.3f) level(90)
use ols_estimate, clear
keep parm estimate min90 max90
gen 分类 = "高种姓"
gen 受教育程度 = "平均受教育程度"
replace parm = "T_1" if parm == "_cons"
replace estimate = 0 if parm == "T_1"
replace min90 = 0 if parm == "T_1"
replace max90 = 0 if parm == "T_1"
save temp2, replace

* 低种姓
use $data/temppseudo, clear
keep if caste == 0 & edu == 3
reghdfe dv T_4 T_3 T_2 T0 T1 T2 T3 T4 T5 T6 T7 T8 , a(caseid birthy state UR interviewy)
parmest, saving("ols_estimate.dta", replace) format(estimate %8.3f std %8.3f t %8.3f) level(90)
use ols_estimate, clear
keep parm estimate min90 max90
gen 分类 = "低种姓"
gen 受教育程度 = "高受教育程度"
replace parm = "T_1" if parm == "_cons"
replace estimate = 0 if parm == "T_1"
replace min90 = 0 if parm == "T_1"
replace max90 = 0 if parm == "T_1"
save temp3, replace

use $data/temppseudo, clear
keep if caste == 0 & edu < 3
reghdfe dv T_4 T_3 T_2 T0 T1 T2 T3 T4 T5 T6 T7 T8 , a(caseid birthy state UR interviewy)
parmest, saving("ols_estimate.dta", replace) format(estimate %8.3f std %8.3f t %8.3f) level(90)
use ols_estimate, clear
keep parm estimate min90 max90
gen 分类 = "低种姓"
gen 受教育程度 = "平均受教育程度"
replace parm = "T_1" if parm == "_cons"
replace estimate = 0 if parm == "T_1"
replace min90 = 0 if parm == "T_1"
replace max90 = 0 if parm == "T_1"
save temp4, replace

append using temp1
append using temp2
append using temp3

export delimited using "$Rpath/4. 种姓制度/caste.csv",replace
}


















