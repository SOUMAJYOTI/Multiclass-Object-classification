Multiclass-Object-classification
================================
% Written by Soumajyoti Sarkar
% as a part of the Tagme Machine Learning Contest 2014
% held by Indian Institute of Science Bangalore.

1. Installation
===============
   Please add the vlfeat software and libsvm software
   (links given in the writeup)    
   into the MAtlab PATH variable or set the path of thes
   softwares from the File->Set Path GUI option in the 
   Matlab window.

2. Preparing the training dataset.
============
 	1. Obtain the concatenated HOG histograms of all the training
	   images by running HistogramListGlobal_HOG.m from the command
	   window as follows:
                    > histograms_HOG = HistogramListGlobal_HOG;
	   The output gets stored in HOG_model folder.
	2. Obtain the concatenated SIFT histograms of all the training
	   images by running encoder_classify.m from the command
	   window as follows:
                    > encoder_classify;
	   The output gets stored in SIFT_model folder.
	3. Obtain the concatenated pyramid histograms of all the training
	   images by running spatial_pyramid.m from the command
	   window as follows:
                    > spatial_pyramid;
	   The output gets stored in Pyramid folder.

3. Testing the models on test images
===========================
	1. Run the script demo_tag.m that computes the 
	   classes to which each image in the category belongs
	   as follows:
		    > demo_tag; 
	2. Create the file labels.txt by running the script
	   write_labels_file.m as follows;
		    > write_labels_file(dir, label);
	   Here dir is the path of the folder containing test images.
	   This step would create a file labels.txt that contain the 
	   results.

	The steps 1 and 2 in this section should be run in succession.
	

4. Few notes about the folders/files in general
=========================   

	hog - Contains the codes for extracting HOG features.
	kernel - Contains the kernel codes- rbf, chi-square kernel and histogram-intersection kernel.
	spatial_pyramid - Contains the codes for pyramid building.
	
	c_enhance.m - performs the preprocessing operations as described in writeup.
	computeH_HOG.m - computes the histograms of words of a particular class from images.
	computeHistogram.m - computes histogram of words of an image.
	computeVlist_HOG.m - computes the visual  vocabulary of a particulatr class from images.
	encodeimage.m - computes the Fisher encoding of an image from SIFT descriptors.
	getImageSet.m - Gets all images from a folder.
	quantizeDescriptors.m - Quantizes the descriptors to form visual words from visual vocabulary.

4. Contact 
=========================
   Soumajyoti Sarkar
   Email: ergy.ergy@gmail.com
   Phone: +91-9434591934.


