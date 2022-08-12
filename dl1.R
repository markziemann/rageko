library(googledrive)

myfiles <- drive_ls(path="~/myfoldername")

sapply(myfiles$id , drive_download)
