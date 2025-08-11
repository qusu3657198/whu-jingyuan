// 描述性统计 表


cd $temp

// 这里输出的mytable_india对应正文的表4.2


use $data/Individuals1516, clear
keep d105a d105b d105c d105d d105e d105f d105i d105j
foreach i of varlist d105a d105b d105c d105d d105e d105f d105i d105j{
	logout, save(`i') word replace : tab `i'
}

use $data/processed2015, clear
logout, save($output/mytable_india) word replace :  tabstat birthy UR edu recent_dv work fertility1,  s(N mean sd min max) f(%12.3f) c(s)


