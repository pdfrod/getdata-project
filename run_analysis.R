library(reshape2)


main <- function() {
  feature_names <- read.table('UCI HAR Dataset/features.txt')[, 2]
  activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt')

  train.dataset <- read.dataset("train", feature_names, activity_labels)
  test.dataset <- read.dataset("test", feature_names, activity_labels)

  # Requirement 1 - merge the training and the test sets to create one data set
  dataset <- rbind(train.dataset, test.dataset)

  # Requirement 2 - extract only the measurements on the mean and standard deviation
  dataset <- dataset[, grepl("mean\\(|std|activity|subject", names(dataset))]

  # Requirement 5 - create a second data set with the average of each variable
  # for each activity and each subject
  dataset.melt <- melt(dataset, id=c("activity", "subject"))
  final.dataset <- dcast(dataset.melt, activity + subject ~ variable, mean)

  write.table(final.dataset, "output.txt", row.name=FALSE)
  final.dataset
}


read.dataset <- function(type, feature_names, activity_labels) {
  dataset <- read.table(paste0('UCI HAR Dataset/', type, '/X_', type, '.txt'))

  # Requirement 4 - label the data set with descriptive variable names
  names(dataset) <- feature_names

  # Requirement 3 - use descriptive activity names
  activities <- read.table(paste0('UCI HAR Dataset/', type, '/y_', type, '.txt'))[, 1]
  dataset$activity <- sapply(activities,
                             function(i) { activity_labels[activity_labels[1] == i, 2] })

  dataset$subject <- read.table(paste0('UCI HAR Dataset/', type, '/subject_', type, '.txt'))[, 1]

  dataset
}
