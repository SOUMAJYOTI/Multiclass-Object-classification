function [histograms_global_HOG] = HistogramListGlobal_HOG()

matfiles_buildings = dir(fullfile('tag_data', 'train', 'building', '*.jpg'));
vocab_buildings_HOG = computeVlist_HOG(matfiles_buildings, 'building', 30);
matfiles_car = dir(fullfile('tag_data', 'train', 'car', '*.jpg'));
vocab_car_HOG = computeVlist_HOG(matfiles_car, 'car', 30);
matfiles_faces = dir(fullfile('tag_data', 'train', 'faces', '*.jpg'));
vocab_faces_HOG = computeVlist_HOG(matfiles_faces, 'faces', 30);
matfiles_flowers = dir(fullfile('tag_data', 'train', 'flowers', '*.jpg'));
vocab_flowers_HOG = computeVlist_HOG(matfiles_flowers, 'flowers', 30);
matfiles_shoes = dir(fullfile('tag_data', 'train', 'shoes', '*.jpg'));
vocab_shoes_HOG = computeVlist_HOG(matfiles_shoes, 'shoes', 30);


save('HOG_model/vocab_car_HOG', 'vocab_car_HOG');
save('HOG_model/vocab_flowers_HOG', 'vocab_flowers_HOG');
save('HOG_model/vocab_buildings_HOG', 'vocab_buildings_HOG');
save('HOG_model/vocab_shoes_HOG', 'vocab_shoes_HOG');
save('HOG_model/vocab_faces_HOG', 'vocab_faces_HOG');

vocab_global_HOG.words = cat(2, vocab_buildings_HOG.words, vocab_car_HOG.words, vocab_faces_HOG.words,...
				 vocab_flowers_HOG.words, vocab_shoes_HOG.words);
vocab_global_HOG.kdtree = vl_kdtreebuild(vocab_global_HOG.words) ;

save('HOG_model/vocab_global_HOG', 'vocab_global_HOG');

for i=1:30
	nameFile = matfiles_car(i).name;
	fullPath = fullfile('tag_data/train', 'car', nameFile) ;
    	h = computeH_HOG(vocab_global_HOG, fullPath, 150);
        histogram_cars_HOG(i,:)= h';

	nameFile = matfiles_flowers(i).name;
	fullPath = fullfile('tag_data/train', 'flowers', nameFile) ;
    	h = computeH_HOG(vocab_global_HOG, fullPath, 150);
        histogram_flowers_HOG(i,:)= h';
	
	nameFile = matfiles_buildings(i).name;
	fullPath = fullfile('tag_data/train', 'building', nameFile) ;
    	h = computeH_HOG(vocab_global_HOG, fullPath, 150);
        histogram_buildings_HOG(i,:)= h';
	
	nameFile = matfiles_shoes(i).name;
	fullPath = fullfile('tag_data/train', 'shoes', nameFile) ;
    	h = computeH_HOG(vocab_global_HOG, fullPath, 150);
        histogram_shoes_HOG(i,:)= h';

	nameFile = matfiles_faces(i).name;
	fullPath = fullfile('tag_data/train', 'faces', nameFile) ;
    	h = computeH_HOG(vocab_global_HOG, fullPath, 150);
        histogram_faces_HOG(i,:)= h';
end

save('HOG_model/histogram_cars_HOG', 'histogram_cars_HOG');
save('HOG_model/histogram_flowers_HOG', 'histogram_flowers_HOG');
save('HOG_model/histogram_buildings_HOG', 'histogram_buildings_HOG');
save('HOG_model/histogram_shoes_HOG', 'histogram_shoes_HOG');
save('HOG_model/histogram_faces_HOG', 'histogram_faces_HOG');

histograms_global_HOG =[histogram_buildings_HOG ;histogram_cars_HOG; histogram_faces_HOG; histogram_flowers_HOG; histogram_shoes_HOG]; 

save('HOG_model/histograms_global_HOG', 'histograms_global_HOG');

