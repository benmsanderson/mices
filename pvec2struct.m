function paramnew=pvec2struct(parampert,paramdef,pvec)
n=0;
paramnew=paramdef;
pmods=fieldnames(parampert);
for p=1:numel(pmods)
    pflds=fieldnames(parampert.(pmods{p}));
    for f=1:numel(pflds)
        n=n+1;
        paramnew.(pmods{p}).(pflds{f})=pvec(n);
    end
end

