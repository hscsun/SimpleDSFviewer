function [noisy]=mapTm(smsorts,smFDs, te)
i=1:96;nn=1;
iii=1:96;
sizete=max(size(te));
for y=1:96
[ii,locvs,nums,condition,noisy]=peaknumbers(smsorts(:,y),smFDs(:,y));
if nums<1
    i(nn)=6;
    iii(nn)=6;
else
    i(nn)=te(locvs(find(ii==max(ii))));
    iii(nn)=i(nn);
end
nn=nn+1;
end
p=60;
b=zeros(p,p);
mai=max(i);

if max(i)==6
    mii=6
else
mii=min(i(find(i>6)));
%i=i/(te(sizete))*2^8;
end

i=((i-mii)/(mai-mii)+0.2)*2^8;


for k=1:8
for j=1:12
if i(j+(k-1)*12)<=6
    ee(k,j)=6;
    i(j+(k-1)*12)=6;
else
    ee(k,j)=iii(j+(k-1)*12);
end    
d((1+p*(k-1)):p*k,(1+p*(j-1)):p*j)=b+i(j+(k-1)*12);

end
end


for k=1:8
    d((k*p-1):k*p,:)=zeros(2,p*12)+1;%0*(1:p*12)+1;
end
for j=1:12
    d(:,(j*p-1):j*p)=zeros(p*8,2)+1;%0*(1:p*8)+1;
end

d(1:2,:)=zeros(2,p*12)+1;
d(:,1:2)=zeros(p*8,2)+1;
up=50;%ceil(te(2)/(2*mai)*2^8);
maptm=figure('Name',['Map preview of 96-well plate (Good sample color: ',num2str(up),'~',num2str(256),')'],'NumberTitle','off');

imshow(d,'DisplayRange',[0 2^8],'Border','tight');
colormap('jet');
colorbar('southoutside')%'Ticks',[1,te(2)/(te(sizete)-te(1)+1)*2^8,164,256],...
         %'TickLabels',{'Bad samples','Start point','Good samples','End point'})
scrsz = get(groot,'ScreenSize');
maptm=figure('Name','3D preview of 96-well plate','NumberTitle','off','Position',[scrsz(3)/10 scrsz(4)/10 2*scrsz(3)/5 7*scrsz(4)/10]);
axes('FontSize',13,'FontWeight','bold');
bar3(ee, 0.5);
zlabel('Temperature ( ^{\circ}C )','FontSize',13,'FontWeight','normal','Color','k');