getwd()

setwd("C:/Users/Felix/Documents/R koder/Slaa CVR numre op")

library(readr)

DELTAGERE <- read_csv("CVR data/DELTAGERE.csv", 
                      locale = locale(date_format = "%d-%m-%Y"))
View(DELTAGERE)
names(DELTAGERE)

# Kan joine virksomhedsens navn på med Virksomhes tabellen by = CVRNR
# Tabellen er næsten klar til at være relations tabel i en netværks graf. 

library(dplyr)
edge <- dplyr::select(DELTAGERE, from = cvrnr, to = oplysninger_navn)

nodes1 <- dplyr::distinct(edge, label = from)
nodes1$label <- as.character(nodes1$label)
nodes2 <- dplyr::distinct(edge, label = to)
nodes <-  bind_rows(nodes1, nodes2)
nodes$id <- 1:nrow(nodes)


edge %>% group_by(cvrnr) %>% count() %>% arrange(desc(n))


f <-  10001331

fedge  <-  filter(edge, from == f)


visNetwork::visNetwork(nodes = nodes, edges = fedge, width = "150%")

visNetwork::visNetwork()