function [smsorts,smFDs]=normalisemc(sorts,number)
%smooth data
for smi=1:97
    smsorts(:,smi)=(sorts(:,smi)-min(sorts(:,smi)))/(max(sorts(:,smi))-min(sorts(:,smi)));
end

  for i=1:1:number
     if i==1
         for j=1:96
     smFD(i,j) = (smsorts((i+1),j)-smsorts(i,j))*2;
         end
     elseif i==number
         for j=1:96
     smFD(i,j) = (smsorts(i,j)-smsorts((i-1),j))*2;
         end    
     else
         for j=1:96
     smFD(i,j) = smsorts((i+1),j)-smsorts((i-1),j);
         end
     end
     smsorts(i,97)=0;
     smFD(i,97)=0;
  end
 smFDs=smFD(1:number,:);
% smFDs=smoFD(smFDs);