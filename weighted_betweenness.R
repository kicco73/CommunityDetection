#require(graph)
# First we load the ipgrah package
library(igraph)

t = c("character", "character", "numeric")
fb.data = read.table("prefiltered.csv", header=T, colClasses=t)
g = graph.data.frame(fb.data, directed=F, vertices=NULL)

ebc <- edge.betweenness.community(g, directed=F)
 
mods <- sapply(0:ecount(g), function(i){
  g2 <- delete.edges(g, ebc$removed.edges[seq(length=i)])
  cl <- clusters(g2)$membership
  modularity(g,cl)
})
 
g <- delete.edges(g, ebc$removed.edges[seq(length=which.max(mods)-1)])
V(g)$color=clusters(g)$membership
 
g$layout <- layout.fruchterman.reingold
plot(g, vertex.label=NA)
clusters(g)$membership
 
