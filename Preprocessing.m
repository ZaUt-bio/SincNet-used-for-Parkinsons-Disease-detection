% hc1 code for preprocessing 
% to save the new EEG data with a new name : EEG.setname='hc1_cleaned'
% to save it somewhere: 
%    EEG = pop_saveset( EEG, 'filename','wang.set','filepath','D:\\TEHRAN.uni\\THESIS\\Parkinson\\Dataset\\sub-hc1\\ses-hc\\eeg\\');
%    EEG = eeg_checkset( EEG );
clc
clear
%close all
data_num = 1;
hc_pd = 0; % 0==hc and 1==pd


% for HCs::::::::::::
if hc_pd == 0
    
    X = ['D:\TEHRAN.uni\THESIS\Parkinson\Dataset\sub-hc',num2str(data_num),'\ses-hc\eeg\sub-hc',num2str(data_num),'_ses-hc_task-rest_eeg.bdf'];
    disp(X)
    EEG = pop_biosig(X);
    EEG.setname=['hc_',num2str(data_num)];
    saved_name = ['hc_',num2str(data_num),'_ready']; % hc1_epoched.set   OR   pd1_off_epoched.set
    EEG = eeg_checkset( EEG );
elseif hc_pd == 1
    % for PDs::::::::::::
    X = ['D:\TEHRAN.uni\THESIS\Parkinson\Dataset\sub-pd',num2str(data_num),'\ses-off\eeg\sub-pd',num2str(data_num),'_ses-off_task-rest_eeg.bdf'];
    EEG = pop_biosig(X);
    EEG.setname=['pd_',num2str(data_num),'_off'];
    saved_name = ['pd_',num2str(data_num),'_off_ready']; % hc1_epoched.set   OR   pd1_off_epoched.set
    EEG = eeg_checkset( EEG );
end

% """""""""""""""""""""""""""""""""""""""""""  Main Section """""""""""""""
% 8 EXG unknown channels removal
EEG = pop_select( EEG, 'nochannel',{'EXG1','EXG2','EXG3','EXG4','EXG5','EXG6','EXG7','EXG8'});
EEG = eeg_checkset( EEG );
% channel locations
EEG=pop_chanedit(EEG, 'load',{'D:\\TEHRAN.uni\\THESIS\\Parkinson\\Dataset\\Standard-10-20-revised.ced','filetype','autodetect'});
EEG = eeg_checkset( EEG );
% re_reference
%EEG = pop_reref( EEG, []);
% ***************EEG = fullRankAveRef(EEG);
EEG = pop_reref( EEG, [7 24] );% انتخاب کانال های گوش برای مرجع دهی
EEG = eeg_checkset( EEG );
% visualize
%pop_eegplot( EEG, 1, 1, 1);
%% high_pass filter => 0.5 HZ
% import firfilt
EEG = pop_eegfiltnew(EEG, 'locutoff',0.5);
EEG = eeg_checkset( EEG );
% low_pass filter => 50 HZ
EEG = pop_eegfiltnew(EEG, 'hicutoff',50);
EEG = eeg_checkset( EEG );

EEG = fullRankAveRef(EEG);
EEG = eeg_checkset( EEG );
% visualize
pop_eegplot( EEG, 1, 1, 1);
%% CleanLine 
figure;
subplot(1,2,1)
pop_spectopo(EEG, 1, [0      105678.6125], 'EEG' , 'freqrange',[40 80],'electrodes','off');
EEG = pop_cleanline(EEG, 'bandwidth',2,'chanlist',[1:32] ...
    ,'computepower',1,'linefreqs',60,'newversion',0,'normSpectrum'...
    ,0,'p',0.01,'pad',2,'plotfigures',0,'scanforlines',0,'sigtype'...
    ,'Channels','taperbandwidth',2,'tau',100,'verb',1,'winsize',4,'winstep',1);
EEG = eeg_checkset( EEG );
EEG = fullRankAveRef(EEG);
EEG = eeg_checkset( EEG );
% spectral visualization
subplot(1,2,2)
pop_spectopo(EEG, 1, [0      105678.6125], 'EEG' , 'freqrange',[40 80],'electrodes','off');
%% identify and reject bad channels
% کافیه ترسیم کنی و همونجا حذف کنی
% ASR pipeline
% کانال های حذف شده رو پیدا کن:
%bad_channels_ARS = find(EEG.etc.clean_channel_mask==0)
%EEG = eeg_checkset( EEG );
originalEEG = EEG;
%%
EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion',5,'ChannelCriterion',0.8,...
    'LineNoiseCriterion',4,'Highpass','off','BurstCriterion',20,...
    'WindowCriterion',0.25,'BurstRejection','on','Distance','Euclidian',...
    'WindowCriterionTolerances',[-Inf 7] );
original_labels = {originalEEG.chanlocs.labels};  % Assuming originalEEG.chanlocs.labels is a cell array of strings
current_labels = {EEG.chanlocs.labels};  % Assuming EEG.chanlocs.labels is a cell array of strings

% Find unique labels in each set
unique_original = setdiff(original_labels, current_labels);
%unique_current = setdiff(current_labels, original_labels);

% Display the unique labels
disp("*********Unique labels in originalEEG.chanlocs.labels:");
disp(unique_original);
%disp("Unique labels in EEG.chanlocs.labels:");
%disp(unique_current);

%% Step 8: Interpolate all the removed channels
EEG = pop_interp(EEG, originalEEG.chanlocs, 'spherical');
EEG = fullRankAveRef(EEG); 

%% detrending of signal
%pop_eegplot( EEG, 1, 1, 1);

%data = EEG.data;  % Assuming your data is stored in the 'data' field of the EEG structure
%detrended_data = detrend(data,1);
%EEG.data = detrended_data;
%pop_eegplot( EEG, 1, 1, 1);

%% epoching
ELength=2;
Frames=EEG.pnts;% 54108
Sampling=EEG.srate;% 511

for Epoch=1:Frames/(ELength*Sampling)% number of epochs
    EEG.event(Epoch).latency=ELength*Sampling*Epoch;
    EEG.event(Epoch).type='';
end
EEG = pop_epoch( EEG, {  }, [0  ELength], 'epochinfo', 'yes');
EEG = eeg_checkset( EEG );

%EEG = pop_rmbase( EEG, [],[]);% baseline removal
% چون ایونت نداریم مطمئن نیستم باید بیس لاین کم بکنیم یا نه
%pop_eegplot( EEG, 1, 1, 1);
%EEG = fullRankAveRef(EEG);
%EEG = eeg_checkset( EEG );

%%
pop_eegplot( EEG, 1, 1, 1);
%EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on','pca',32);
EEG = eeg_checkset( EEG );
eeg_rank = rank(EEG.data(:,:));
fprintf('***The amount of eeg rank is:::: %d .\n',eeg_rank)
%%
% running ICA calculation
EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on','pca', eeg_rank);
% running ICLABEL
EEG = iclabel(EEG, 'default');
EEG = pop_iclabel(EEG, 'default');
% IC flagging
EEG = pop_icflag(EEG, [NaN NaN;0.9 1;0.9 1;0.9 1;0.9 1;0.9 1;NaN NaN]);
% elimination of targetted flagged ICs
EEG = pop_subcomp( EEG, [], 0);
EEG = eeg_checkset( EEG );
% visualize properties
pop_viewprops(EEG, 0) % for component properties
%pop_viewprops(EEG, 1) % for channel properties
%EEG.etc.ic_classification.ICLabel.classifications
% normalize the data channels (This will normalize each channel and each
% epoch independently.)
normdata = zscore(EEG.data,0,2);
EEG.data = normdata;
pop_eegplot( EEG, 1, 1, 1);
% $$$$$$=> EEG = pop_subcomp( EEG, [4], 1);حواست باشه اگر حذف داشتی دوباره
% نرمالیزه کنی
%%
%ant = EEG.etc.ic_classification.ICLabel;
clear ant
boogh = sum(EEG.etc.ic_classification.ICLabel.classifications,1)./eeg_rank;
if data_num == 1 && hc_pd == 0
    ant = EEG.etc.ic_classification.ICLabel;
    ant.classifications = boogh;
else
    ant = load('ICLabel_classes_classification.mat').ant;
    ant.classifications = cat(1,ant.classifications,boogh);
end
save('ICLabel_classes_classification.mat', 'ant');
EEG = pop_saveset( EEG, 'filename',saved_name,'filepath','D:\TEHRAN.uni\THESIS\Parkinson\Dataset\All_preprocessed');
EEG = eeg_checkset( EEG );
%% ----------------------------------------------------------------------------


%clc
%clear


data_num = 2;
X = ['D:\TEHRAN.uni\THESIS\Parkinson\Dataset\sub-hc',num2str(data_num),'\ses-hc\eeg\sub-hc',num2str(data_num),'_ses-hc_task-rest_eeg.bdf'];
disp(X)
EEG = pop_biosig(X);
EEG.setname=['hc_',num2str(data_num)];
saved_name = ['hc_',num2str(data_num),'_ready']; % hc1_epoched.set   OR   pd1_off_epoched.set
EEG = eeg_checkset( EEG );

% """""""""""""""""""""""""""""""""""""""""""  Main Section """""""""""""""
% 8 EXG unknown channels removal
EEG = pop_select( EEG, 'nochannel',{'EXG1','EXG2','EXG3','EXG4','EXG5','EXG6','EXG7','EXG8'});
EEG = eeg_checkset( EEG );
% channel locations
EEG=pop_chanedit(EEG, 'load',{'D:\\TEHRAN.uni\\THESIS\\Parkinson\\Dataset\\Standard-10-20-revised.ced','filetype','autodetect'});
EEG = eeg_checkset( EEG );
% re_reference
%EEG = pop_reref( EEG, []);
EEG = fullRankAveRef(EEG);
EEG = eeg_checkset( EEG );
% visualize
%pop_eegplot( EEG, 1, 1, 1);
%% high_pass filter => 0.5 HZ
% import firfilt
EEG = pop_eegfiltnew(EEG, 'locutoff',0.5);
EEG = eeg_checkset( EEG );
% low_pass filter => 50 HZ
EEG = pop_eegfiltnew(EEG, 'hicutoff',50);
EEG = eeg_checkset( EEG );

EEG = fullRankAveRef(EEG);
EEG = eeg_checkset( EEG );
% visualize
pop_eegplot( EEG, 1, 1, 1);
%% CleanLine 
figure;
subplot(1,2,1)
pop_spectopo(EEG, 1, [0      105678.6125], 'EEG' , 'freqrange',[40 80],'electrodes','off');
EEG = pop_cleanline(EEG, 'bandwidth',2,'chanlist',[1:32] ...
    ,'computepower',1,'linefreqs',60,'newversion',0,'normSpectrum'...
    ,0,'p',0.01,'pad',2,'plotfigures',0,'scanforlines',0,'sigtype'...
    ,'Channels','taperbandwidth',2,'tau',100,'verb',1,'winsize',4,'winstep',1);
EEG = eeg_checkset( EEG );
EEG = fullRankAveRef(EEG);
EEG = eeg_checkset( EEG );
% spectral visualization
subplot(1,2,2)
pop_spectopo(EEG, 1, [0      105678.6125], 'EEG' , 'freqrange',[40 80],'electrodes','off');
%% identify and reject bad channels
% کافیه ترسیم کنی و همونجا حذف کنی
% ASR pipeline
% کانال های حذف شده رو پیدا کن:
%bad_channels_ARS = find(EEG.etc.clean_channel_mask==0)
%EEG = eeg_checkset( EEG );
originalEEG = EEG;
%%
EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion',5,'ChannelCriterion',0.8,...
    'LineNoiseCriterion',4,'Highpass','off','BurstCriterion',20,...
    'WindowCriterion',0.25,'BurstRejection','on','Distance','Euclidian',...
    'WindowCriterionTolerances',[-Inf 7] );
original_labels = {originalEEG.chanlocs.labels};  % Assuming originalEEG.chanlocs.labels is a cell array of strings
current_labels = {EEG.chanlocs.labels};  % Assuming EEG.chanlocs.labels is a cell array of strings

% Find unique labels in each set
unique_original = setdiff(original_labels, current_labels);
%unique_current = setdiff(current_labels, original_labels);

% Display the unique labels
disp("*********Unique labels in originalEEG.chanlocs.labels:");
disp(unique_original);
%disp("Unique labels in EEG.chanlocs.labels:");
%disp(unique_current);

%% Step 8: Interpolate all the removed channels
EEG = pop_interp(EEG, originalEEG.chanlocs, 'spherical');
EEG = fullRankAveRef(EEG); 

%% detrending of signal
%pop_eegplot( EEG, 1, 1, 1);

%data = EEG.data;  % Assuming your data is stored in the 'data' field of the EEG structure
%detrended_data = detrend(data,1);
%EEG.data = detrended_data;
%pop_eegplot( EEG, 1, 1, 1);

%% epoching
ELength=2;
Frames=EEG.pnts;% 54108
Sampling=EEG.srate;% 511

for Epoch=1:Frames/(ELength*Sampling)% number of epochs
    EEG.event(Epoch).latency=ELength*Sampling*Epoch;
    EEG.event(Epoch).type='';
end
EEG = pop_epoch( EEG, {  }, [0  ELength], 'epochinfo', 'yes');
EEG = eeg_checkset( EEG );

%EEG = pop_rmbase( EEG, [],[]);% baseline removal
% چون ایونت نداریم مطمئن نیستم باید بیس لاین کم بکنیم یا نه
%pop_eegplot( EEG, 1, 1, 1);
%EEG = fullRankAveRef(EEG);
%EEG = eeg_checkset( EEG );

%%
pop_eegplot( EEG, 1, 1, 1);
%EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on','pca',32);
EEG = eeg_checkset( EEG );
eeg_rank = rank(EEG.data(:,:));
fprintf('***The amount of eeg rank is:::: %d .\n',eeg_rank)
%%
% running ICA calculation
EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on','pca', eeg_rank);
% running ICLABEL
EEG = iclabel(EEG, 'default');
EEG = pop_iclabel(EEG, 'default');
% IC flagging
EEG = pop_icflag(EEG, [NaN NaN;0.9 1;0.9 1;0.9 1;0.9 1;0.9 1;NaN NaN]);
% elimination of targetted flagged ICs
EEG = pop_subcomp( EEG, [], 0);
EEG = eeg_checkset( EEG );
% visualize properties
pop_viewprops(EEG, 0) % for component properties
%pop_viewprops(EEG, 1) % for channel properties
%EEG.etc.ic_classification.ICLabel.classifications
% normalize the data channels (This will normalize each channel and each
% epoch independently.)
normdata = zscore(EEG.data,0,2);
EEG.data = normdata;
pop_eegplot( EEG, 1, 1, 1);
% $$$$$$=> EEG = pop_subcomp( EEG, [4], 1);حواست باشه اگر حذف داشتی دوباره
% نرمالیزه کنی
%%
%ant = EEG.etc.ic_classification.ICLabel;
clear ant
boogh = sum(EEG.etc.ic_classification.ICLabel.classifications,1)./eeg_rank;
if data_num == 1 && hc_pd == 0
    ant = EEG.etc.ic_classification.ICLabel;
    ant.classifications = boogh;
else
    ant = load('ICLabel_classes_classification.mat').ant;
    ant.classifications = cat(1,ant.classifications,boogh);
end
save('ICLabel_classes_classification.mat', 'ant');
EEG = pop_saveset( EEG, 'filename',saved_name,'filepath','D:\TEHRAN.uni\THESIS\Parkinson\Dataset\All_preprocessed');
EEG = eeg_checkset( EEG );












