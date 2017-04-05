function  [paramopt,out_opt]=opt_clim(param,emis,conc,temp,tt,lhdo)


parampert.clim.sens=[1.0,6.0];
parampert.clim.kappa=[1,30];
parampert.clim.kappa2=[1,300];
parampert.clim.kdeep=[0.001,1];

parampert.clim.ppm_1850=[270,290];

parampert.aer.f_1990=[-3,0];
parampert.clim.beta_l=[0,5];
parampert.clim.gamma_l=[-200,200];
parampert.clim.ocn_init=[100,20000];

parampert.clim.beta_o=[0,5];
parampert.clim.gamma_o=[-200,200];

parampert.clim.beta_od=[0.,4];
parampert.clim.docn_init=[20000,200000];



[pvec,prng]=pstruct2vec(parampert,param);



 use='all';
 e0=error_wrapper(pvec,parampert,param,emis,conc,temp, ...
                               tt,use);
errfun = @(x) error_wrapper(x,parampert,param,emis,conc,temp, ...
                               tt,use)/e0;
options = optimoptions('fmincon','Display','iter');
options.Algorithm='active-set';

if lhdo
    n_lh=100;
tmpl=lhsdesign(n_lh,numel(pvec));
    for i=1:numel(pvec)

    lhc(:,i)=tmpl(:,i)*(prng(i,2)-prng(i,1))+prng(i,1);
end
for i=1:n_lh
i    
    tmp=errfun(lhc(i,:));
    e_lh(i)=tmp;
end


[a b]=min(e_lh);


p_optfin=fmincon(errfun,lhc(b,:),[],[],[],[],prng(:,1),prng(:,2),[],options);
else
p_optfin=fmincon(errfun,pvec,[],[],[],[],prng(:,1),prng(:,2),[],options);
end
    


paramopt=pvec2struct(parampert,param,p_optfin);
out_opt=climod_ode2(emis{1},paramopt,tt,'all');
