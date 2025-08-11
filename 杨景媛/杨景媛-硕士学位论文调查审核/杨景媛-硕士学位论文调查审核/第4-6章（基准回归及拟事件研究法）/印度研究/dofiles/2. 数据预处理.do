*---------------------------------------*
*				印度样本(DHS)				*
*				 数据预处理				*
*				  杨景媛		 			*
*				2024.03.04				*
*---------------------------------------*

cd $temp

* 2005/06 : 87,925
* 2015/16 : 499,627

*---------------------------------- *
* --—--->  2005/2006年数据  <------- *
*---------------------------------- *

** step1. 处理2005/2006年数据
use $data/Individuals0506, clear
keep   ///
v010 v024 v025 v106 v107 v501 v130 slang s117 s118 v150  /// 个人变量
v701 v705 v730 v746 s45 s46  /// 配偶变量
b2_01 b2_02 b2_03 b2_04 b2_05 b2_06 b2_07 b2_08 b2_09 b2_10 b2_11 b2_12 b2_13 b2_14 b2_15 b2_16 b2_17 b2_18 b2_19 b2_20 v201 v202 v203 v204 v205  /// 生育变量
d105a d105b d105c d105d d105e d105f d105g d105h d105i d105j  /// 家暴变量
v717  /// 就业变量
s309m s309y   /// 婚姻变量
v007 caseid  // 其他

rename  /// 个人变量
(v010 v024 v025 v106 v107 v501 v130 slang s117 s118)  ///
(birthy state UR edu eduy marital religion muyu CT CT_type)

rename /// 配偶变量
(v701 v705 v730 v746 s45 s46)  ///
(sedu socc sage earnmore sCT sCT_type)

rename   /// 婚姻变量
(s309m s309y)   ///
(marry_m marry_y)


rename  /// 生育变量
(v201 v202 v203 v204 v205)   ///
(childnum homeson homeadu outson outdau)

rename   /// 家暴变量
(d105a d105b d105c d105d d105e d105f d105g d105h d105i d105j)   ///
(pushed slaped punched kicked strangle threatened attacked forcedsex forcedosex twisted)

rename   /// 就业变量
(v717)   ///
(occ)

rename   /// 其他
(v007) (interviewy)

save $data/pre_2005, replace  // 因为原始数据加载起来实在是太慢了，所以先做一步


use $data/pre_2005, clear

egen firstbirth = rmin(b2_01 b2_02 b2_03 b2_04 b2_05 b2_06 b2_07 b2_08 b2_09 b2_10 b2_11 b2_12 b2_13 b2_14 b2_15 b2_16 b2_17 b2_18 b2_19 b2_20)   // 第一个孩子的出生年
label variable firstbirth "第一个孩子的出生年"

// 生成家暴数据
gen dv = .
foreach i of varlist pushed slaped punched kicked strangle threatened attacked forcedsex forcedosex twisted{
	replace dv = 1 if `i' == 1 | `i' == 2 | `i' == 3  |`i' == 4
}
replace dv = 0 if dv == .
label variable dv "是否遭受家暴"

keep if marital == 1 | marital == 2

gen recent_dv = .
foreach i of varlist pushed slaped punched kicked strangle threatened attacked forcedsex forcedosex twisted{
	replace recent_dv = 1 if `i' == 1 | `i' == 2 
}
replace recent_dv = 0 if recent_dv == .
label variable recent_dv "近一年是否遭遇家暴"

// 生成生育数据
gen fertility = 1 if childnum > 0
	replace fertility = 0 if childnum == 0
	label define fertility 0 "未生育" 1 "已生育"
	label values fertility fertility
	label variable fertility "是否生育"
	
gen fertility1 = 0 if childnum == 0
	replace fertility1 = 1 if childnum == 1 | childnum == 2
	replace fertility1 = 2 if childnum >= 3 & childnum <= 5
	replace fertility1 = 3 if childnum > 5
	label define fertility1 0 "未生育" 1 "生1-2个" 2 "生3-5个" 3 "生5个以上"
	label values fertility1 fertility1
	label variable fertility1 "是否多胎生育"

// 生成就业数据
gen work = 1 if occ == 1 | occ == 2 | occ == 3 | occ == 4 | occ == 5 | occ == 7 | occ == 8 | occ == 9 
	replace work = 0 if occ == 0 | occ == 6 
	label define work 0 "未就业" 1 "就业"
	label values work work
	label variable work "是否就业"
	
gen jobtype = 0 if work == 0
	replace jobtype = 2 if occ == 1 | occ == 2 | occ == 3
	replace jobtype = 1 if occ == 4 | occ == 5 | occ == 7 | occ == 8 | occ == 9 
	label define jobtype 0 "未就业" 1 "不稳定就业" 2 "稳定就业"
	label values jobtype jobtype
	label variable jobtype "就业性质（稳定与否)'"
	
// 生成种姓数据
gen caste = 1 if CT_type == 4
	replace caste = 0 if CT_type == 1 | CT_type == 2 | CT_type == 3
	label define caste 1 "高种姓" 0 "低种姓"
	label values caste caste
	label var caste "是否高种姓"

save $data/processed2005, replace   //87,925


*---------------------------------- *
* --—--->  2015/2016年数据  <------- *
*---------------------------------- *
** step2. 处理2015/2016年数据
use $data/Individuals1516, clear   
keep   ///
v010 v024 v025 v106 v107 v501 v130 slangrm v131 s116 v150 /// 个人变量
v701 v705 v730 v746  /// 配偶变量
b2_01 b2_02 b2_03 b2_04 b2_05 b2_06 b2_07 b2_08 b2_09 b2_10 b2_11 b2_12 b2_13 b2_14 b2_15 b2_16 b2_17 b2_18 b2_19 b2_20 v201 v202 v203 v204 v205  /// 生育变量
d105a d105b d105c d105d d105e d105f d105g d105h d105i d105j  /// 家暴变量
v717  /// 就业变量
s308m s308y   /// 婚姻变量
v007 caseid  // 其他

rename  /// 个人变量
(v010 v024 v025 v106 v107 v501 v130 slangrm v131 s116)  ///
(birthy state UR edu eduy marital religion muyu CT CT_type)

rename /// 配偶变量
(v701 v705 v730 v746)  ///
(sedu socc sage earnmore)

rename  /// 生育变量
(v201 v202 v203 v204 v205)   ///
(childnum homeson homeadu outson outdau)

rename   /// 婚姻变量
(s308m s308y)   ///
(marry_m marry_y)

rename   /// 家暴变量
(d105a d105b d105c d105d d105e d105f d105g d105h d105i d105j)   ///
(pushed slaped punched kicked strangle threatened attacked forcedsex forcedosex twisted)

rename   /// 就业变量
(v717)   ///
(occ)

rename   /// 其他
(v007) (interviewy)

save $data/pre_2015, replace  // 因为原始数据加载起来实在是太慢了，所以先做一步


use $data/pre_2015, clear

egen firstbirth = rmin(b2_01 b2_02 b2_03 b2_04 b2_05 b2_06 b2_07 b2_08 b2_09 b2_10 b2_11 b2_12 b2_13 b2_14 b2_15 b2_16 b2_17 b2_18 b2_19 b2_20)   // 第一个孩子的出生年
label variable firstbirth "第一个孩子的出生年"

// 生成家暴数据
gen dv = .
foreach i of varlist pushed slaped punched kicked strangle threatened attacked forcedsex forcedosex twisted{
	replace dv = 1 if `i' == 1 | `i' == 2 | `i' == 3  |`i' == 4
}
replace dv = 0 if dv == .
label variable dv "是否遭受家暴"

gen recent_dv = .
foreach i of varlist pushed slaped punched kicked strangle threatened attacked forcedsex forcedosex twisted{
	replace recent_dv = 1 if `i' == 1 | `i' == 2 
}
replace recent_dv = 0 if recent_dv == .
label variable recent_dv "近一年是否遭遇家暴"

keep if marital == 1 | marital == 2

// 生成生育数据
gen fertility = 1 if childnum > 0
	replace fertility = 0 if childnum == 0
	label define fertility 0 "未生育" 1 "已生育"
	label values fertility fertility
	label variable fertility "是否生育"
	
gen fertility1 = 0 if childnum == 0
	replace fertility1 = 1 if childnum == 1 | childnum == 2
	replace fertility1 = 2 if childnum >= 3 & childnum <= 5
	replace fertility1 = 3 if childnum > 5
	label define fertility1 0 "未生育" 1 "生1-2个" 2 "生3-5个" 3 "生5个以上"
	label values fertility1 fertility1
	label variable fertility1 "是否多胎生育"

// 生成就业数据
gen work = 1 if occ == 1 | occ == 2 | occ == 3 | occ == 4 | occ == 5 | occ == 7 | occ == 8 | occ == 9 
	replace work = 0 if occ == 0 | occ == 6 
	label define work 0 "未就业" 1 "就业"
	label values work work
	label variable work "是否就业"
	
gen jobtype = 0 if work == 0
	replace jobtype = 2 if occ == 1 | occ == 2 | occ == 3
	replace jobtype = 1 if occ == 4 | occ == 5 | occ == 7 | occ == 8 | occ == 9 
	label define jobtype 0 "未就业" 1 "不稳定就业" 2 "稳定就业"
	label values jobtype jobtype
	label variable jobtype "就业性质（稳定与否)'"

gen caste = 1 if CT_type == 4
	replace caste = 0 if CT_type == 1 | CT_type == 2 | CT_type == 3
	label define caste 1 "高种姓" 0 "低种姓"
	label values caste caste
	label var caste "是否高种姓"

save $data/processed2015, replace   //499,627


