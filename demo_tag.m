% Tagme Demo Program
% Written by Soumajyoti Sarkar and Sibashis Chatterjee
% as a part of the Tagme Machine Learning Contest 2014
% held by Indian Institute of Science Bangalore.

clc;
clear all;

%############### KERNEL 1 ###############

%	This part computes the rbf kernel on bag-of-words model
%	computed from HOG features and obtains the probability estimates
%	on the test images

% Load the HOG histograms obtained from the training set
load ('HOG_model/histograms_global_HOG');
load ('HOG_model/vocab_global_HOG');

trainData = histograms_global_HOG;

trainLabel = [ones(30,1) ;2*ones(30,1); 3*ones(30,1); 4*ones(30,1); 5*ones(30,1) ]; 
numTrain = size(trainLabel,1);
%# compute kernel matrices between every pairs of (train,train) and
%# (test,train) instances and include sample serial number as first column
rbfK =  [ (1:numTrain)' , rbf_kernel(trainData,trainData) ];
SVM_rbf_HOG = libsvmtrain(trainLabel, rbfK, '-t 4 -b 1');

matfiles = dir(fullfile('tag_data/Validation/Images', '*.jpg'));
for i=1:size(matfiles,1)
	fullPath = fullfile( 'images', matfiles(i).name);
	h  = computeH_HOG(vocab_global_HOG, fullPath , 150);
	testData = h';
	testLabel = ones(1,1);
	numTest = size(testData, 1);
	rbfKK =  [ (1:numTest)' , rbf_kernel(testData,trainData) ];
	[predTestLabel, acc, prob] = libsvmpredict(testLabel, rbfKK, SVM_rbf_HOG, '-b 1');
	p_HOG_rbf(i).name = matfiles(i).name;
	p_HOG_rbf(i).label = predTestLabel;
	p_HOG_rbf(i).prob = prob;   % probability estimates
end

%############### KERNEL 2 ###############

%	This part computes the chi-square-kernel on bag-of-words model
%	computed from HOG features and obtains the probability estimates
%	on the test images


trainData = histograms_global_HOG;

trainLabel = [ones(30,1) ;2*ones(30,1); 3*ones(30,1); 4*ones(30,1); 5*ones(30,1) ]; 
numTrain = size(trainLabel,1);
chiK =  [ (1:numTrain)' , chi_square_kernel(trainData,trainData) ];
SVM_chi_HOG = libsvmtrain(trainLabel, chiK, '-t 4 -b 1');

matfiles = dir(fullfile('tag_data/Validation/Images', '*.jpg'));
for i=1:size(matfiles,1)
	fullPath = fullfile( 'images', matfiles(i).name);
	h  = computeH_HOG(vocab_global_HOG, fullPath , 150);
	testData = h';
	testLabel = ones(1,1);
	numTest = size(testData, 1);
	chiKK =  [ (1:numTest)' , chi_square_kernel(testData,trainData) ];
	[predTestLabel, acc, prob] = libsvmpredict(testLabel, chiKK, SVM_chi_HOG, '-b 1');
	p_HOG_chi(i).name = matfiles(i).name;
	p_HOG_chi(i).label = predTestLabel;
	p_HOG_chi(i).prob = prob;   % probability estimates
end


%############### KERNEL 3 ###############

%	This part computes the rbf kernel on bag-of-words model
%	computed from SIFT features with Fisher encoding and obtains 
%	the probability estimates on the test images

encoder = load(sprintf('encoder_fv.mat')) ;
load('SIFT_model/histogram_global_SIFT');

trainData = histogram_global_SIFT;
trainLabel = [ones(30,1) ;2*ones(30,1); 3*ones(30,1); 4*ones(30,1); 5*ones(30,1) ]; 
numTrain = size(trainLabel,1);

%# compute kernel matrices between every pairs of (train,train) and
%# (test,train) instances and include sample serial number as first column
rbfK =  [ (1:numTrain)' , rbf_kernel(trainData,trainData) ];
SVM_rbf_SIFT = libsvmtrain(trainLabel, rbfK, '-t 4 -b 1');

matfiles = dir(fullfile('tag_data/Validation/Images', '*.jpg'));
for i=1:size(matfiles,1)
	display(i);
	fullPath = fullfile( 'tag_data/Validation/Images', matfiles(i).name);
	h = encodeImage(encoder, fullPath, ['data_cache']) ;      % use fisher encoding to encode the features
	testData = h';
	testLabel = ones(1,1);
	numTest = size(testData, 1);
	rbfKK =  [ (1:numTest)' , rbf_kernel(testData,trainData) ];
	[predTestLabel, acc, prob] = libsvmpredict(testLabel, rbfKK, SVM_rbf_SIFT, '-b 1');
	p_SIFT_rbf(i).name = matfiles(i).name;
	p_SIFT_rbf(i).label = predTestLabel;
	p_SIFT_rbf(i).prob = prob;
end

%############### KERNEL 4 ###############

%	This part computes the chi-square kernel on bag-of-words model
%	computed from SIFT features with Fisher encoding and obtains 
%	the probability estimates on the test images


%# compute kernel matrices between every pairs of (train,train) and
%# (test,train) instances and include sample serial number as first column
chiK =  [ (1:numTrain)' , chi_square_kernel(trainData,trainData) ];
SVM_chi_SIFT = libsvmtrain(trainLabel, chiK, '-t 4 -b 1');

matfiles = dir(fullfile('tag_data/Validation/Images', '*.jpg'));
for i=1:size(matfiles,1)
	display(i);
	fullPath = fullfile( 'tag_data/Validation/Images', matfiles(i).name);
	h = encodeImage(encoder, fullPath, ['data_cache']) ;      % use fisher encoding to encode the features
	testData = h';
	testLabel = ones(1,1);
	numTest = size(testData, 1);
	chiKK =  [ (1:numTest)' , chi_square_kernel(testData,trainData) ];
	[predTestLabel, acc, prob] = libsvmpredict(testLabel, chiKK, SVM_chi_SIFT, '-b 1');
	p_SIFT_chi(i).name = matfiles(i).name;
	p_SIFT_chi(i).label = predTestLabel;
	p_SIFT_chi(i).prob = prob;
end

%############### KERNEL 5 ###############

%	This part computes the pyramid matching kernel on bag-of-words model
%	computed from dense SIFT features and oriented edge gradients and obtains 
%	the probability estimates on the test images

load ('Pyramid/pyramid_global');

pyramidK = hist_isect(pyramid_global, pyramid_global);
trainLabel = [ones(30,1) ;2*ones(30,1); 3*ones(30,1); 4*ones(30,1); 5*ones(30,1) ]; 
numTrain = size(trainLabel,1);
pyramidK =  [ (1:numTrain)' , pyramidK ];
SVM_model = libsvmtrain(trainLabel, pyramidK, '-t 4 -b 1');

image_dir = 'tag_data/Validation/Images';
fnames = dir(fullfile(image_dir, '*.jpg'));
num_files = size(fnames,1);
filenames = cell(num_files,1);
temp = cell(1,1);

for f = 1:num_files
	filenames{f} = fnames(f).name;
	data_dir = 'data';
	temp{1} = fnames(f).name;
	% return pyramid descriptors for all files in filenames
	pyramid_all = BuildPyramid(temp,image_dir,data_dir);
	K = hist_isect(pyramid_all,pyramid_global); 
	KK =  [ (1:size(K,1))' , K];
	testLabel = ones(1,size(K,1));
	[predTestLabel, acc, prob] = libsvmpredict(testLabel, KK, SVM_model, '-b 1');
	p_pyramid(f).name = temp{1};
	p_pyramid(f).label = predTestLabel;
	p_pyramid(f).prob = prob;
end


% The winner-takes-it-all strategy by computing mean across all probability estimates
% and finding the maximum among them.

matfiles = dir(fullfile('tag_data/Validation/Images', '*.jpg')); 
for i=1:numFiles
	for j=1:5
		label_final(j) = (p_HOG_rbf(i,j).prob+p_HOG_chi(i,j).prob+p_SIFT_rbf(i,j).prob+p_SIFT_chi(i,j).prob+p_pyramid(i,j).prob)/5.0;
	end
	[C index] = max(label_final);
	label(i).l=index;
	label(i).name = matfiles(i).name;
        
end

