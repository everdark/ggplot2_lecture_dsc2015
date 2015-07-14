get_weather_all = function() {
    filepaths <- list.files("data", pattern = "[a-zA-Z]_....-...csv", full.names = TRUE)
    locations <- gsub("data\\/|_....-..\\.csv", "", filepaths)
    weather_all <- NULL
    for (i in 1:length(filepaths)) {
        temp <- read.csv(filepaths[i], stringsAsFactors = FALSE)
        temp$location <- locations[i]
        weather_all <- rbind(weather_all, temp)
    }
    
    weather_all$location <- factor(weather_all$location)
    weather_all$date <- as.Date(substr(weather_all$T.Max.Time, 1, 10))
    weather_all$month <- months(weather_all$date)
    
    # deal with "T"
    weather_all$Precp[weather_all$Precp == "T"] <- "0"
    weather_all$PrecpMax10[weather_all$PrecpMax10 == "T"] <- "0"
    weather_all$PrecpHrMax[weather_all$PrecpHrMax == "T"] <- "0"
    weather_all$Precp <- as.numeric(weather_all$Precp)
    weather_all$PrecpMax10 <- as.numeric(weather_all$PrecpMax10)
    weather_all$PrecpHrMax <- as.numeric(weather_all$PrecpHrMax)
    
    # deal with "x"
    weather_all$EvapA[weather_all$EvapA == "x"] <- NA
    weather_all$EvapA <- as.numeric(weather_all$EvapA)
    weather_all$GloblRad[weather_all$GloblRad == "x"] <- NA
    weather_all$GloblRad <- as.numeric(weather_all$GloblRad)
    return(weather_all)
}