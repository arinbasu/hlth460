using DataFrames, CSV, Plots, GLM # these packages are useful for data analysis and loaded in the beginning

# we are working on the Neal Pearce paper
# Full reference to the paper here: Neil Pearce, Classification of epidemiological study designs, International Journal of Epidemiology, Volume 41, Issue 2, April 2012, Pages 393–397, https://doi.org/10.1093/ije/dys049
# Link to the pdf copy of the paper is provided in the reading list, you can download and follow along
# Analysis of table 2 in the paper
# you can run all the codes in a julia environment to better understand the paper
# if you want to run the codes in Pluto, then run each line of code individually in a separate cell or preface each cell with multiple lines with begin ... end

n1 = 10_000 # total number of people in the exposed group
n0 = 10_000 # total number of people in the non-exposed group
a = 1813 # cases in the exposed group
b = 952 # cases in the non-exposed group
c = n1 - a # non-cases in the exposed group
d = n0 - b # non-cases in the non-exposed group
y1 = 90635 # person-years for the exposed group
y0 = 95163 # person-years for the non-exposed group
i1 = round(a / y1, digits = 4) # incidence rate among exposed
i0 = round(b / y0, digits = 4) # incidence rate among non-exposed
r1 = round(a / n1, digits = 4) # incidence proportion among exposed
r0 = round(b / n0, digits = 4) # incidence proportion among non-exposed
o1 = round(r1 / (1 - r1), digits = 4) # incidence odds among exposed
o0 = round(r0 / (1 - r0), digits = 4) # incidence odds among non-exposed

# the following two lines compile the exposed and nonexposed group together
exposed = [a,c,n1,y1, i1, r1, o1]
non_exposed = [b,d,n0,y0, i0, r0, o0]

# the following code creates a data frame of the cohort

cohort = DataFrame(:exposed => exposed, :non_exposed => non_exposed)

# this creates the rate ratio for the three situations, incidence rates, incidence proportions, and incidence odds

rate_ratio = [i1/i0, r1/r0, o1/o0]

# incidence case control study
c1 = 1313 # cumulative sampling, select at random from those who have not experienced at the end of the cohort study
c2 = 1383 # case cohort sampling, controls selected in the beginning of study, 
# as in entire population, not wait till the cases have accumulated and then collect
c3 = 1349  # density sampling, select controls throughout the course of the study
# this is also referred to as concurrent sampling

d1 = 1452 # cumulative sampling
d2 = 1383 # case-cohort sampling
d3 = 1416 # density sampling (see the text for details)

exposed2 = [a, c1, c2, c3]
nonexposed2 = [b, d1,d2,d3 ]

# The following code sets up a data frame for the incidence case control study results

incidence_case_ctrl = DataFrame(:exposed => exposed2, :non_exposed => nonexposed2)

# the following three codes create the odds ratios for the cumulative sampling, case cohort sampling, and the density sampling respectively
survivor_or = round( (a * d1) / (b * c1), digits = 3 )
case_cohort_or = round( (a * d2) / (b * c2), digits = 3 )
person_yrs_or = round( (a * d3) / (b * c3), digits = 3 )

# The following three lines of code creates a data frame or table to show the three odds ratios

col1 = ["survivor_or", "case_cohort_or", "person_yrs_or"]
col2 = [survivor_or, case_cohort_or, person_yrs_or]
df2 = DataFrame(:feature => col1, :odd_ratio => col2, :rate_ratio => rate_ratio)

# Prevalence studies

## the following lines list the various variables

a1 = 909 # cases and exposed
b1 = 476 # cases and non-exposed
N1 = 10_000 # total number of people studied among the exposed
N2 = 10_000 # total number of non-exposed people
c4 = N1 - a1 # non-cases or controls among the exposed
d4 = N2 - b1  # non-cases or controls among the non-exposed
p1 = round(a1 / N1, digits = 4) # prevalence among the exposed
p0 = round(b1 / N2, digits = 4) # prevalence among the non-exposed
O1 = round(p1 / (1 - p1), digits = 4) # Odds among the exposed
O0 = round(p0 / (1 - p0), digits = 4) # Odds among the non-exposed

## The followng three lines of codes create a data frame for the prevalence studies

exp1 = [a1, c4, N1, p1, O1]
exp2 = [b1, d4, N2, p0, O0]
features = ["Cases", "Non-cases", "Total Population", "Prevalence", "Prevalence odds"]
prevalence_df = DataFrame(:Names => features,
:Exposed => exp1,
:Non_exposed => exp2)

# the following lines of code provides the prevalence ratios and prevalence odds ratios
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

# the following lines of codes create the data frame for prevalence case contorl study

exposed_stats = [a2, c5, po1]
non_exposed_stats = [b2, d5, po2]
featurenames = ["cases", "controls", "prevalence odds"]
df_cc = DataFrame(:feature_names => featurenames, :Exposed => exposed_stats, 
:Nonexposed => non_exposed_stats)

# the following line of code provides prevalence odds ratio

prevalence_odds_ratio_here = po1 / po2 

## Continuous outcome measures 
# No data analysis or mock data analysis has been done, the author has discussed longitudinal and cross-sectional surveys













