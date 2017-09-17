require(dplyr)

nei_data <- readRDS("summarySCC_PM25.rds")
scc_data <- readRDS("Source_Classification_Code.rds")

png("plot2.png", width=480, height=480, units="px")
# Group Emissions by year and sum them
total_emissions_baltimore <- summarise(group_by(filter(nei_data, fips == "24510"), year), Emissions = sum(Emissions))

pmi_plot_baltimore <- barplot(height=total_emissions_baltimore$Emissions/1000, names.arg=total_emissions_baltimore$year,
                    xlab="years", ylab=expression('PM'[2.5]*' emission in tons'),ylim=c(0,4),
                    main=expression('Total PM'[2.5]*' emissions by years'))

## Add total emissions values as labels
text(x = pmi_plot, y = round(total_emissions_baltimore$Emissions/1000,3), label = round(total_emissions_baltimore$Emissions/1000,3), pos = 3, cex = 0.8, col = "black")

dev.off()
