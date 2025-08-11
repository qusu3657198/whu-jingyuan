*---------------------------------------*
*				印度样本(DHS)				*
*				 描述性回归				*
*				  杨景媛		 			*
*				2024.03.08				*
*---------------------------------------*


* --> step1 数据处理

* 2005:87,925
* 2015:499,627

* 先处理2005/2006年数据
use $data/processed2005, clear  //87,925
keep interviewy birthy state UR edu religion childnum homeson homeadu outson outdau marital sedu muyu CT firstbirth dv recent_dv fertility fertility1 work jobtype caste earnmore
save $data/forreg05, replace

* 再处理2015/2016年数据
use $data/processed2015, clear   //499,627
keep interviewy birthy state UR edu religion childnum homeson homeadu outson outdau marital sedu muyu CT firstbirth dv recent_dv fertility fertility1 work jobtype caste earnmore
save $data/forreg15, replace

* 原始回归（有一些错误）
{

*--> step2 回归
// 按照城乡分组
est drop *
use $data/forreg05, clear
reghdfe dv fertility1, a(state edu birthy marital religion caste UR) vce(cluster state)
	est sto m1
reghdfe dv fertility1 if UR == 1, a(state edu birthy marital religion caste) vce(cluster state)
	est sto m2
reghdfe dv fertility1 if UR == 2, a(state edu birthy marital religion caste) vce(cluster state)
	est sto m3
	
use $data/forreg15, clear
reghdfe dv fertility1, a(state sedu edu birthy marital religion caste UR) vce(cluster state)
	est sto m4
reghdfe dv fertility1 if UR == 1, a(state edu birthy marital religion caste) vce(cluster state)
	est sto m5
reghdfe dv fertility1 if UR == 2, a(state edu birthy marital religion caste) vce(cluster state)
	est sto m6
esttab m*, keep(fertility1) star(* 0.1 ** 0.05 *** 0.01) title("table 5.4")
	
esttab m* using $output/table1.rtf, replace keep(fertility1) star(* 0.1 ** 0.05 *** 0.01)	

// 按照种姓情况分组
est drop *
use $data/forreg05, clear
reghdfe dv fertility1, a(state edu birthy marital religion UR) vce(cluster state)
	est sto m1
reghdfe dv fertility1 if caste == 0, a(state edu birthy marital religion UR) vce(cluster state)
	est sto m2
reghdfe dv fertility1 if caste == 1, a(state edu birthy marital religion UR) vce(cluster state) 
	est sto m3

use $data/forreg15, clear
reghdfe dv fertility1, a(state sedu edu birthy marital religion UR caste) vce(cluster state)
	est sto m4
reghdfe dv fertility1 if caste == 0, a(state edu birthy marital religion UR) vce(cluster state)
	est sto m5
reghdfe dv fertility1 if caste == 1, a(state edu birthy marital religion UR) vce(cluster state)
	est sto m6
dis("table5.5")
esttab m*, keep(fertility1) star(* 0.1 ** 0.05 *** 0.01) title("table 5.5")

esttab m* using $output/table2.rtf, replace keep(fertility1) star(* 0.1 ** 0.05 *** 0.01)

}




* 修正了错误后的结果（和之前的回归结果相差不大，说明我的结果基本稳健）
{
*--> step2 回归
// 按照城乡分组
est drop *
use $data/forreg05, clear
reghdfe dv fertility1, a(state edu birthy marital religion caste UR) vce(cluster state)
	est sto m1
reghdfe dv fertility1 if UR == 1, a(state edu birthy marital religion caste) vce(cluster state)
	est sto m2
reghdfe dv fertility1 if UR == 2, a(state edu birthy marital religion caste) vce(cluster state)
	est sto m3
	
use $data/forreg15, clear
reghdfe dv fertility1, a(state edu birthy marital religion caste UR) vce(cluster state)
	est sto m4
reghdfe dv fertility1 if UR == 1, a(state edu birthy marital religion caste) vce(cluster state)
	est sto m5
reghdfe dv fertility1 if UR == 2, a(state edu birthy marital religion caste) vce(cluster state)
	est sto m6
esttab m*, keep(fertility1) star(* 0.1 ** 0.05 *** 0.01) title("table 5.4")
	
esttab m* using $output/table1_revised2025.rtf, replace keep(fertility1) star(* 0.1 ** 0.05 *** 0.01)	

// 按照种姓情况分组
est drop *
use $data/forreg05, clear
reghdfe dv fertility1, a(state edu birthy marital religion UR) vce(cluster state)
	est sto m1
reghdfe dv fertility1 if caste == 0, a(state edu birthy marital religion UR) vce(cluster state)
	est sto m2
reghdfe dv fertility1 if caste == 1, a(state edu birthy marital religion UR) vce(cluster state) 
	est sto m3

use $data/forreg15, clear
reghdfe dv fertility1, a(state sedu edu birthy marital religion UR caste) vce(cluster state)
	est sto m4
reghdfe dv fertility1 if caste == 0, a(state edu birthy marital religion UR) vce(cluster state)
	est sto m5
reghdfe dv fertility1 if caste == 1, a(state edu birthy marital religion UR) vce(cluster state)
	est sto m6
dis("table5.5")
esttab m*, keep(fertility1) star(* 0.1 ** 0.05 *** 0.01) title("table 5.5")

esttab m* using $output/table2_revised2025.rtf, replace keep(fertility1) star(* 0.1 ** 0.05 *** 0.01)	
	
}
