require(dplyr)
require(ggplot2)

nei_data <- readRDS("summarySCC_PM25.rds")
scc_data <- readRDS("Source_Classification_Code.rds")

png("plot5.png", width=480, height=480, units="px")

# summarize motor vehicle emissions for baltimore
emissions_baltimore <- filter(nei_data, fips=="24510", type=="ON-ROAD")
yearly_emissions_baltimore <- summarise(group_by(emissions_baltimore, year), Emissions=sum(Emissions))

ggplot(yearly_emissions_baltimore, aes(x=factor(year), y=Emissions ,fill = year, label = round(Emissions,2))) + 
  geom_bar(position="dodge",stat="identity") + 
  xlab("year") +
  ylab("Total PM25 emissions in kilotons") +
  ggtitle("Coal combustion emission sources in tons") +
  geom_label(aes(fill = year),colour = "white", fontface = "bold")

dev.off()
