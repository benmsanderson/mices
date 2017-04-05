function err=error_wrapper(pvec,parampert,paramdef,emis,conc,temp,tt,use)

paramnew=pvec2struct(parampert,paramdef,pvec);
err=0;

for i=1:numel(emis)
out=climod_ode2(emis{i},paramnew,tt,use);
err=err+calc_error(conc{i},temp{i},out,use);
end
