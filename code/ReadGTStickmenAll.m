function [lF] = ReadGTStickmenAll(txtfile,dsid,vid)
% lF = ReadStickmenAnnotationTxt(txtfile)
% Read annotations in file 'txtfile' and stores them in a struct-array.
%
% Input:
%  - txtfile containing annotations:
%
% Output:
%  - lF: struct-array with fields:
%      .stickmen.coor: matrix [4, nparts]. lF(k).coor(:,i) --> (x1, y1, x2, y2)'
%      .optionalfieldname = defaultvalue;
%      if annot file contains frame numbers then .frame field exist of type double (containing a frame number)
%      if annot file contains filenames then .filename field exist of type string (containing an image filename)
%
%
% See also DrawStickmen
%
% MJMJ/2008 changed by Eichner/2009 changed by Nataraj/2011
%

% Open file
fid = fopen(txtfile, 'rt');
if fid < 1,
    error([' Can not open file ', txtfile]);
end


% Read frames and annotations
nread = 0;
stop = false;
while ~stop,
    [element, count] = fscanf(fid, '%s', 1); % Read element
    if count < 1
        stop = true;
    else % read annotations
        [numGT, count] = fscanf(fid,'%d',1); % number of ground truth annotations.
        nread = nread+1;
        
        tmp = fscanf(fid,'%f',24*numGT);
        
        gtCnt = 0;
        for itrGT = 1:numGT
            gtsticks.coor = reshape(tmp( (itrGT-1)*24+1:itrGT*24),4,6);
            
            gtCnt = gtCnt + 1;
            lF(nread).stickmen(gtCnt) = gtsticks; % Read coordinates for part
        end
        
        if gtCnt == 0
            nread = nread -1;
            continue;
        end
        
        if isempty(regexp(element,'[a-zA-Z]','once'))
            % frame number
            lF(nread).frame = str2double(element);
        else
            % filename
            lF(nread).filename = element;
        end
        
        lF(nread).episode = vid;
        lF(nread).dsid = vid;
        
        
    end
end

% Close file
fclose(fid);
