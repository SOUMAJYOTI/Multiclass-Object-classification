function spatial_pyramid()

% Written by Soumajyoti Sarkar and Sibashis Chatterjee
% as a part of the Tagme Machine Learning Contest 2014
% held by Indian Institute of Science Bangalore.

data_dir = 'data';

% for other parameters, see BuildPyramid.m in spatial_pyramid folder

image_dir1 = 'tag_data/train/building';
image_dir2 = 'tag_data/train/car';
image_dir3 = 'tag_data/train/faces';
image_dir4 = 'tag_data/train/flowers';
image_dir5 = 'tag_data/train/shoes';

fnames = dir(fullfile(image_dir1, '*.jpg'));
num_files = size(fnames,1);
filenames = cell(num_files,1);

for f = 1:num_files
	filenames{f} = fnames(f).name;
end

% return pyramid descriptors for all files in filenames
pyramid_all1 = BuildPyramid(filenames,image_dir1,data_dir);

clear filenames;
fnames = dir(fullfile(image_dir2, '*.jpg'));
num_files = size(fnames,1);
filenames = cell(num_files,1);

for f = 1:num_files
	filenames{f} = fnames(f).name;
end

% return pyramid descriptors for all files in filenames
pyramid_all2 = BuildPyramid(filenames,image_dir2,data_dir);

clear filenames;
fnames = dir(fullfile(image_dir3, '*.jpg'));
num_files = size(fnames,1);
filenames = cell(num_files,1);

for f = 1:num_files
	filenames{f} = fnames(f).name;
end

% return pyramid descriptors for all files in filenames
pyramid_all3 = BuildPyramid(filenames,image_dir3,data_dir);

clear filenames;
fnames = dir(fullfile(image_dir4, '*.jpg'));
num_files = size(fnames,1);
filenames = cell(num_files,1);

for f = 1:num_files
	filenames{f} = fnames(f).name;
end

% return pyramid descriptors for all files in filenames
pyramid_all4 = BuildPyramid(filenames,image_dir4,data_dir);

clear filenames;
fnames = dir(fullfile(image_dir5, '*.jpg'));
num_files = size(fnames,1);
filenames = cell(num_files,1);

for f = 1:num_files
	filenames{f} = fnames(f).name;
end

% return pyramid descriptors for all files in filenames
pyramid_all5 = BuildPyramid(filenames,image_dir5,data_dir);

pyramid_global= [ pyramid_all1; pyramid_all2; pyramid_all3; pyramid_all4; pyramid_all5];

save('Pyramid/pyramid_building', 'pyramid_all1');
save('Pyramid/pyramid_car', 'pyramid_all2');
save('Pyramid/pyramid_faces', 'pyramid_all3');
save('Pyramid/pyramid_flowers', 'pyramid_all4');
save('Pyramid/pyramid_shoes', 'pyramid_all5');
save('Pyramid/pyramid_global', 'pyramid_global');

end
