function [vocabulary] = computeVlist_HOG(matfile, class_name, numClusters)

numWords = numClusters ;

descriptors = cell(1,30) ;
for i = 1:30
    nameFile = matfile(i).name;
    fullPath = fullfile('tag_data/train', class_name, nameFile) ;
    im = c_enhance(fullPath);
    [d keypoints] = extract_hog2x2(im);
    d=d';
    descriptors{i} = vl_colsubset(d, 1000, 'uniform') ;
end

fprintf('Computing visual words and kdtree\n') ;
descriptors = single([descriptors{:}]) ;
vocabulary.words = vl_kmeans(descriptors, numWords, 'verbose', 'algorithm', 'elkan') ;
