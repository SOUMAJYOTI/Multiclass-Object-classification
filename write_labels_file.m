% Written by Soumajyoti Sarkar and Sibashis Chatterjee
% as a part of the Tagme Machine Learning Contest 2014
% held by Indian Institute of Science Bangalore.

% Input:
%	directory - Name of the directory for test images
%	labels - the label structure containing image name and label.

function write_labels_file(directory, labels)

matfiles = dir(fullfile(directory, '*.jpg'));
fileID = fopen('labels.txt', 'w');
for i = 1:num
	fprintf(fileID, '%s %d\n', labels.name, labels.l);
end
