# WEIGHTED EGO NETWORK (number of posts as weight)

require(igraph)

# Caricamento del file prefiltrato con pesi

classes = c("character", "character", "numeric")
weighted_ego_network = read.table("FBdatasets/prefiltered.csv", header=T, colClasses=classes)
weighted_ego_network.graph = graph.data.frame(weighted_ego_network, directed=F, vertices=NULL)

# Calcolo delle community usando la massimizzazione della modularity

weighted_ego_network.community = edge.betweenness.community(weighted_ego_network.graph, directed=F, modularity=T)
#print(weighted_ego_network.community)

# Disegna il grafico

#V(weighted_ego_network.graph)$color = weighted_ego_network.community$membership 
#weighted_ego_network.graph$layout = layout.fruchterman.reingold
#plot(weighted_ego_network.graph, vertex.label=NA)

m = matrix(c(weighted_ego_network.community$names, weighted_ego_network.community$membership), ncol=2)
write.table(m, "Results/weighted_betweenness.csv", sep="\t", col.names=c("key", "membership"), row.names=F)
print(m)
