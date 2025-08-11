* 绪论绘图


cd $temp


use $data/processed9899, clear
collapse (mean) dv, by(UR)
gen year = 1998
save temp2, replace




use $data/processed2005, clear
collapse (mean) dv, by(UR)
gen year = 2005
save temp3, replace


use $data/processed2015, clear
collapse (mean) dv, by(UR)
gen year = 2015
save temp4, replace



use $data/processed1921, clear
collapse (mean) dv, by(UR)
gen year = 2019
save temp5, replace



append using temp2
append using temp3
append using temp4



export delimited using "/Users/yuan/study/毕业论文- R绘图/绪论/time_trendINDIA.csv", replace







