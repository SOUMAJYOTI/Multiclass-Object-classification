function [] = openPool(s)
%
% Copyright Aditya Khosla http://mit.edu/khosla
%
% Please cite this paper if you use this code in your publication:
%   A. Khosla, J. Xiao, A. Torralba, A. Oliva
%   Memorability of Image Regions
%   Advances in Neural Information Processing Systems (NIPS) 2012
%

if(matlabpool('size')==0)
	if(s==0)
		matlabpool;
	elseif(s>1)
		matlabpool(s);
	end
end
