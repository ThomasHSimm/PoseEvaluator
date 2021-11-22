function datasetinfo = getDSinfo(dsInx)
%function datasetinfo = getDSinfo(dsInx)
%Gives the information about the datasets whose indices are given in dsInx
%Input:
%    dsInx -- An array containing the Ids of the datasets. (default: 1)
%Output:
%    datasetinfo        -- structure which has the information about the datasets.
%       .name           -- name of the dataset.
%       .vids           -- a cell array of all the video names in the dataset.
%       .imglist        -- a cell array of file paths which contains the image names for the corresponding video.
%       .imgdir         -- a cell array containing the paths to image directories for the corresponding video.
%       .stickmenGTfile -- a cell array containing the paths to ground truth annotation file for the corresponding video.


startup

load([ basedir '/code/datasetdefs.mat']);

if nargin < 1
    error('No inputs given. Try "help getDSinfo" ');
end


datasetinfo = [];
for itr = 1:length(dsInx)
    datasetinfo(itr).name = opts.datasetnames{dsInx(itr)};
    datasetinfo(itr).vids = opts.vids{dsInx(itr)};
    
    for itr1 = 1:length(opts.vids{dsInx(itr)})
        datasetinfo(itr).imglist{itr1} = [basedir  '/' opts.imdir '/'  opts.vids{dsInx(itr)}{itr1} '/images.list' ];
        datasetinfo(itr).imgdir{itr1} = [basedir  '/' opts.imdir '/'   opts.vids{dsInx(itr)}{itr1}];
        datasetinfo(itr).stickmenGTfile{itr1} = sprintf(opts.anno,basedir,opts.stickmengtdir, [opts.vids{dsInx(itr)}{itr1} '/' opts.vids{dsInx(itr)}{itr1} ]);
    end
end

