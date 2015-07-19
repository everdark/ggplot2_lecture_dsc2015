#!/usr/bin/env Rscript

src_path <- "./data"
citynames <- unique(gsub("_.*", '', dir(src_path)))
citynames <- citynames[1:4] # take english version only
dat <- list()
for ( city in citynames ) {
    dat[[city]] <- do.call(rbind, lapply(grep(city, dir(src_path, full.names=TRUE), value=TRUE), 
                                         read.csv, stringsAsFactors=FALSE))
    dat[[city]]$city <- city
}
dat <- do.call(rbind, dat)
save("./rdata/for_exercise.RData")
