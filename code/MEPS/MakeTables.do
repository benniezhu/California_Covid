use "D:\Data\SARS2NYCData\MEPS2014-2017Age50+WestOnly.dta"

*make table for all number of conditions
table FYI AgeCat SEX [fw=round(PERWT)], c(mean Diabetes mean HeartDisease mean Cancer mean ChronicLung mean HIV)

*make table for exactly one condition 

gen OneCondition = 0
replace OneCondition = 1 if NumCond == 1

table FYI AgeCat SEX [fw=round(PERWT)], c(mean OneCondition)


gen OnePlusCondition = 0
replace OnePlusCondition = 1 if NumCond >= 1

table FYI AgeCat SEX [fw=round(PERWT)], c(mean OnePlusCondition)
