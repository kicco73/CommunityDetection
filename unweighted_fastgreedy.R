require(igraph)

# Caricamento del file prefiltrato contenente l'ego network

classes = c("character", "character", "numeric")
ego_network = read.table("prefiltered.csv", header=T, colClasses=classes)
ego_network$weight = NULL
ego_network.graph = graph.edgelist(as.matrix(ego_network), directed=F)

# Calcolo delle community usando fastgreedy + max modularity

ego_network.community = fastgreedy.community(ego_network.graph, modularity=T)
print(ego_network.community)

V(ego_network.graph)$color = ego_network.community$membership
ego_network.graph$layout <- layout.fruchterman.reingold
plot(ego_network.graph, vertex.label=NA)
