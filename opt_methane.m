function [paramopt,out_opt]=opt_methane(param,emis,conc,temp,tt)


parampert.CH4.sOH=[-0.37,-0.27];
parampert.CH4.kCl=[0.000,0.0075];
parampert.CH4.kStrat=[0.000,0.02];
parampert.CH4.kSurf=[0,8e-2];
parampert.CH4.cPI=[650 750];
parampert.CH4.cPD=[1600 1815];
parampert.CH4.dcdt=[2 8];
parampert.CH4.anPI=[0.6,1.5];
parampert.CH4.aPI=[0.5,3];
parampert.CH4.a2100=[0.5,3];
parampert.CH4.kMCF =[ 0.176  0.3 ];
parampert.CH4.kMCFocean =[ -7.1e-3  7.1e-3 ];
parampert.CH4.r272 =[ 0. 0.66  ];

[pvec,prng]=pstruct2vec(parampert,param);
n_lh=100;
tmpl=lhsdesign(n_lh,numel(pvec));

for i=1:numel(pvec)
    lhc(:,i)=tmpl(:,i)*(prng(i,2)-prng(i,1))+prng(i,1);
end



 use='CH4';
 e0=error_wrapper(pvec,parampert,param,emis,conc,temp, ...
                               tt,use)
errfun = @(x) error_wrapper(x,parampert,param,emis,conc,temp, ...
                               tt,use)/e0;
% $$$ disp('Running Methane hypercube...')
% $$$ for i=1:n_lh
% $$$     e_lh(i)=errfun(lhc(i,:));
% $$$ end
% $$$ 
% $$$ 
% $$$ [a b]=min(e_lh);

options = optimoptions('fmincon','Display','iter');  
options.Algorithm='active-set';

p_optfin=fmincon(errfun,pvec,[],[],[],[],prng(:,1),prng(:,2),[],options);
%p_optfin=fmincon(errfun,pvec,[],[],[],[],[],[],[],options);


paramopt=pvec2struct(parampert,param,p_optfin);
out_opt=climod_ode2(emis{1},paramopt,tt,'all');

