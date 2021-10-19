install.packages("data.table")
install.packages("tidyverse")

Sys.setenv(DOWNLOAD_STATIC_LIBV8 = 1)
install.packages("rstan", repos = "https://cloud.r-project.org/", dependencies = TRUE)
