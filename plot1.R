require(dplyr)
nei_data <- readRDS("summarySCC_PM25.rds")
scc_data <- readRDS("Source_Classification_Code.rds")

png("plot1.png", width=480, height=480, units="px")
# Group Emissions by year and sum them
total_emissions <- summarise(group_by(nei_data, year), Emissions = sum(Emissions))

pmi_plot <- barplot(height=total_emissions$Emissions/1000, names.arg=total_emissions$year,
        xlab="years", ylab=expression('PM'[2.5]*' emission in kilotons'),ylim=c(0,8000),
        main=expression('Total PM'[2.5]*' emissions by years'))

## Add total emissions values as labels
text(x = pmi_plot, y = round(total_emissions$Emissions/1000,1), label = round(total_emissions$Emissions/1000,1), pos = 3, cex = 0.8, col = "black")

dev.off()
