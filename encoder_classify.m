% Written by Soumajyoti Sarkar and Sibashis Chatterjee
% as a part of the Tagme Machine Learning Contest 2014
% held by Indian Institute of Science Bangalore.

% Obtain the concatenated histograms of all the pyramid levels
encoder = load(sprintf('encoder_fv.mat')) ;

pos1.names = getImageSet('tag_data/train/building') ;
pos1.histograms = encodeImage(encoder, pos1.names, ['data_cache']) ;
pos1.histograms = pos1.histograms';

pos2.names = getImageSet('tag_data/train/car') ;
pos2.histograms = encodeImage(encoder, pos2.names, ['data_cache']) ;
pos2.histograms = pos2.histograms';

pos3.names = getImageSet('tag_data/train/faces') ;
pos3.histograms = encodeImage(encoder, pos3.names, ['data_cache']) ;
pos3.histograms = pos3.histograms';

pos4.names = getImageSet('tag_data/train/flowers') ;
pos4.histograms = encodeImage(encoder, pos4.names, ['data_cache']) ;
pos4.histograms = pos4.histograms';

pos5.names = getImageSet('tag_data/train/shoes') ;
pos5.histograms = encodeImage(encoder, pos5.names, ['data_cache']) ;
pos5.histograms = pos5.histograms';

histogram_global_SIFT = [pos1.histograms; pos2.histograms; pos3.histograms; pos4.histograms; pos5.histograms];
save('SIFT_model/histogram_global_SIFT', 'histogram_global_SIFT');

