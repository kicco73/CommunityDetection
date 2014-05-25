# INTERACTION GRAPH (number of posts as weight)

require(igraph)

# Caricamento del file prefiltrato contenente l'ego network

classes = c("character", "character", "numeric")
weighted_ego_network = read.table("prefiltered.csv", header=T, colClasses=classes)
weighted_ego_network.graph = graph.data.frame(weighted_ego_network, directed=F, vertices=NULL)

# Calcola le community pesate con fastgreedy, massimizzando la modularity

weighted_ego_network.community = fastgreedy.community(weighted_ego_network.graph, modularity=T)
print(weighted_ego_network.community)

#V(weighted_ego_network.graph)$color = weighted_ego_network.community$membership
#weighted_ego_network.graph$layout = layout.fruchterman.reingold
#plot(weighted_ego_network.graph, vertex.label=NA)
