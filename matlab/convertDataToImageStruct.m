function [I,images]=convertDataToImageStruct(bytes,order,images)
% convert all images to struct data

I=struct('ulItemSize',1, ... 'ulong' ...
    'usVersion',1, ...'ushort' ...
    'usROIsCount',1, ...'ushort' ...
    'ulTotROISize',1, ...'ulong' ...
    'day',1, ...'uchar' ...
    'hour',1, ...'uchar ...
    'minute',1, ...'uchar' ...
    'second',1, ...'uchar'  ...
    'msecond',1, ...'ushort' ...
    'ImageType',1, ...'ushort'  ...
    'StartX',1, ...'ushort'  ...
    'StartY',1, ...'ushort' ...
    'EndX',1, ...'ushort'  ...
    'EndY',1, ...'ushort'  ...
    'BGRate',1, ...'ushort' ...
    'usBkgPDSThresh',1, ...'ushort' ...
    'ulFrmsProc',1, ...'ulong'  ...
    'IThreshold',1, ...'uchar' ...
    'ROIError',1, ...'uchar'  ...
    'ROIMinSize',1, ...'ushort'  ...
    'ROIAspectRatio',1, ...'float' ...
    'ROIFillRatio',1, ...'float' ...
    'ROIFCount',1, ...'ulong'  ...
    'ucImgMean',1, ...'uchar' ...
    'ucBkgMean',1, ...'uchar'  ...
    'Spare1',1, ...'short'  ...
    'ROIXPad',1, ...'ushort' ...
    'ROIYPad',1, ...'ushort'  ...
    'ulStrobeCount',1, ...'ulong'  ...
    'ulFrmsSaved',1, ...'ulong' ...
    'ImgMinVal',1, ...'uchar'  ...
    'ImgMaxVal',1, ...'uchar'  ...
    'ulROIsSaved',1, ...'ulong' ...
    'usPDSChkSumFlag',1, ...'ushort'  ...
    'usPDSHead',[1 1 1], ...'ushort'  ...
    'ulTime',1, ...'ulong' ...
    'ArrivalTime1',1, ...'ushort'  ...
    'ArrivalTime2',1, ...'ushort'  ...
    'TransitTime',1, ...'ushort' ...
    'usStrobes',1, ...'ushort'  ...
    'PulseInt45',1, ...'ushort'  ...
    'PulseInt90',1, ...'ushort' ...
    'PDSChkSum',1, ...'ushort' ...
    'ProbeMode',1,...); ...'ushort' ;
    'order',1);

I=repmat(I,[length(images) 1]); % replicate the matrix
for i=1:length(images)
    I(i).ulItemSize=double(typecast(uint16(bytes(images(i)+[1 2])),'uint32'));
    I(i).usVersion=bytes(images(i)+3);
    I(i).usROIsCount=bytes(images(i)+4);
    I(i).ulTotROISize=double(typecast(uint16(bytes(images(i)+[5 6])),'uint32'));
    
    dd=double(typecast(uint16(bytes(images(i)+[7])),'uint8'));
    I(i).day=dd(1);
    I(i).hour=dd(2);
    
    dd=double(typecast(uint16(bytes(images(i)+[8])),'uint8'));
    I(i).minute=dd(1);
    I(i).second=dd(2);
    
    I(i).msecond=bytes(images(i)+9);
    I(i).ImageType=bytes(images(i)+10);
    
%     I(i).ulTime=bytes(images(i)+10+85);
%     I(i).ArrivalTime1=bytes(images(i)+10+86);
%     I(i).ArrivalTime2=bytes(images(i)+10+87);
    
    I(i).StartX=bytes(images(i)+11);
    I(i).StartY=bytes(images(i)+12);
    I(i).EndX=bytes(images(i)+13);
    I(i).EndY=bytes(images(i)+14);
    I(i).BGRate=bytes(images(i)+15);
    I(i).usBkgPDSThresh=bytes(images(i)+16);
    
    I(i).ulFrmsProc=double(typecast(uint16(bytes(images(i)+[17 18])),'uint32'));

    dd=double(typecast(uint16(bytes(images(i)+[19])),'uint8'));
    I(i).IThreshold=dd(1);
    I(i).ROIError=dd(2);

    I(i).ROIMinSize=bytes(images(i)+20);
    
    I(i).ROIAspectRatio=double(typecast(uint16(bytes(images(i)+[21 22])),'single'));
    I(i).ROIFillRatio=double(typecast(uint16(bytes(images(i)+[23 24])),'single'));
    
    I(i).ROIFCount=double(typecast(uint16(bytes(images(i)+[25 26])),'uint32'));

    dd=double(typecast(uint16(bytes(images(i)+[27])),'uint8'));
    I(i).ucImgMean=dd(1);
    I(i).ucBkgMean=dd(2);
    
    I(i).Spare1=bytes(images(i)+28);
    I(i).ROIXPad=bytes(images(i)+29);
    I(i).ROIYPad=bytes(images(i)+30);
    
    I(i).ulStrobeCount=double(typecast(uint16(bytes(images(i)+[31 32])),'uint32'));
    I(i).ulFrmsSaved=double(typecast(uint16(bytes(images(i)+[33 34])),'uint32'));

    dd=double(typecast(uint16(bytes(images(i)+[35])),'uint8'));
    I(i).ImgMinVal=dd(1);
    I(i).ImgMaxVal=dd(2);

    I(i).ulROIsSaved=double(typecast(uint16(bytes(images(i)+[36 37])),'uint32'));
    
    I(i).usPDSChkSumFlag=bytes(images(i)+38);
    I(i).usPDSHead=bytes(images(i)+[39 40 41]);

    
    
    I(i).ulTime=double(typecast(uint16(bytes(images(i)+[42 43])),'uint32'));
    I(i).ArrivalTime1=bytes(images(i)+44);
    I(i).ArrivalTime2=bytes(images(i)+45);

    
    % note, goes a bit funny here, because idl code says time is ushort and
    % starts at 42 (84/2)
    I(i).ulTime=double(typecast(uint16(bytes(images(i)+[42])),'uint16'));
    I(i).ArrivalTime1=bytes(images(i)+43);
    I(i).ArrivalTime2=bytes(images(i)+44);

    
    I(i).TransitTime=bytes(images(i)+46);
    I(i).usStrobes=bytes(images(i)+47);
    I(i).PulseInt45=bytes(images(i)+48);
    I(i).PulseInt90=bytes(images(i)+49);
    I(i).PDSChkSum=bytes(images(i)+50);
    I(i).ProbeMode=bytes(images(i)+51);
    I(i).order=order(images(i));
    
end
ver=cat(1,I.usVersion);
ind=find(ver==40);
I=I(ind);
images=images(ind);