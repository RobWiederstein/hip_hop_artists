file <- "./hip_hop_artists.csv"
df <- read.csv(file = file, header = T, colClasses = "character")
df$city <- stringr::str_extract(df$location, "^(.+?),")
df$city <- gsub(",", "", df$city)
df$state <- stringr::str_extract(df$location, ", (.+?),")
df$state <- gsub(", |,", "", df$state)

a <- strsplit(df$location, ",")
df$city <- unlist(lapply(a, "[", 1))
df$state <- stringr::str_trim(unlist(lapply(a, "[", 2)))
df$country <- stringr::str_trim(unlist(lapply(a, "[", 3)))
df$dateOfDeath <- as.Date(df$date.of.death, format = "%d-%b-%y")
df.01 <- dplyr::select(df, c(dateOfDeath,
                            name,
                            age,
                            cause,
                            city,
                            state,
                            country)
                 )
df.02 <- na.omit(df.01)
file <- "2020-04-11-hip-hop-artist-deaths-revised.csv"
write.csv(df.02, file = file, row.names = F)

file <- "./2020-04-11-hip-hop-artist-deaths-revised_geocodio_7450c46fcae736d9166df07a04517488cad6a244.csv"
df <- read.csv(file = file, header = T, colClasses = "character")
df.01 <- dplyr::filter(df, country == "U.S.")
df.02 <- dplyr::select(df.01, dateOfDeath:Longitude)
colnames(df.02)[8] <- "lat"
colnames(df.02)[9] <- "lon"

file <- "./2020-04-11-hip-hop-artist-deaths-revd-01.csv"
write.csv(df.02, file = file, row.names = F)



