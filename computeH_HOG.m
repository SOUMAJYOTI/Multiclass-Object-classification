function histogram = computeH_HOG(vocabulary,im, numClusters)
% COMPUTEHISTOGRAMFROMIMAGE Compute histogram of visual words for an image
%   HISTOGRAM = COMPUTEHISTOGRAMFROMIMAGE(VOCABULARY,IM) compute the
%   histogram of visual words for image IM given the visual word
%   vocaublary VOCABULARY. To do so the function calls in sequence
%   COMPUTEFEATURES(), QUANTIZEFEATURES(), and COMPUTEHISTOGRAM().
%
%   See also: COMPUTEVOCABULARYFROMIMAGELIST().

% Author: Andrea Vedaldi

im = c_enhance(im);

width = size(im,2) ;
height= size(im,1) ;
[d keypoints] = extract_hog2x2(im);
d=d';
d = single([d]) ;
words = quantizeDescriptors(vocabulary, d) ;
histogram = computeHistogram(width, height, keypoints, words, numClusters) ;
