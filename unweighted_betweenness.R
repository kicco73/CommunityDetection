require(igraph)

# Caricamento del file prefiltrato contenente l'ego network

classes = c("character", "character", "numeric")
ego_network = read.table("FBdatasets/prefiltered.csv", header=T, colClasses=classes)
ego_network$weight = NULL
ego_network.graph = graph.edgelist(as.matrix(ego_network), directed=F)

# Calcolo delle community (usando il massimo della modularity)

ego_network.community = edge.betweenness.community(ego_network.graph, directed=F, modularity=T)
print(ego_network.community)

#V(ego_network.graph)$color = ego_network.community$membership
#ego_network.graph$layout = layout.fruchterman.reingold
#plot(ego_network.graph, vertex.label=NA)
 
m = matrix(c(weighted_ego_network.community$names, weighted_ego_network.community$membership), ncol=2)
write.table(m, "Results/unweighted_betweenness.csv", sep="\t", col.names=c("key", "membership"), row.names=F)
print(m)
