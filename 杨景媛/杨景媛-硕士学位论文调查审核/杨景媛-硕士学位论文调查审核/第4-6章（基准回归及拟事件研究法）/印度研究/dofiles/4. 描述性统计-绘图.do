// 描述性统计


// 生育与就业
* 稳定性较高的职业
use $data/processed2005, clear
tab occ
labellist occ
keep if occ == 0 | occ == 1 | occ == 2 | occ == 3 | occ == 6
	graph bar (mean) work, over(fertility1, label(labsize(vsmall)))	///
		by(UR, note("稳定性较高的职业"))  ///
		scheme(plotplain)  ///
		ytitle("平均就业率") ///
		name(FFixW2005, replace) ///
		title("2005年")

use $data/processed2015, clear
tab occ
labellist occ
keep if occ == 0 | occ == 1 | occ == 2 | occ == 3
	graph bar (mean) work, over(fertility1, label(labsize(vsmall)))	///
		by(UR, note(" "))  ///
		scheme(plotplain)  ///
		ytitle("平均就业率") ///
		name(FFixW2015, replace) ///
		title("2015年")
graph combine FFixW2005 FFixW2015, cols(2) scheme(plotplain) 

* 稳定性较低的职业
use $data/processed2005, clear
tab occ
labellist occ
keep if occ == 0 | occ == 4 | occ == 5 | occ == 6 | occ == 7 | occ == 9
	graph bar (mean) work, over(fertility1, label(labsize(vsmall)))	///
		by(UR, note("稳定性较低的职业"))  ///
		scheme(plotplain)  ///
		ytitle("平均就业率") ///
		name(FFlexW2005, replace) ///
		title("2005年")
		
use $data/processed2015, clear
tab occ
labellist occ
keep if occ == 0 | occ == 4 | occ == 5 | occ == 6 | occ == 7 | occ == 8 | occ == 9
	graph bar (mean) work, over(fertility1, label(labsize(vsmall)))	///
		by(UR, note(" "))  ///
		scheme(plotplain)  ///
		ytitle("平均就业率") ///
		name(FFlexW2015, replace) ///
		title("2015年")
	
graph combine FFixW2005 FFixW2015 FFlexW2005 FFlexW2015, cols(2) scheme(plotplain) 



// 种姓与家暴
use $data/forreg05, clear
	graph bar (mean) dv, over(caste, label(labsize(small)))	///
		by(UR, note(" "))  ///
		scheme(plotplain)  ///
		ytitle("平均家暴发生率") ///
		name(Caste2005, replace) ///
		title("2005年")

use $data/forreg15, clear
	graph bar (mean) dv, over(caste, label(labsize(small)))	///
		by(UR, note("按照城乡分组"))  ///
		scheme(plotplain)  ///
		ytitle("平均家暴发生率") ///
		name(Caste2015, replace) ///
		title("2015年")

graph combine Caste2005 Caste2015, cols(1) scheme(plotplain) 

// 受教育水平与家暴
use $data/forreg05, clear
drop if edu == 9
label define edu 0 "文盲" 1 "初级" 2 "中级" 3 "高级"
label values edu edu
	graph bar (mean) dv, over(edu, label(labsize(small)))	///
		by(UR, note("按照城乡分组"))  ///
		scheme(plotplain)  ///
		ytitle("平均家暴发生率") ///
		name(edu2005, replace) ///
		title("2005年")

use $data/forreg15, clear
drop if edu == 9
label define edu 0 "文盲" 1 "初级" 2 "中级" 3 "高级"
label values edu edu
	graph bar (mean) dv, over(edu, label(labsize(small)))	///
		by(UR, note(" "))  ///
		scheme(plotplain)  ///
		ytitle("平均家暴发生率") ///
		name(edu2015, replace) ///
		title("2015年")

graph combine edu2005 edu2015, cols(2) scheme(plotplain) 

// 相对受教育水平与家暴
use $data/forreg05, clear
gen xx = sedu-edu
gen edudiff = -1 if xx < 0
	replace edudiff = 0 if xx == 0
	replace edudiff = 1 if xx > 0	
	label define edudiff -1 "高于配偶" 0 "等于配偶" 1 "低于配偶" 
	label values edudiff edudiff
	label variable edudiff "和配偶的受教育水平差异"		

	graph bar (mean) dv, over(edudiff, label(labsize(vsmall)))	///
		by(UR, note("按照城乡进行分组"))  ///
		scheme(plotplain)  ///
		ytitle("平均家暴发生率") ///
		name(edudiff_dv2005, replace) ///
		title("2005年数据")
	
use $data/forreg15, clear
gen xx = sedu1-edu1
gen edudiff = -1 if xx < 0
	replace edudiff = 0 if xx == 0
	replace edudiff = 1 if xx > 0	
	label define edudiff -1 "高于配偶" 0 "等于配偶" 1 "低于配偶" 
	label values edudiff edudiff
	label variable edudiff "和配偶的受教育水平差异"		

	graph bar (mean) dv, over(edudiff, label(labsize(vsmall)))	///
		by(UR, note(" "))  ///
		scheme(plotplain)  ///
		ytitle("平均家暴发生率") ///
		name(edudiff_dv2015, replace) ///
		title("2015年数据")
	
graph combine edudiff_dv2005 edudiff_dv2015, cols(2) scheme(plotplain) 		

// 是否户主与家暴
use $data/forreg05, clear
keep if relation_head == 1 | relation_head == 2
label define relation_head 1 "户主" 2 "非户主"
label values relation_head relation_head
	graph bar (mean) dv, over(relation_head, label(labsize(vsmall)))	///
		by(UR, note(" "))  ///
		scheme(plotplain)  ///
		ytitle("平均家暴发生率") ///
		name(Huzhu_DV2005, replace) ///
		title("2005年")

use $data/forreg15, clear
keep if relation_head == 1 | relation_head == 2
label define relation_head 1 "户主" 2 "非户主"
label values relation_head relation_head
	graph bar (mean) dv, over(relation_head, label(labsize(vsmall)))	///
		by(UR, note(" "))  ///
		scheme(plotplain)  ///
		ytitle("平均家暴发生率") ///
		name(Huzhu_DV2015, replace) ///
		title("2015年")


graph combine Huzhu_DV2005 Huzhu_DV2015, cols(2) scheme(plotplain) 



// 生育与家暴
use $data/forreg05, clear
	graph bar (mean) dv, over(fertility1, label(labsize(vsmall)))	///
		by(UR, note("按照城乡分组"))  ///
		scheme(plotplain)  ///
		ytitle("平均家暴发生率") ///
		name(F_DV2005, replace) ///
		title("2005年")

use $data/forreg15, clear
	graph bar (mean) dv, over(fertility, label(labsize(vsmall)))	///
		by(UR, note(" "))  ///
		scheme(plotplain)  ///
		ytitle("平均家暴发生率") ///
		name(F_DV2015, replace) ///
		title("2015年")


graph combine F_DV2005 F_DV2015, cols(2) scheme(plotplain) 


// 收入与家暴
use $data/forreg05, clear
keep if earnmore <= 4
label define earnmore 1 "比丈夫多" 2 "比丈夫少" 3 "和丈夫差不多" 4 "丈夫不赚钱"
label values earnmore earnmore
	graph bar (mean) dv, over(earnmore, label(labsize(small)))	///
		by(UR, note(" "))  ///
		scheme(plotplain)  ///
		ytitle("平均家暴发生率") ///
		name(earn2005, replace) ///
		title("2005年")

use $data/forreg15, clear
keep if earnmore <= 4
label define earnmore 1 "比丈夫多" 2 "比丈夫少" 3 "和丈夫差不多" 4 "丈夫不赚钱"
label values earnmore earnmore
	graph bar (mean) dv, over(earnmore, label(labsize(small)))	///
		by(UR, note("按照城乡分组"))  ///
		scheme(plotplain)  ///
		ytitle("平均家暴发生率") ///
		name(earn2015, replace) ///
		title("2015年")

graph combine earn2005 earn2015, cols(1) scheme(plotplain) 





// 种姓-生育与家暴
use $data/forreg05, clear

collapse (mean) childnum dv, by(state caste)

twoway   ///
(lfit dv childnum if caste == 1)(lfit dv childnum if caste == 0)   ///
(scatter dv childnum if caste == 1)(scatter dv childnum if caste == 0),   ///
scheme(plotplain)    ///
ytitle("平均家暴发生率") ///
xtitle("各省不同种姓平均生育数")

















		
		