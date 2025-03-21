using DataFrames, CSV, Plots, GLM

# we are working on the Neal Pearce paper
# analysis of table 2

n1 = 10_000
n0 = 10_000
a = 1813
b = 952
c = n1 - a
d = n0 - b
y1 = 90635
y0 = 95163
i1 = round(a / y1, digits = 4) # incidence rate among exposed
i0 = round(b / y0, digits = 4) # incidence rate among non-exposed
r1 = round(a / n1, digits = 4) # incidence proportion among exposed
r0 = round(b / n0, digits = 4) # incidence proportion among non-exposed
o1 = round(r1 / (1 - r1), digits = 4) # incidence odds among exposed
o0 = round(r0 / (1 - r0), digits = 4) # incidence odds among non-exposed


exposed = [a,c,n1,y1, i1, r1, o1]
non_exposed = [b,d,n0,y0, i0, r0, o0]

cohort = DataFrame(:exposed => exposed, :non_exposed => non_exposed)
rate_ratio = [i1/i0, r1/r0, o1/o0]

# incidence case control study
c1 = 1313 # cumulative sampling, select at random from those who have not experienced
c2 = 1383 # case cohort sampling, controls selected in the beginning of study, 
# as in entire population, not wait till the cases have accumulated and then collect
c3 = 1349  # density sampling, select controls throughout the course of the study
# this is also referred to as concurrent sampling

d1 = 1452 # cumulative sampling
d2 = 1383 # case-cohort sampling
d3 = 1416 # density sampling (see the text for details)

exposed2 = [a, c1, c2, c3]
nonexposed2 = [b, d1,d2,d3 ]

incidence_case_ctrl = DataFrame(:exposed => exposed2, :non_exposed => nonexposed2)
survivor_or = round( (a * d1) / (b * c1), digits = 3 )
case_cohort_or = round( (a * d2) / (b * c2), digits = 3 )
person_yrs_or = round( (a * d3) / (b * c3), digits = 3 )

col1 = ["survivor_or", "case_cohort_or", "person_yrs_or"]
col2 = [survivor_or, case_cohort_or, person_yrs_or]

df2 = DataFrame(:feature => col1, :odd_ratio => col2, :rate_ratio => rate_ratio)

# Prevalence studies

a1 = 909
b1 = 476
N1 = 10_000 
N2 = 10_000 
c4 = N1 - a1
d4 = N2 - b1 
p1 = round(a1 / N1, digits = 4)
p0 = round(b1 / N2, digits = 4)
O1 = round(p1 / (1 - p1), digits = 4)
O0 = round(p0 / (1 - p0), digits = 4)

exp1 = [a1, c4, N1, p1, O1]
exp2 = [b1, d4, N2, p0, O0]
features = ["Cases", "Non-cases", "Total Population", "Prevalence", "Prevalence odds"]

prevalence_df = DataFrame(:Names => features,
:Exposed => exp1,
:Non_exposed => exp2)

prev_ratio = p1/p0
prev_odds_ratio = O1 / O0 

prevalence_ratios = DataFrame(:prevalence_ratio => prev_ratio,
:prevalence_odds_ratio => prev_odds_ratio)

## Prevalence case control study

a2 = 909 # exposed and cases
b2 = 476 # non exposed and cases
c5 = 676 # exposed and controls
d5 = 709 # non exposed and controls
po1 = a2 / c5 # prevalence odds among exposed
po2 = b2 / d5 # prevalence odds among nonexposed

exposed_stats = [a2, c5, po1]
non_exposed_stats = [b2, d5, po2]

featurenames = ["cases", "controls", "prevalence odds"]

df_cc = DataFrame(:feature_names => featurenames, :Exposed => exposed_stats, 
:Nonexposed => non_exposed_stats)

prevalence_odds_ratio_here = po1 / po2 

## Continuous outcome measures













