
# Final energy
df$all %<>% 
    bind_rows(fcalc_sum(vars=c('Fin_Ene_SolidsBio','Fin_Ene_Liq_Bio'),name_new='Fin_Ene_Liq_and_Sol_Bio')) %>% 
    bind_rows(fcalc_sum(vars=c('Fin_Ene_Ind_Liq_Bio','Fin_Ene_Ind_SolidsBio'),name_new='Fin_Ene_Ind_Liq_and_Sol_Bio')) %>% 
    bind_rows(fcalc_sum(vars=c('Fin_Ene_Ind_Liq_and_Sol_Bio','Fin_Ene_Ind_Ele','Fin_Ene_Ind_Heat','Fin_Ene_Ind_Hyd'),name_new='Fin_Ene_Ind_Low_Carbon')) %>% 
    bind_rows(fcalc_sum(vars=c('Fin_Ene_Res_and_Com_SolidsBio','Fin_Ene_Res_and_Com_Ele','Fin_Ene_Res_and_Com_Heat','Fin_Ene_Res_and_Com_Hyd'),name_new='Fin_Ene_Res_and_Com_Low_Carbon')) %>% 
    bind_rows(fcalc_sum(vars=c('Fin_Ene_Tra_Liq_Bio','Fin_Ene_Tra_Ele','Fin_Ene_Tra_Hyd','Fin_Ene_Tra_Liq_Hyd_syn'),name_new='Fin_Ene_Tra_Low_Carbon')) %>% 
    bind_rows(fcalc_sum(vars=c('Fin_Ene_Tra_Hyd','Fin_Ene_Tra_Liq_Hyd_syn'),name_new='Fin_Ene_Tra_Hyd_car'))
df$all %<>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene','Fin_Ene_Ele'),name_new='Fin_Ene_Share_Ele')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene_Ind','Fin_Ene_Ind_Ele'),name_new='Fin_Ene_Ind_Share_Ele')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene_Tra','Fin_Ene_Tra_Ele'),name_new='Fin_Ene_Tra_Share_Ele')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene_Res_and_Com','Fin_Ene_Res_and_Com_Ele'),name_new='Fin_Ene_Res_and_Com_Share_Ele')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene','Fin_Ene_Hyd'),name_new='Fin_Ene_Share_Hyd')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene','Fin_Ene_Hyd','Fin_Ene_Liq_Hyd_syn'),name_new='Fin_Ene_Share_Hyd_Syn')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene_Ind','Fin_Ene_Ind_Hyd'),name_new='Fin_Ene_Ind_Share_Hyd')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene_Tra','Fin_Ene_Tra_Hyd'),name_new='Fin_Ene_Tra_Share_Hyd')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene_Tra','Fin_Ene_Tra_Hyd','Fin_Ene_Tra_Liq_Hyd_syn'),name_new='Fin_Ene_Tra_Share_Hyd_Syn')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene_Res_and_Com','Fin_Ene_Res_and_Com_Hyd'),name_new='Fin_Ene_Res_and_Com_Share_Hyd')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene','Fin_Ene_SolidsBio'),name_new='Fin_Ene_Share_Bio')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene','Fin_Ene_Heat'),name_new='Fin_Ene_Share_Heat')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene_Ind','Fin_Ene_Ind_Low_Carbon'),name_new='Fin_Ene_Ind_Share_Low_Carbon')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene_Res_and_Com','Fin_Ene_Res_and_Com_Low_Carbon'),name_new='Fin_Ene_Res_and_Com_Share_Low_Carbon')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene_Tra','Fin_Ene_Tra_Low_Carbon'),name_new='Fin_Ene_Tra_Share_Low_Carbon')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene','Fin_Ene_Ele','Fin_Ene_Heat'),name_new='Fin_Ene_Share_Ele_Heat')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene_Ind','Fin_Ene_Ind_Ele','Fin_Ene_Ind_Heat'),name_new='Fin_Ene_Ind_Share_Ele_Heat')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene_Tra','Fin_Ene_Tra_Ele'),name_new='Fin_Ene_Tra_Share_Ele_Heat')) %>% 
    bind_rows(fcalc_share(vars=c('Fin_Ene_Res_and_Com','Fin_Ene_Res_and_Com_Ele','Fin_Ene_Res_and_Com_Heat'),name_new='Fin_Ene_Res_and_Com_Share_Ele_Heat'))

# Secondary energy
df$all %<>% 
    bind_rows(fcalc_sum(vars=c('Sec_Ene_Ele_Solar','Sec_Ene_Ele_Win'),name_new='Sec_Ene_Ele_VRE')) %>% 
    bind_rows(fcalc_sum(vars=c('Sec_Ene_Ele_NonBioRen','Sec_Ene_Ele_Bio','Sec_Ene_Ele_Nuc','Sec_Ene_Ele_Fos_w_CCS','Sec_Ene_Ele_Hyd_GT'),name_new='Sec_Ene_Ele_Low_Carbon')) %>% 
    bind_rows(fcalc_sum(vars=c('Sec_Ene_Hyd_Ele','Sec_Ene_Hyd_Bio','Sec_Ene_Hyd_Fos_w_CCS'),name_new='Sec_Ene_Hyd_Low_Carbon'))
df$all %<>%
    bind_rows(fcalc_share(vars=c('Sec_Ene_Ele','Sec_Ene_Ele_VRE'),name_new='Sec_Ene_Ele_Share_VRE')) %>% 
    bind_rows(fcalc_share(vars=c('Sec_Ene_Ele','Sec_Ene_Ele_Low_Carbon'),name_new='Sec_Ene_Ele_Share_Low_Carbon')) %>% 
    bind_rows(fcalc_share(vars=c('Sec_Ene_Hyd','Sec_Ene_Hyd_Low_Carbon'),name_new='Sec_Ene_Hyd_Share_Low_Carbon'))

# Emissions
df$all %<>% bind_rows(fcalc_sum(vars=c('Emi_CO2_Ene_Dem_Ind','Emi_CO2_Ene_Dem_AFO'),name_new='Emi_CO2_Ene_Dem_Ind_and_AFO'))
df$all %<>% bind_rows(fcalc_sum(vars=c('Car_Seq_CCS_Bio_Ene_Sup','Car_Seq_Dir_Air_Cap'),name_new='Car_Seq_NETs'))

# Trade
df$all %<>% bind_rows(fcalc_sum(vars=c('Trd_Prm_Ene_Oil_Vol','Trd_Sec_Ene_Liq_Oil_Vol'),name_new='Trd_Oil_Vol'))
df$all %<>% bind_rows(fcalc_sum(vars=c('Trd_Sec_Ene_SolidsBio_Vol','Trd_Sec_Ene_Liq_Bio_Vol'),name_new='Trd_Sec_Ene_Bio_Vol'))

df$all %<>% 
    bind_rows(fcalc_sum(vars=c('Trd_Sec_Ene_Imp_SolidsBio_Vol','Trd_Sec_Ene_Imp_Liq_Bio_Vol','Trd_Sec_Ene_Imp_Amm_Vol','Trd_Sec_Ene_Imp_Syn_Vol'),name_new='Trd_Sec_Ene_Imp_LowCarbon_Vol')) %>% 
    bind_rows(fcalc_sum(vars=c('Trd_Sec_Ene_Imp_SolidsBio_Vol','Trd_Sec_Ene_Imp_Liq_Bio_Vol'),name_new='Trd_Sec_Ene_Imp_Bio_Vol')) %>% 
    bind_rows(fcalc_sum(vars=c('Trd_Sec_Ene_Imp_Amm_Vol','Trd_Sec_Ene_Imp_Syn_Vol'),name_new='Trd_Sec_Ene_Imp_Amm_and_Syn_Vol')) %>% 
    bind_rows(fcalc_sum(vars=c('Trd_Prm_Ene_Imp_Coa_Vol','Trd_Prm_Ene_Imp_Oil_Vol','Trd_Prm_Ene_Imp_Gas_Vol','Trd_Sec_Ene_Imp_Liq_Oil_Vol'),name_new='Trd_Imp_Fos_Vol')) %>% 
    bind_rows(fcalc_sum(vars=c('Trd_Prm_Ene_Imp_Oil_Vol','Trd_Sec_Ene_Imp_Liq_Oil_Vol'),name_new='Trd_Imp_Oil_Vol'))

df$all %<>% 
    bind_rows(fcalc_sum(vars=c('Trd_Prm_Ene_Imp_Coa_Vol','Trd_Prm_Ene_Imp_Oil_Vol','Trd_Prm_Ene_Imp_Gas_Vol','Trd_Sec_Ene_Imp_Liq_Oil_Vol','Trd_Sec_Ene_Imp_SolidsBio_Vol','Trd_Sec_Ene_Imp_Liq_Bio_Vol','Trd_Sec_Ene_Imp_Amm_Vol','Trd_Sec_Ene_Imp_Syn_Vol'),name_new='Trd_Imp_Vol')) %>% 
    bind_rows(fcalc_sum(vars=c('Trd_Prm_Ene_Coa_Vol','Trd_Prm_Ene_Oil_Vol','Trd_Prm_Ene_Gas_Vol','Trd_Sec_Ene_Liq_Oil_Vol','Trd_Sec_Ene_SolidsBio_Vol','Trd_Sec_Ene_Liq_Bio_Vol','Trd_Sec_Ene_Amm_Vol','Trd_Sec_Ene_Syn_Vol'),name_new='Trd_Vol'))
df$all %<>% bind_rows(fcalc_share(vars=c('Prm_Ene','Trd_Vol'),name_new='Imp_Dep'))
    
df$all %<>% 
    bind_rows(fcalc_share(vars=c('Trd_Imp_Vol','Trd_Sec_Ene_Imp_LowCarbon_Vol'),name_new='Trd_Imp_Share_Sec_Ene_LowCarbon_Vol')) %>% 
    bind_rows(fcalc_share(vars=c('Trd_Imp_Vol','Trd_Sec_Ene_Imp_Bio_Vol'),name_new='Trd_Imp_Share_Sec_Ene_Bio_Vol')) %>% 
    bind_rows(fcalc_share(vars=c('Trd_Imp_Vol','Trd_Sec_Ene_Imp_Amm_and_Syn_Vol'),name_new='Trd_Imp_Share_Sec_Ene_Amm_and_Syn_Vol'))

df$all %<>% 
    bind_rows(fcalc_relBaselinereductionrate(var='Emi_CO2_Ene_and_Ind_Pro',name_new='Emi_CO2_Ene_and_Ind_Pro_Red_base')) %>% 
    bind_rows(fcalc_relBaselinereductionrate(var='Emi_CO2_Ene_Dem',name_new='Emi_CO2_Ene_Dem_Red_base')) %>% 
    bind_rows(fcalc_relBaselinereductionrate(var='Emi_CO2_Ene_Dem_Ind',name_new='Emi_CO2_Ene_Dem_Ind_Red_base')) %>% 
    bind_rows(fcalc_relBaselinereductionrate(var='Emi_CO2_Ene_Dem_Res_and_Com',name_new='Emi_CO2_Ene_Dem_Res_and_Com_Red_base')) %>% 
    bind_rows(fcalc_relBaselinereductionrate(var='Emi_CO2_Ene_Dem_Tra',name_new='Emi_CO2_Ene_Dem_Tra_Red_base'))

# Policy costs
df$all %<>% 
    bind_rows(fcalc_cumulate(var='Pol_Cos_Add_Tot_Ene_Sys_Cos',name_new='Pol_Cos_Cum_Dis',intrate=0.05,p_year=2010,unit_new='billion US$',startyr=2021,endyr=2050)) %>% 
    bind_rows(fcalc_cumulate(var='GDP_MER',name_new='GDP_MER_Cum_Dis',intrate=0.05,p_year=2010,unit_new='billion US$',startyr=2021,endyr=2050))
df$all %<>% 
    bind_rows(fcalc_share(vars=c('GDP_MER_Cum_Dis','Pol_Cos_Cum_Dis'),name_new='Pol_Cos_Cum_Dis_per_GDP'))
