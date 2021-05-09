r = getOption("repos")
r["CRAN"] = "http://cran.us.r-project.org"
options(repos = r)


Begin = Sys.time()


# ############################################ #
##### FUNCTION: Install & Load R Packages  #####
# ############################################ #
instant_pkgs <- function(pkgs) { 
    pkgs_miss <- pkgs[which(!pkgs %in% installed.packages()[, 1])]
    if (length(pkgs_miss) > 0) {
        install.packages(pkgs_miss)
    }
    
	if (length(pkgs_miss) == 0) {
	message("\n ...Packages were already installed!\n")
	}
	
    # install packages not already loaded:
    pkgs_miss <- pkgs[which(!pkgs %in% installed.packages()[, 1])]
    if (length(pkgs_miss) > 0) {
        install.packages(pkgs_miss)
    }
    
    # load packages not already loaded:
    attached <- search()
    attached_pkgs <- attached[grepl("package", attached)]
    need_to_attach <- pkgs[which(!pkgs %in% gsub("package:", "", attached_pkgs))]
    
    if (length(need_to_attach) > 0) {
      for (i in 1:length(need_to_attach)) require(need_to_attach[i], character.only = TRUE)
    }
	
	if (length(need_to_attach) == 0) {
	message("\n ...Packages were already loaded!\n")
	}
}

##### R Package List ######
# package.list=c("MASS","gplots","RColorBrewer","rgl","ggplot2","GGally","network","sna","reshape2","lubridate","ggmap",
#			"plot3D","corrplot","CCA","sqldf","McSpatial","anytime","sp","rgdal","maps","bizdays","tools",
#		"plotGoogleMaps","dtw","TSclust","lattice","e1071","RColorBrewer","rwunderground","geonames","rjson","jsonlite",
#		"RCurl","dplyr","mailR","sendmailR","taskscheduleR","maptools","stringr","doSNOW","data.table")
#
#instant_pkgs(package.list)


#instant_pkgs("plotGoogleMaps") 
instant_pkgs("gplots") 
instant_pkgs("RColorBrewer")
#instant_pkgs("rgl")
instant_pkgs("ggplot2")
instant_pkgs("GGally")
instant_pkgs("network")
instant_pkgs("sna")
instant_pkgs("reshape2")
instant_pkgs("lubridate")
#instant_pkgs("ggmap")
instant_pkgs("extrafont")
instant_pkgs("plot3D")
instant_pkgs("corrplot")
instant_pkgs("CCA")
instant_pkgs("sqldf")
instant_pkgs("McSpatial")
instant_pkgs("anytime")
instant_pkgs("sp")
instant_pkgs("rgdal")
instant_pkgs("maps")
instant_pkgs("bizdays")
instant_pkgs("tools")
instant_pkgs("ggthemes")
instant_pkgs("revgeo")
instant_pkgs("dtw")
instant_pkgs("TSclust")
#instant_pkgs("lattice")
instant_pkgs("e1071")
instant_pkgs("RColorBrewer")
instant_pkgs("rwunderground")
instant_pkgs("geonames")
instant_pkgs("rjson")
## instant_pkgs("jsonlite") (Peter)
## instant_pkgs("RCurl") (Peter)
instant_pkgs("dplyr")
#instant_pkgs("mailR")
instant_pkgs("sendmailR")
#instant_pkgs("taskscheduleR")
instant_pkgs("maptools")
instant_pkgs("stringr")
instant_pkgs("doSNOW")
instant_pkgs("data.table")
instant_pkgs("ranger")
instant_pkgs("flock")
instant_pkgs("viridis")



# ###########
instant_pkgs("sqldf")
instant_pkgs("randomForest")
instant_pkgs("gbm")
instant_pkgs("glmnet")
instant_pkgs("msgps")
## instant_pkgs("RCurl") (Peter)
instant_pkgs("h2o")
instant_pkgs("xts")
instant_pkgs("car")
instant_pkgs("e1071")
#instant_pkgs("ridge")
## instant_pkgs("broom") (Peter)
instant_pkgs("CVST")
instant_pkgs("prodlim")
instant_pkgs("caret")
## instant_pkgs("nnet") (Peter)
instant_pkgs("pls")
instant_pkgs("beepr")
instant_pkgs("ranger")
instant_pkgs("xgboost")
instant_pkgs("doParallel")
instant_pkgs("foreach")
#instant_pkgs("lubridate")
instant_pkgs("mlbench")
#instant_pkgs("mxnet")
instant_pkgs("PerformanceAnalytics")
instant_pkgs("parcor")
instant_pkgs("FNN")
#instant_pkgs("dplyr")
instant_pkgs("maps")
instant_pkgs("gstat") 
instant_pkgs("Rcpp")
instant_pkgs("rlang")
instant_pkgs("tibble")
instant_pkgs("datetime")


End = Sys.time()
End - Begin


