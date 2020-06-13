library(reshape2)
##reading labels of data(activity and features)
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
features<-read.table("UCI HAR Dataset/features.txt")

##Finding the features with mean and standard deviation only
features_req<-grep(".*mean.*|.*std.*",features[,2])
features_req.list<-features[features_req,2]

##Renaming the features to be comfortable
features_req.list<-gsub("-mean","Mean",features_req.list)
features_req.list<-gsub("-std","Std",features_req.list)
features_req.list<-gsub('[-()]','',features_req.list)

##Reading datasets "train" and binding its columns with activity and subjects
train<-read.table("UCI HAR Dataset/train/X_train.txt")
train<-train[features_req]
train_activities<-read.table("UCI HAR Dataset/train/Y_train.txt")
train_subjects<-read.table("UCI HAR Dataset/train/subject_train.txt")
train<-cbind(train_subjects,train_activities,train)

##Reading datasets "test" and binding its columns with activity and subjects
test<-read.table("UCI HAR Dataset/test/X_test.txt")
test<-test[features_req]
test_activities<-read.table("UCI HAR Dataset/test/Y_test.txt")
test_subjects<-read.table("UCI HAR Dataset/test/subject_test.txt")
test<-cbind(test_subjects,test_activities,test)

##Merging "train" and "test" dataset
final_data<-rbind(train,test)
colnames(final_data)<-c("subject","activity",features_req.list)

#Modifying subjects and activities into factors
final_data$activity<-factor(final_data$activity,levels = activity_labels[,1], labels = activity_labels[,2])
final_data$subject<-as.factor(final_data$subject)

##Melting the data to make it tidy
final_data.melted<-melt(final_data,id=c("subject","activity"))
final_data.mean<-dcast(final_data.melted,subject+activity~variable,mean)

##Finally writing the tidy data to file "tidy.txt"
write.table(final_data.mean,"tidy.txt",row.names=FALSE,quote=FALSE)