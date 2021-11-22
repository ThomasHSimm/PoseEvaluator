function [lf] =  getGTsticks(dsInx,vidInx,allannots)
% [lf] =  getGTsticks(vidInx,allannots,basedir)
% Gets the groundtruth stickmen of videos specified in vidInx. 
%Input:
%    dsInx -- An array containing the Ids of the datasets. (default: 1)
%    vidInx -- A cell array containing the Ids of the videos. (default: {1:2})
%    allannots -- A flag indicating where stickmen of occluded persons should be included. (default 0)
%Output:
%    lF             -- structure which has the stickmen of all the videos.
%       .stickmen   -- structure which has the stickmen present in a particular video.
%       .filename   -- name of the filename
%       .episode    -- the index of the video. 



if nargin < 3
   allannots = 0;
end

if nargin < 2
   vidInx = {1:2};
end

if nargin < 1
   dsInx = 1;
end
   
startup

load([ basedir '/code/datasetdefs.mat']);
lf = [];
for itr = 1:length(dsInx)

    currVidInx = vidInx{itr};
     
    for itr1 = 1:length(currVidInx)
     
        vidname = opts.stickmengtdir ;
        if length(opts.vids) > 1
            vidname = [vidname '/' opts.vids{dsInx(itr)}{currVidInx(itr1)}];
        end
     
        txtfile = sprintf(opts.anno,basedir,vidname,opts.vids{dsInx(itr)}{currVidInx(itr1)});
        if allannots == 0
           loclf = ReadGTStickmen(txtfile,dsInx(itr),currVidInx(itr1));
        elseif allannots == 1
           loclf = ReadGTStickmenAll(txtfile,dsInx(itr),currVidInx(itr1));
        end
        lf = [lf,loclf];
    end

end

