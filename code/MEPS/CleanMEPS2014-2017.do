 use "C:\Users\bz22\Desktop\SARS2NYCData\MEPS2014-2017Age50+WestOnly.dta"

 keep if REGION31 == 4

 *merge with HIV information from condition files

merge 1:1 DUPERSID year using "D:\Data\SARS2NYCData\HIVStatus2014-2017.dta"
drop if _merge == 2 // drop HIV people from other census regions
replace HIV = 0 if HIV == .

* define age categories
gen AgeCat = .
replace AgeCat = 0 if AGE < 65
replace AgeCat = 1 if AGE >= 65 & AGE <75
replace AgeCat = 2 if AGE >= 75
label define AgeCat 0 "50-64" 1 "65-74" 2 "75+"
label values AgeCat AgeCat

/* I define Chronic Lung Disease to be someone who fulfills any of the following criteria; reports still having asthma, was ever diagnosed with empheysema, or has chronic bronchitis in the last 12 months*/

gen ChronicLung = 0
replace ChronicLung = 1 if CHBRON31 == 1 | ASSTIL31 == 1 | EMPHDX == 1

/* I define heart disease as anyone who fills any of the following criteria; was diganosed with coronary heart disease, angina, other heart disease/condition, diagnosed with having a heart attack or stroke */

gen HeartDisease = 0
replace HeartDisease = 1 if CHDDX == 1 | MIDX == 1 | OHRTDX == 1 | STRKDX == 1

* cancer and diabetes definitions are for any cancer dx
gen Diabetes = 0
replace Diabetes = 1 if DIABDX == 1

gen Cancer = 0
replace Cancer = 1 if CANCERDX == 1

gen NumCond = HIV + HeartDisease + Cancer + Diabetes + ChronicLung
