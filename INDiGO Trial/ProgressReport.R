setwd("c:/Users/yuceesay/OneDrive - London School of Hygiene and Tropical Medicine/Desktop/INDiGO Trial/")

indigo_data <- read.csv("DATA_2023-09-12.csv")
View(indigo_data)

#total consented participants
total_consented <- sum(!is.na(indigo_data$con_date_q5) & indigo_data$con_date_q5 !="")
print(total_consented)

#total consented this month.
indigo_data$con_date_q5 <- as.Date(indigo_data$con_date_q5)
current_month <- format(Sys.Date(), "%Y-%m")

Monthly_consented <- sum(format(indigo_data$con_date_q5, "%Y-%m") == current_month &  !is.na(indigo_data$con_date_q5) )
print(Monthly_consented)

#consented eden participant
eden_participant <-indigo_data$con_eden_participant_q10
consented_eden_participant <- sum(eden_participant== '1' & !is.na(eden_participant) & eden_participant !="")
print(consented_eden_participant)
 
#consented per cluster
participant_cluster <- indigo_data$con_cluster_q12
consented_west <- sum(participant_cluster =='1' & !is.na(participant_cluster))
print(consented_west)

#total recruited participant
recruit_date <- indigo_data$rvdate
total_recruited <- sum(!is.na(recruit_date) & recruit_date !="")
print(total_recruited)

#total eligible
eligible_recruit <- indigo_data$eligible
total_eligible <- sum(eligible_recruit=='1' & !is.na(eligible_recruit) & eligible_recruit !="")
print(total_eligible)

#
#total randomised
randomized <- indigo_data$ran_date
total_randomised <- sum(!is.na(randomized) & randomized !="")
print(total_randomised)


#recruitment to consent ratio
recruitment_ratio <- total_recruited/total_consented * 100
print(recruitment_ratio)

#monthly recruited
recrDate_form <- as.Date(indigo_data$rvdate)

Monthly_recruited <- sum(format(recrDate_form, "%Y-%m") == current_month & !is.na(recrDate_form) & indigo_data$rvdate !="")
print(Monthly_recruited)



#monthly recruitment status
expected_monthly_recuit = 25
month_recruitment_status = (Monthly_recruited/expected_monthly_recuit) * 100
print(month_recruitment_status)

#total withdrawals
withdrawals <- indigo_data$wd_date_q1
total_withdrawn <- sum(!is.na(withdrawals) & withdrawals !="")
print(total_withdrawn)

#drop out rate
withdrawal_rate <- (total_withdrawn/total_recruited) * 100
print(withdrawal_rate)

#ip accountability
supplements <-indigo_data$ms_sup_administered_q2
total_supplements <- sum(supplements=='1' & !is.na(supplements) & supplements !="")
print(total_supplements)

#supplemented participants
part_supplement <- length(unique(indigo_data$con_participantid_q1[indigo_data$ms_sup_administered_q2=='1']))
print(part_supplement)


