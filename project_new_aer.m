function out=project_new_aer( emis, in , aparam )
    tt=in.CH4.tt;
    time=emis.CFC_11.time;
    SO2=emis.SOx.val;

    aer_t=interp1(emis.SOx.time,emis.SOx.val,tt);
    aer_1990=interp1(emis.SOx.time,emis.SOx.val,1990);
    out.aer_f=aer_t/aer_1990*aparam.f_1990;
end