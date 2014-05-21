#require(graph)
# First we load the ipgrah package
library(igraph)

t = c("character", "character", "numeric")
fb.data = read.table("prefiltered.csv", header=T, colClasses=t)
fb.matrix = as.matrix(fb.data[,1:2])
g = graph.edgelist(fb.matrix, directed=F)
E(g)$weight = fb.data[,3]
fc <- fastgreedy.community(g)
com<-community.to.membership(g, fc$merges, steps= which.max(fc$modularity)-1)
V(g)$color <- com$membership+1
g$layout <- layout.fruchterman.reingold
plot(g, vertex.label=NA)
com
