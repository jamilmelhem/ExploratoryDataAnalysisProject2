require(dplyr)
require(ggplot2)

nei_data <- readRDS("summarySCC_PM25.rds")
scc_data <- readRDS("Source_Classification_Code.rds")

png("plot3.png", width=480, height=480, units="px")

# Group Emissions by year and sum them
total_emissions_baltimore <- summarise(group_by(filter(nei_data, fips == "24510"), year, type), Emissions = sum(Emissions))

ggplot(total_emissions_baltimore, aes(x=factor(year), y=Emissions, group=type, fill=type)) + 
  geom_bar(position="dodge",stat="identity") + 
  facet_grid(. ~ type) +
  xlab("year") +
  ylab("Total OM25 emissions in tons")

dev.off()