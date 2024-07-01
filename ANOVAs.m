clc
clear
close all

a0=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/Off_vs_HC_fold0.mat");
a1=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/Off_vs_HC_fold1.mat");
a2=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/Off_vs_HC_fold2.mat");
a3=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/Off_vs_HC_fold3.mat");
a4=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/Off_vs_HC_fold4.mat");
a5=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/Off_vs_HC_fold5.mat");
a6=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/Off_vs_HC_fold6.mat");
a7=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/Off_vs_HC_fold7.mat");
a8=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/Off_vs_HC_fold8.mat");
a9=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/Off_vs_HC_fold9.mat");

aa1 = cat(1,a0.matrix_name,a1.matrix_name,a2.matrix_name,a3.matrix_name,a4.matrix_name,a5.matrix_name,a6.matrix_name,a7.matrix_name,a8.matrix_name,a9.matrix_name);


freq_bands = {'delta','delta','delta','delta','delta','delta','delta',...
    'theta','theta','theta','theta','theta','theta','theta','theta',...
    'low_alpha','low_alpha','low_alpha','low_alpha',...
    'high_alpha','high_alpha','high_alpha','high_alpha',...
    'low_beta','low_beta','low_beta','low_beta','low_beta','low_beta',...
    'mid_beta','mid_beta','mid_beta','mid_beta','mid_beta','mid_beta','mid_beta','mid_beta','mid_beta','mid_beta',...
    'high_beta', 'high_beta','high_beta','high_beta','high_beta','high_beta','high_beta','high_beta','high_beta','high_beta','high_beta','high_beta',...
    'high_beta','high_beta','high_beta','high_beta','high_beta','high_beta','high_beta',...
    'gamma','gamma','gamma','gamma','gamma','gamma','gamma','gamma','gamma','gamma',...
    'gamma','gamma','gamma','gamma','gamma','gamma','gamma','gamma','gamma','gamma',...
    'gamma','gamma','gamma','gamma','gamma','gamma','gamma','gamma','gamma','gamma',...
    'gamma','gamma','gamma','gamma','gamma','gamma','gamma','gamma','gamma','gamma',...
    'gamma','gamma','gamma','gamma','gamma','gamma','gamma','gamma','gamma','gamma',...
    'gamma','gamma','gamma','gamma','gamma','gamma','gamma','gamma','gamma'};
    
[~,~,stats] = anova1(aa1,freq_bands);
%% 

a0=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_HC_fold0.mat");
a1=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_HC_fold1.mat");
a2=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_HC_fold2.mat");
a3=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_HC_fold3.mat");
a4=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_HC_fold4.mat");
a5=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_HC_fold5.mat");
a6=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_HC_fold6.mat");
a7=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_HC_fold7.mat");
a8=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_HC_fold8.mat");
a9=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_HC_fold9.mat");

aa2 = cat(1,a0.matrix_name,a1.matrix_name,a2.matrix_name,a3.matrix_name,a4.matrix_name,a5.matrix_name,a6.matrix_name,a7.matrix_name,a8.matrix_name,a9.matrix_name);
[~,~,stats] = anova1(aa2,freq_bands);
%%


a0=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_Off_fold0.mat");
a1=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_Off_fold1.mat");
a2=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_Off_fold2.mat");
a3=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_Off_fold3.mat");
a4=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_Off_fold4.mat");
a5=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_Off_fold5.mat");
a6=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_Off_fold6.mat");
a7=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_Off_fold7.mat");
a8=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_Off_fold8.mat");
a9=load("D://TEHRAN.uni/THESIS/Parkinson/Codes/Networks_weights_399_ALL/Mat_format/On_vs_Off_fold9.mat");

aa3 = cat(1,a0.matrix_name,a1.matrix_name,a2.matrix_name,a3.matrix_name,a4.matrix_name,a5.matrix_name,a6.matrix_name,a7.matrix_name,a8.matrix_name,a9.matrix_name);
[~,~,stats] = anova1(aa3);
%%
grouping_variable = [ones(1, length(aa1)), 2*ones(1, length(aa2))];
[p,tbl,stats]=anova1([aa1, aa2],grouping_variable)
%%
%aa1_delta = aa1(:,1:7)
aa2_delta = aa2(:,1:7)
aa3_delta = aa3(:,1:7)
grouping_variable = [2*ones(1, 7), 3*ones(1, 7)];
[p,tbl,stats]=anova1([aa2_delta, aa3_delta],grouping_variable)
%%
%aa1_theta = aa1(:,8:15)
aa2_theta = aa2(:,8:15)
aa3_theta = aa2(:,8:15)

grouping_variable = [2*ones(1, 8),3*ones(1, 8)];
[p,tbl,stats]=anova1([ aa2_theta, aa3_theta],grouping_variable)
%%
%aa1_alpha_low = aa1(:,16:19)
aa2_alpha_low = aa2(:,16:19)
aa3_alpha_low = aa3(:,16:19)
grouping_variable = [ 2*ones(1, 4),3*ones(1, 4)];
[p,tbl,stats]=anova1([ aa2_alpha_low,aa3_alpha_low ],grouping_variable)
%%
%aa1_alpha_high = aa1(:,20:23)
aa2_alpha_high = aa2(:,20:23)
aa3_alpha_high = aa3(:,20:23)
grouping_variable = [ 2*ones(1, 4),3*ones(1, 4)];
[p,tbl,stats]=anova1([ aa2_alpha_high,aa3_alpha_high ],grouping_variable)
%%
%aa1_beta_low = aa1(:,24:29)
aa2_beta_low = aa2(:,24:29)
aa3_beta_low = aa3(:,24:29)

grouping_variable = [ 2*ones(1, 6),3*ones(1, 6)];
[p,tbl,stats]=anova1([aa2_beta_low, aa3_beta_low ],grouping_variable)
%%
%aa1_beta_mid = aa1(:,30:39)
aa2_beta_mid = aa2(:,30:39)
aa3_beta_mid = aa3(:,30:39)
grouping_variable = [ 2*ones(1, 10),3*ones(1, 10)];
[p,tbl,stats]=anova1([aa2_beta_mid , aa3_beta_mid ],grouping_variable)
%%
%aa1_beta_high = aa1(:,40:58)
aa2_beta_high = aa2(:,40:58)
aa3_beta_high = aa3(:,40:58)
grouping_variable = [2*ones(1, 19),3*ones(1, 19)];
[p,tbl,stats]=anova1([aa2_beta_high , aa3_beta_high ],grouping_variable)
%%
aa1_gamma = aa1(:,59:117)
aa2_gamma = aa2(:,59:117)
aa3_gamma = aa3(:,59:117)
grouping_variable = [2*ones(1, 59),3*ones(1, 59)];
[p,tbl,stats]=anova1([aa2_gamma , aa3_gamma ],grouping_variable)



