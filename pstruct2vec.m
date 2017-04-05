function [pvec,prng]=pstruct2vec(parampert,param)
n=0;
pmods=fieldnames(parampert);
for p=1:numel(pmods)
    pflds=fieldnames(parampert.(pmods{p}));
    for f=1:numel(pflds)
        n=n+1;
        pvec(n)=param.(pmods{p}).(pflds{f});
        prng(n,:)=parampert.(pmods{p}).(pflds{f});
    end
end

