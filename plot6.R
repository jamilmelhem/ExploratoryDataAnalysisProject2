require(dplyr)
require(ggplot2)

nei_data <- readRDS("summarySCC_PM25.rds")
scc_data <- readRDS("Source_Classification_Code.rds")

png("plot6.png", width=480, height=480, units="px")

# summarize motor vehicle emissions for baltimore and los angeles
yearly_emissions_baltimore<-summarise(group_by(filter(nei_data, fips=="24510", type=="ON-ROAD"), year), Emissions=sum(Emissions))
yearly_emissions_losanglese<-summarise(group_by(filter(nei_data, fips=="06037", type=="ON-ROAD"), year), Emissions=sum(Emissions))

yearly_emissions_baltimore$county <- "Baltimore"
yearly_emissions_losanglese$county <- "Los Anglese"
yearly_emissions_combined <- rbind(yearly_emissions_baltimore, yearly_emissions_losanglese)

ggplot(yearly_emissions_combined, aes(x=factor(year), y=Emissions, fill = county)) + 
  geom_bar(stat="identity") + 
  facet_grid(county~., scales="free") +
  xlab("year") +
  ylab("Total PM25 emissions in tons") +
  ggtitle("Motor vehicle emission variation in Baltimore and Los Angeles in tons")

dev.off()