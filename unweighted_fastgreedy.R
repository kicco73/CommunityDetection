#require(graph)
# First we load the ipgrah package
library(igraph)

t = c("character", "character", "numeric")
fb.data = read.table("prefiltered.csv", header=T, colClasses=t)
fb.data$weight = NULL
fb.matrix = as.matrix(fb.data)
g = graph.edgelist(fb.matrix, directed=F)
fc <- fastgreedy.community(g)
com<-community.to.membership(g, fc$merges, steps= which.max(fc$modularity)-1)
V(g)$color <- com$membership+1
g$layout <- layout.fruchterman.reingold
plot(g, vertex.label=NA)
com
