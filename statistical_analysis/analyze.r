#!/usr/bin/env Rscript
# Load the R package
library(dagitty)

# Load data from local file
d <- read.csv("/home/alex/soar/logTesting/format3.csv")

print(head(d))
print(d[0])

print("CSV Loaded")
# Download DAG from daggity.net
# g <- downloadGraph("http://dagitty.net/m1JcFUf")

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
}

')
print(g)




# Mvmn _||_ SrvT | Enrg 0.7839363  0.000000e+00 0.7902793 0.8335213
# Mvmn _||_ TnkS | Enrg 0.2742788  5.771757e-33 0.2315633 0.3161994
# Radr _||_ SrvT | Enrg 0.6557834 4.185973e-248 0.6368683 0.6934017
# Radr _||_ TnkS | Enrg 0.2422793  5.744035e-26 0.1988396 0.2849175
# Shld _||_ SrvT | Enrg 0.7933100  0.000000e+00 0.8024058 0.8445911
# Shld _||_ TnkS | Enrg 0.2666858  2.917144e-31 0.2237883 0.3087814


# print("implied conditional independencies:")
# test <- impliedConditionalIndependencies(g, type = "missing.edge", max.results = Inf)
# print(test)

# print(g)

print("Graph Loaded")

# print(g.is.numeric())
# Evaluate the d-separation implications of the DAG
r <- localTests(g,d)
# print(r)
print("Local test performed")
print(r)
# Perform Holm-Bonferroni correction
r$p.value <- p.adjust(r$p.value)

print(r$p.value)
print("Correction performed")

# Focus on tests with p-values below a threshold
r <- r[r$p.value < 0.05,]
cat("\n\n")
print(r)

print("Results threshed")

# Plot results
if(length(r) > 1){
    plotLocalTestResults(r)
}

print("after local tests")
# print(g)

# ec <- equivalentDAGs(g)

# for( i in seq_along( ec ) ) { 
#     cat(i, ": ")
#     # print(ec)
#     print( adjustmentSets( ec[[i]], "Energy", "SurvivalTime"))}
