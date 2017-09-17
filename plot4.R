require(dplyr)
require(ggplot2)

nei_data <- readRDS("summarySCC_PM25.rds")
scc_data <- readRDS("Source_Classification_Code.rds")

png("plot4.png", width=480, height=480, units="px")

coal_combustion <- grepl("Fuel Comb.*Coal", scc_data$EI.Sector)
coal_combustion_sources <- scc_data[coal_combustion,]

# Find emissions from coal combustion-related sources
coal_combustion_emissions <- NEI[(NEI$SCC %in% combustion.coal.sources$SCC), ]

coal_emissions <- summarise(group_by(coal_combustion_emissions, year), Emissions=sum(Emissions))

ggplot(coal_emissions, aes(x=factor(year), y=Emissions/1000 ,fill = year, label = round(Emissions/1000,3))) + 
  geom_bar(position="dodge",stat="identity") + 
  xlab("year") +
  ylab("Total PM25 emissions in kilotons") +
  ggtitle("Emissions from coal combustion sources in kilotons") +
  geom_label(aes(fill = year),colour = "white", fontface = "bold")
dev.off()