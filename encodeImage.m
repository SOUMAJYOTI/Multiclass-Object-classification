function psi = encodeImage(encoder, im, cache)
% COMPUTEENCODING   Compute a spatial encoding of visual words
%   PSI = ENCODEIMAGE(ENCODER, IM) applies the specified ENCODER
%   to image IM, reurning a corresponding code vector PSI.
%
%   IM can be an image, the path to an image, or a cell array of
%   the same, to operate on multiple images.
%
%   ENCODEIMAGE(ENCODER, IM, CACHE) utilizes the specified CACHE
%   directory to store encodings for the given images. The cache
%   is used only if the images are specified as file names.

% Author: Andrea Vedaldi

if ~iscell(im), im = {im} ; end
if nargin <= 2, cache = [] ; end

psi = cell(1,numel(im)) ;
if numel(im) > 1
  parfor i = 1:numel(im)
    psi{i} = processOne(encoder, im{i}, cache) ;
  end
elseif numel(im) == 1
  psi{1} = processOne(encoder, im{1}, cache) ;
end
psi = cat(2, psi{:}) ;

% --------------------------------------------------------------------
function psi = processOne(encoder, im, cache)
% --------------------------------------------------------------------

psi = encodeOne(encoder, im) ;

% --------------------------------------------------------------------
function psi = encodeOne(encoder, im)
% --------------------------------------------------------------------

im = standardizeImage(im) ;

[d keypoints] = extract_sift(im);
d=d';
descriptors = vl_colsubset(d, 1000, 'uniform') ;
imageSize = size(im) ;

psi = {} ;
for i = 1:size(encoder.subdivisions,2)
  % Note: while one must remove the mean from the descriptor to
  % compute the PCA projection, the mean is irrelevant for the
  % encoding and therefore it is not subtracted here.

  switch encoder.type
    case 'fv'
      z = vl_fisher(encoder.projection * descriptors(:,:), ...
                    encoder.means, ...
                    encoder.covariances, ...
                    encoder.priors) ;
    
  end
  psi{i} = z(:) ;
end
psi = cat(1, psi{:}) ;

% --------------------------------------------------------------------
function psi = getFromCache(name, cache)
% --------------------------------------------------------------------
[drop, name] = fileparts(name) ;
cachePath = fullfile(cache, [name '.mat']) ;
if exist(cachePath, 'file')
  data = load(cachePath) ;
  psi = data.psi ;
else
  psi = [] ;
end

% --------------------------------------------------------------------
function storeToCache(name, cache, psi)
% --------------------------------------------------------------------
[drop, name] = fileparts(name) ;
cachePath = fullfile(cache, [name '.mat']) ;
vl_xmkdir(cache) ;
data.psi = psi ;
save(cachePath, '-STRUCT', 'data') ;
