clear
clc
%% Data
%UTC_Seconds_Of_Day, Latitude(deg), Longitude(deg), WGS84_Ellipsoid_Height(m), South-to-North_Slope, West-to-East_Slope, RMS_Fit(cm)

N=36;
date='20111119';
data= readtable(strcat(date,'\1.csv'));
for i=1:N-1
    d=readtable(strcat(date,'\',int2str(i+1),'.csv'));
    data = vertcat(data,d);
end


%% Clear Data
data=table2array(data(:,1:7));
save(strcat('data',date,'.dat'),'data','-ascii');
data(:,1)=uint32(data(:,1)/1000)*1000;
value=data(1,1);
datac=zeros(size(data));
datac(1,:)=data(1,:);
for i=2:length(data)
    if value ~= data(i,1)
        datac(i,:)=data(i,:);
    end
       value=data(i,1);
end
[a,b]=find(datac(:,1)~=0);
datac = datac(a',:);
save(strcat('dataclean',date,'.dat'),'datac','-ascii');

%% Save training
%X=datac(:,1:3);
%X(:,3)=X(:,3)-180;
%Y=datac(:,4:6);


%XN(:,1)=(X(:,1)-repmat(mean(X(:,1)),length(X(:,1)),1))./repmat((max(X(:,1))-min(X(:,1))),length(X(:,1)),1);
%XN(:,2)=(X(:,2)-repmat(mean(X(:,2)),length(X(:,2)),1))./repmat((max(X(:,2))-min(X(:,2))),length(X(:,2)),1);
%XN(:,3)=(X(:,3)-repmat(mean(X(:,3)),length(X(:,3)),1))./repmat((max(X(:,3))-min(X(:,3))),length(X(:,3)),1);
%YN(:,1)=(Y(:,1)-repmat(mean(Y(:,1)),length(Y(:,1)),1))./repmat((max(Y(:,1))-min(Y(:,1))),length(Y(:,1)),1);
%YN(:,2)=(Y(:,2)-repmat(mean(Y(:,2)),length(Y(:,2)),1))./repmat((max(Y(:,2))-min(Y(:,2))),length(Y(:,2)),1);
%YN(:,3)=(Y(:,3)-repmat(mean(Y(:,3)),length(Y(:,3)),1))./repmat((max(Y(:,3))-min(Y(:,3))),length(Y(:,3)),1);
%save('trainingInput.dat','X','-ascii');
%save('trainingOutput.dat','Y','-ascii');

%csvwrite('data20090331.dat',data)