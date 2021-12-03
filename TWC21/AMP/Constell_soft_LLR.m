%% QPSK calculate the LLR
function [LLR_Constell]=Constell_soft_LLR(pf6,opt)
[m,n,p]=size(pf6);
% Normuliza=sqrt(3/2/(opt.M_order-1));
% sigma2=opt.sigma2; % noise variance of channel
LLR_Constell=zeros(2*opt.K,p);
TEmp=zeros(opt.K,opt.M,p);
for i=1:n/opt.M
%     for j=1:opt.M
        TEmp(i,1,:)=pf6(2,opt.M*(i-1)+1,:).*pf6(1,opt.M*(i-1)+2,:).*pf6(1,opt.M*(i-1)+3,:).*pf6(1,opt.M*(i-1)+4,:)+...
            pf6(2,opt.M*(i-1)+2,:).*pf6(1,opt.M*(i-1)+1,:).*pf6(1,opt.M*(i-1)+3,:).*pf6(1,opt.M*(i-1)+4,:)+...
            pf6(2,opt.M*(i-1)+3,:).*pf6(1,opt.M*(i-1)+2,:).*pf6(1,opt.M*(i-1)+1,:).*pf6(1,opt.M*(i-1)+4,:)+...
            pf6(2,opt.M*(i-1)+4,:).*pf6(1,opt.M*(i-1)+2,:).*pf6(1,opt.M*(i-1)+3,:).*pf6(1,opt.M*(i-1)+1,:);%pf6第2行符号
        TEmp(i,2,:)=pf6(3,opt.M*(i-1)+1,:).*pf6(1,opt.M*(i-1)+2,:).*pf6(1,opt.M*(i-1)+3,:).*pf6(1,opt.M*(i-1)+4,:)+...
            pf6(3,opt.M*(i-1)+2,:).*pf6(1,opt.M*(i-1)+1,:).*pf6(1,opt.M*(i-1)+3,:).*pf6(1,opt.M*(i-1)+4,:)+...
            pf6(3,opt.M*(i-1)+3,:).*pf6(1,opt.M*(i-1)+2,:).*pf6(1,opt.M*(i-1)+1,:).*pf6(1,opt.M*(i-1)+4,:)+...
            pf6(3,opt.M*(i-1)+4,:).*pf6(1,opt.M*(i-1)+2,:).*pf6(1,opt.M*(i-1)+3,:).*pf6(1,opt.M*(i-1)+1,:);%pf6第3行符号
        TEmp(i,3,:)=pf6(4,opt.M*(i-1)+1,:).*pf6(1,opt.M*(i-1)+2,:).*pf6(1,opt.M*(i-1)+3,:).*pf6(1,opt.M*(i-1)+4,:)+...
            pf6(4,opt.M*(i-1)+2,:).*pf6(1,opt.M*(i-1)+1,:).*pf6(1,opt.M*(i-1)+3,:).*pf6(1,opt.M*(i-1)+4,:)+...
            pf6(4,opt.M*(i-1)+3,:).*pf6(1,opt.M*(i-1)+2,:).*pf6(1,opt.M*(i-1)+1,:).*pf6(1,opt.M*(i-1)+4,:)+...
            pf6(4,opt.M*(i-1)+4,:).*pf6(1,opt.M*(i-1)+2,:).*pf6(1,opt.M*(i-1)+3,:).*pf6(1,opt.M*(i-1)+1,:);%pf6第4行符号
        TEmp(i,4,:)=pf6(5,opt.M*(i-1)+1,:).*pf6(1,opt.M*(i-1)+2,:).*pf6(1,opt.M*(i-1)+3,:).*pf6(1,opt.M*(i-1)+4,:)+...
            pf6(5,opt.M*(i-1)+2,:).*pf6(1,opt.M*(i-1)+1,:).*pf6(1,opt.M*(i-1)+3,:).*pf6(1,opt.M*(i-1)+4,:)+...
            pf6(5,opt.M*(i-1)+3,:).*pf6(1,opt.M*(i-1)+2,:).*pf6(1,opt.M*(i-1)+1,:).*pf6(1,opt.M*(i-1)+4,:)+...
            pf6(5,opt.M*(i-1)+4,:).*pf6(1,opt.M*(i-1)+2,:).*pf6(1,opt.M*(i-1)+3,:).*pf6(1,opt.M*(i-1)+1,:);%pf6第5行符号
       
%     end
end
for i=1:n/opt.M
    LLR_Constell(2*(i-1)+1,:)=log((TEmp(i,1,:)+TEmp(i,3,:))./(TEmp(i,2,:)+TEmp(i,4,:)));
    LLR_Constell(2*i,:)= log((TEmp(i,3,:)+TEmp(i,4,:))./(TEmp(i,1,:)+TEmp(i,2,:)));
end
end