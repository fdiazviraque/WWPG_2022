library("sleuth")
base_dir <- "/home/manager/Task_1_SexualDevelopment"
s2c <- read.table(file.path(base_dir, "hiseq_info_task1.txt"), header = TRUE, stringsAsFactors=FALSE)

sample_id <- c("Pb_MUT1", "Pb_MUT2", "Pb_MUT3", "Pb_WT1", "Pb_WT2", "Pb_WT3")
kal_dirs <- sapply(sample_id, function(id) file.path(base_dir, id))
s2c <- dplyr::select(s2c, sample = sample, condition)
s2c <- dplyr::mutate(s2c, path = kal_dirs)


t2g<-read.table(file.path(base_dir, "PbANKA_v3.desc"), header=TRUE, sep="\t")


so <- sleuth_prep(s2c, ~ condition, target_mapping = t2g)
so <- sleuth_fit(so)
so <- sleuth_fit(so, ~1, 'reduced')
#so <- sleuth_lrt(so, 'reduced', 'full')
so <- sleuth_wt(so, 'conditionWT', 'full')

results_table <- sleuth_results(so, 'conditionWT', test_type = 'wt')

write.table(results_table, file="kallisto.results", quote=FALSE, sep="\t", row.names=FALSE)

sleuth_live(so)

