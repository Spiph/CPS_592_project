#!/usr/bin/env Rscript
library(dagitty)
library(lavaan)

# Load data from csv
# d <- read.csv("/home/alex/soar/logTesting/test.csv")
d <- read.csv("/home/alex/soar/logTesting/format3.csv")

# Corrected DAG
# g <- dagitty('dag {
# Energy [exposure,pos="-0.832,-0.119"]
# Movement [pos="-0.316,-1.547"]
# Radar [pos="0.488,-1.570"]
# Shields [pos="-1.096,-1.553"]
# SurvivalTime [outcome,pos="-0.825,1.484"]
# TankState [pos="-1.550,-0.120"]
# Energy -> SurvivalTime
# Energy -> TankState
# Energy <-> Radar
# Movement -> Energy
# Movement -> Radar
# Movement -> Shields
# Shields -> Energy
# TankState -> SurvivalTime
# }')
g <- dagitty('dag {
Energy [exposure,pos="-0.414,-1.357"]
Movement [pos="0.462,-0.949"]
Radar [pos="0.353,0.003"]
Shields [pos="-1.337,-0.934"]
SurvivalTime [outcome,pos="-0.422,-0.671"]
TankState [pos="-1.326,0.016"]
Energy -> Movement
Energy -> TankState
Energy <-> Radar
Movement -> Shields
Movement <-> SurvivalTime
Radar -> Movement
Radar -> SurvivalTime
Shields -> Energy
SurvivalTime -> Shields
TankState -> Shields
TankState -> SurvivalTime
}')
# Convert to lavaan object and fit model to data
# Determine and display path coefficients
m = toString(g, "lavaan")
fit = sem(m,d)
summary(fit)




# ======================= OUTPUT =======================
# This is lavaan 0.6-7
# lavaan is BETA software! Please report any bugs.
# Warning message:
# In lav_data_full(data = data, group = group, cluster = cluster,  :
#   lavaan WARNING: some observed variances are (at least) a factor 1000 times larger than others; use varTable(fit) to investigate
# lavaan 0.6-7 ended normally after 71 iterations

#   Estimator                                         ML
#   Optimization method                           NLMINB
#   Number of free parameters                         19
                                                      
#   Number of observations                          1844
                                                      
# Model Test User Model:
                                                      
#   Test statistic                                 0.497
#   Degrees of freedom                                 1
#   P-value (Chi-square)                           0.481

# Parameter Estimates:

#   Standard errors                             Standard
#   Information                                 Expected
#   Information saturated (h1) model          Structured

# Regressions:
#                    Estimate  Std.Err  z-value  P(>|z|)
#   Radar ~                                             
#     Energy            0.057    0.002   29.084    0.000
#   SurvivalTime ~                                      
#     Energy            0.836    0.044   18.938    0.000
#   TankState ~                                         
#     Energy           -0.005    0.001   -5.187    0.000
#   Energy ~                                            
#     Movement         -0.822    0.013  -64.613    0.000
#   Radar ~                                             
#     Movement          0.038    0.001   25.055    0.000
#   Shields ~                                           
#     Movement          0.542    0.009   63.245    0.000
#   SurvivalTime ~                                      
#     Movement          0.157    0.042    3.686    0.000
#   TankState ~                                         
#     Movement          0.002    0.001    2.079    0.038
#   SurvivalTime ~                                      
#     Radar             4.996    0.209   23.911    0.000
#   TankState ~                                         
#     Radar             0.026    0.005    5.409    0.000
#   Energy ~                                            
#     Shields           1.849    0.019   95.254    0.000
#   SurvivalTime ~                                      
#     Shields           1.090    0.086   12.726    0.000
#   TankState ~                                         
#     Shields           0.002    0.002    0.871    0.384
#   SurvivalTime ~                                      
#     TankState         8.960    0.997    8.988    0.000

# Variances:
#                    Estimate  Std.Err  z-value  P(>|z|)
#    .Radar            24.479    0.806   30.364    0.000
#    .SurvivalTime   1940.107   63.894   30.364    0.000
#    .TankState         1.059    0.035   30.364    0.000
#    .Energy          589.744   19.422   30.364    0.000
#    .Shields         848.836   27.955   30.364    0.000
