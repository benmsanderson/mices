function  [paramopt,out_opt]=opt_n2o(param,emis,conc,temp,tt)
parampert.N2O.cPD=[300,326];
parampert.N2O.dcdt=[0.5,1.0];
parampert.N2O.cPI=[100,300];
parampert.N2O.kStrat=[7.e-3 9e-3];
parampert.N2O.aPIstrat=[0.5,1];
parampert.N2O.sStrat=[0.,0.2];
parampert.N2O.b=[4.,6];
parampert.N2O.fill=[0.5,1.5];
parampert.N2O.a2100strat=[0.5,1.5];
parampert.N2O.a2100=[0.5,1.5];
parampert.N2O.aPI=[0.5,3.0];


[pvec,prng]=pstruct2vec(parampert,param);
n_lh=1000;
tmpl=lhsdesign(n_lh,numel(pvec));

for i=1:numel(pvec)
    lhc(:,i)=tmpl(:,i)*(prng(i,2)-prng(i,1))+prng(i,1);
end



 use='N2O';
  e0=error_wrapper(pvec,parampert,param,emis,conc,temp, ...
                               tt,use);
errfun = @(x) error_wrapper(x,parampert,param,emis,conc,temp, ...
                               tt,use)/e0;
% $$$ for i=1:n_lh
% $$$     e_lh(i)=errfun(lhc(i,:));
% $$$ end
% $$$ 
% $$$ 
% $$$ [a b]=min(e_lh);

options = optimoptions('fmincon','Display','iter');
options.Algorithm='active-set'

p_optfin=fmincon(errfun,pvec,[],[],[],[],prng(:,1),prng(:,2),[],options);

paramopt=pvec2struct(parampert,param,p_optfin);
out_opt=climod_ode2(emis{1},paramopt,tt,'all');
