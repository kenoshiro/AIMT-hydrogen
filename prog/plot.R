mytheme <- list()
mytheme$set1 <- theme_bw()+theme(plot.title=element_text(size=11),
                                 axis.title=element_text(size=10),
                                 panel.grid=element_blank(),
                                 panel.border=element_blank(),
                                 axis.line.x=element_line(color='black'),axis.line.y=element_line(color='black')
                                 )
lst$scen_tech <- c('Default','CCSoff','LimBio','H2off','H2lowcost','VRElowcost')
lst$scen_tech_shape <- c('Default'=1,
                         'CCSoff'=6,
                         'LimBio'=4,
                         'H2lowcost'=0,
                         'VRElowcost'=2,
                         'H2off'=3)
lst$cpol <- c('NoPol',seq(1400,500,-100))
lst$cpol_rep <- c('1000','700','500')

# Fig.1 -----------------------------------------------------------

df$var <- tribble(~Variable,~Legend,~Color,
                  'Emi_CO2_Ene_Sup','Energy Supply','moccasin',
                  'Emi_CO2_Ene_Dem_Ind_and_AFO','Industry','salmon',
                  'Emi_CO2_Ene_Dem_Res_and_Com','Buildings','lightsteelblue',
                  'Emi_CO2_Ene_Dem_Tra','Transportation','darkolivegreen2',
                  'Emi_CO2_Ind_Pro','Industrial processes','grey')
leg <- as.character(df$var$Legend); names(leg) <- as.character(df$var$Variable)
col <- as.character(df$var$Color); names(col) <- as.character(df$var$Variable)
p$emi2 <- filter(df$all,Variable%in%df$var$Variable,Year==2050,Region=='World',Scenario%in%lst$scen_pol) %>% 
    inner_join(df$var,by='Variable') %>% inner_join(df$scen_mat,by='Scenario') %>% 
    filter(scen_cpol%in%lst$cpol_rep) %>% 
    mutate(Variable=factor(Variable,levels=rev(df$var$Variable)),scen_tech=factor(scen_tech,levels=lst$scen_tech),scen_cpol=factor(scen_cpol,levels=lst$cpol)) %>% 
    mutate(Value=Value/1000) %>% 
    ggplot()+
    geom_hline(yintercept=0,color='grey50',size=.4,linetype='dashed')+
    geom_bar(aes(x=scen_tech,y=Value,fill=Variable),position='stack',stat='identity')+
    labs(x=NULL,y=NULL)+
    ylim(-10,65)+
    facet_grid(.~scen_cpol)+
    mytheme$set1+theme(legend.position=c(.7,.75),strip.background=element_blank(),axis.text.x=element_text(angle=45,hjust=1))+
    theme(axis.line.y=element_blank(),axis.text.y=element_blank(),axis.ticks.y=element_blank(),plot.background=element_rect(fill='transparent',color='transparent'),legend.key.size=unit(.75,'lines'))+
    scale_fill_manual(values=rev(col),labels=leg,name=NULL)
p$emi1 <- filter(df$all,Variable=='Emi_CO2_Ene_and_Ind_Pro',Year%in%seq(2005,2050,by=5),Region=='World') %>% 
    inner_join(df$scen_mat,by='Scenario') %>% 
    filter(scen_tech=='Default') %>% 
    mutate(scen_tech=factor(scen_tech,levels=lst$scen_tech),scen_cpol=factor(scen_cpol,levels=lst$cpol)) %>% 
    mutate(Value=Value/1000) %>% 
    ggplot()+
    geom_hline(yintercept=0,color='grey50',size=.4,linetype='dashed')+
    geom_path(aes(x=Year,y=Value,color=scen_cpol))+
    labs(x=NULL,y=expression(paste(CO[2],' emissions (Gt-',CO[2],'/yr)')))+
    ylim(-10,65)+
    guides(color=guide_legend(title=NULL,nrow=2))+
    mytheme$set1+theme(legend.position='bottom',strip.background=element_blank(),axis.text.x=element_text(angle=45,hjust=1))+
    scale_color_viridis_d(option='plasma',end=.9)
p$l_emi <- get_legend(p$emi1)
p$emi <- plot_grid(p$emi1+theme(legend.position='none'),p$emi2,nrow=1,axis='tb',align='h',rel_widths=c(1,1.8)) %>% 
    plot_grid(p$l_emi,ncol=1,rel_heights=c(1,.15))

df$var <- tribble(~Variable,~Legend,~Color,
                  'Fin_Ene_Liq_Oil','Oil','sandybrown',
                  'Fin_Ene_SolidsCoa','Coal','grey70',
                  'Fin_Ene_Gas','Gas','moccasin',
                  'Fin_Ene_Liq_and_Sol_Bio','Biomass','darkolivegreen2',
                  'Fin_Ene_Solar','Solar','lightsalmon',
                  'Fin_Ene_Ele','Electricity','lightsteelblue',
                  'Fin_Ene_Heat','Heat','salmon',
                  'Fin_Ene_Hyd','Hydrogen','thistle2',
                  'Fin_Ene_Liq_Hyd_syn','Synfuel','orchid',
                  'Fin_Ene_Oth','Other','grey90')
leg <- as.character(df$var$Legend); names(leg) <- as.character(df$var$Variable)
col <- as.character(df$var$Color); names(col) <- as.character(df$var$Variable)
obj$fec_max <- df$all %>% filter(Variable=='Fin_Ene',Region=='World') %>% .$Value %>% max() %>% ceiling()
p$fec1 <- filter(df$all,Variable%in%df$var$Variable,Year%in%seq(2005,2050,by=5),Region=='World') %>% 
    inner_join(df$var,by='Variable') %>% inner_join(df$scen_mat,by='Scenario') %>% 
    mutate(Variable=factor(Variable,levels=rev(df$var$Variable)),scen_tech=factor(scen_tech,levels=lst$scen_tech),scen_cpol=factor(scen_cpol,levels=lst$cpol)) %>% 
    filter(scen_cpol%in%lst$cpol_rep,scen_tech=='Default') %>% 
    ggplot()+
    geom_area(aes(x=Year,y=Value,fill=Variable),position='stack')+
    labs(x=NULL,y='Final energy (EJ/yr)')+
    ylim(0,obj$fec_max)+
    facet_grid(.~scen_cpol)+
    mytheme$set1+theme(legend.position='none',strip.background=element_blank(),axis.text.x=element_text(angle=45,hjust=1))+
    scale_fill_manual(values=rev(col),labels=leg,name=NULL)
p$fec2 <- filter(df$all,Variable%in%df$var$Variable,Year%in%2050,Region=='World') %>% 
    inner_join(df$var,by='Variable') %>% inner_join(df$scen_mat,by='Scenario') %>% 
    mutate(Variable=factor(Variable,levels=rev(df$var$Variable)),scen_tech=factor(scen_tech,levels=lst$scen_tech),scen_cpol=factor(scen_cpol,levels=lst$cpol)) %>% 
    filter(scen_cpol%in%lst$cpol_rep,scen_tech%in%lst$scen_tech) %>% 
    ggplot()+
    geom_bar(aes(x=scen_tech,y=Value,fill=Variable),position='stack',stat='identity')+
    ylim(0,obj$fec_max)+
    labs(x=NULL,y=NULL)+
    facet_grid(.~scen_cpol)+
    mytheme$set1+theme(legend.position='right',strip.background=element_blank(),axis.text.x=element_text(angle=45,hjust=1))+
    theme(axis.line.y=element_blank(),axis.text.y=element_blank(),axis.ticks.y=element_blank())+
    scale_fill_manual(values=rev(col),labels=leg,name=NULL)

df$var <- tribble(~Variable,~label_var,
                  'Emi_CO2_Ene_Dem_Red_base','var_x',
                  'Fin_Ene_Share_Hyd_Syn','var_y')
p$co2fin <- filter(df$all,Variable%in%df$var$Variable,Year%in%seq(2005,2050,by=5),Region=='World',Scenario%in%lst$scen_pol) %>% 
    inner_join(df$var,by='Variable') %>% inner_join(df$scen_mat,by='Scenario') %>% 
    select(-Variable,-Unit) %>% spread(key=label_var,value=Value) %>% 
    mutate(scen_tech=factor(scen_tech,levels=lst$scen_tech),scen_cpol=factor(scen_cpol,levels=lst$cpol)) %>% 
    ggplot()+
    geom_point(aes(x=var_x,y=var_y,color=scen_cpol,shape=scen_tech))+
    labs(x=expression(atop(paste(CO[2],' emissions reduction from NoPol'),'in the energy demand sectors')),y='Share of hydrogen')+
    scale_x_continuous(limits=c(0,1),labels=scales::percent)+
    scale_y_continuous(limits=c(0,NA),labels=scales::percent_format(accuracy=1))+
    guides(color='none',shape=guide_legend(title=NULL))+
    mytheme$set1+theme(legend.position='bottom',legend.key.size=unit(.5,'lines'),strip.background=element_blank())+
    scale_shape_manual(values=lst$scen_tech_shape)+
    scale_color_viridis_d(option='plasma',end=.9)

p$fec <- plot_grid(p$fec1,p$fec2,nrow=1,axis='tb',align='h',rel_widths=c(1,1.5))
p$tmp <- plot_grid(p$emi,p$co2fin,labels=c('b','c'),nrow=1,rel_widths=c(1,.8))
p$tmp <- plot_grid(p$fec,p$tmp,labels=c('a',''),ncol=1,rel_heights=c(1,1.1))
print(p$tmp)
ggsave(filename='output/fig1.png',plot=p$tmp,width=190,height=175,units='mm',dpi=300)



# Fig.2 -------------------------------------------------------------------

df$var <- tribble(~var_x,~var_y,~Sector,~Carrier,
                  'Emi_CO2_Ene_Dem_Ind_Red_base','Fin_Ene_Ind_Share_Low_Carbon','Industry','Non fossil',
                  'Emi_CO2_Ene_Dem_Tra_Red_base','Fin_Ene_Tra_Share_Low_Carbon','Transport','Non fossil',
                  'Emi_CO2_Ene_Dem_Res_and_Com_Red_base','Fin_Ene_Res_and_Com_Share_Low_Carbon','Buildings','Non fossil',
                  'Emi_CO2_Ene_Dem_Ind_Red_base','Fin_Ene_Ind_Share_Hyd','Industry','Hydrogen',
                  'Emi_CO2_Ene_Dem_Tra_Red_base','Fin_Ene_Tra_Share_Hyd_Syn','Transport','Hydrogen',
                  'Emi_CO2_Ene_Dem_Res_and_Com_Red_base','Fin_Ene_Res_and_Com_Share_Hyd','Buildings','Hydrogen',
                  'Emi_CO2_Ene_Dem_Ind_Red_base','Fin_Ene_Ind_Share_Ele','Industry','Electricity',
                  'Emi_CO2_Ene_Dem_Tra_Red_base','Fin_Ene_Tra_Share_Ele','Transport','Electricity',
                  'Emi_CO2_Ene_Dem_Res_and_Com_Red_base','Fin_Ene_Res_and_Com_Share_Ele','Buildings','Electricity') %>% 
    gather(-Sector,-Carrier,key='Axis',value='Variable')
p$fec_point <- filter(df$all,Variable%in%df$var$Variable,Year%in%seq(2020,2050,by=5),Region=='World') %>% 
    inner_join(df$var,by='Variable') %>% select(-Unit,-Variable) %>% spread(key=Axis,value=Value,fill=0) %>% 
    inner_join(df$scen_mat,by='Scenario') %>% filter(!(Scenario%in%lst$scen_base)) %>% 
    mutate(scen_cpol=factor(scen_cpol,levels=lst$cpol),scen_tech=factor(scen_tech,levels=lst$scen_tech),Sector=factor(Sector,levels=unique(df$var$Sector)),Carrier=factor(Carrier,levels=unique(df$var$Carrier))) %>% 
    ggplot()+
    geom_point(aes(x=var_x,y=var_y,color=scen_cpol,shape=scen_tech))+
    scale_x_continuous(limits=c(0,NA),labels=scales::percent)+
    scale_y_continuous(limits=c(0,NA),labels=scales::percent_format(accuracy=1))+
    facet_grid(Carrier~Sector)+
    labs(title=NULL,x=expression(paste('Sectoral ',CO[2],' emissions reduction from NoPol')),y='Share of energy carriers (%)')+
    mytheme$set1+theme(legend.position='bottom',strip.background=element_blank())+
    guides(color=guide_legend(title=NULL),shape=guide_legend(title=NULL))+
    scale_shape_manual(values=lst$scen_tech_shape)+
    scale_color_viridis_d(option='plasma',end=.9)
print(p$fec_point)


# Fig.3 -------------------------------------------------------------------

df$var <- tribble(~Variable,~Legend,~Color,~Sup_Dem,
                  'Sec_Ene_Hyd_Fos_wo_CCS','Fossil\nw/o CCS','sandybrown','Supply',
                  'Sec_Ene_Hyd_Fos_w_CCS','Fossil\nw/ CCS','tan3','Supply',
                  'Sec_Ene_Hyd_Bio_wo_CCS','Biomass\nw/o CCS','darkolivegreen3','Supply',
                  'Sec_Ene_Hyd_Bio_w_CCS','Biomass\nw/ CCS','darkolivegreen4','Supply',
                  'Sec_Ene_Hyd_Ele','Electricity','lightsteelblue','Supply',
                  'NA',' ','transparent','Placeholder',
                  'Fin_Ene_Ind_Hyd','Industry','salmon','Demand',
                  'Fin_Ene_Tra_Hyd_car','Transport','darkolivegreen2','Demand',
                  'Fin_Ene_Res_and_Com_Hyd','Buildings','lightskyblue3','Demand',
                  'Sec_Ene_Inp_Hyd_Ele','Power\ngeneration','moccasin','Demand',
                  'NA2',' ','transparent','Placeholder')
leg <- as.character(df$var$Legend); names(leg) <- as.character(df$var$Variable)
col <- as.character(df$var$Color); names(col) <- as.character(df$var$Variable)
p$hyd_2 <- filter(df$all,Variable%in%df$var$Variable,Year%in%2050,Region=='World',Scenario%in%lst$scen_pol) %>% 
    inner_join(df$var,by='Variable') %>% inner_join(df$scen_mat,by='Scenario') %>% 
    mutate(Variable=factor(Variable,levels=rev(df$var$Variable)),scen_tech=factor(scen_tech,levels=lst$scen_tech),scen_cpol=factor(scen_cpol,levels=lst$cpol)) %>% 
    mutate(Value=if_else(Sup_Dem=='Demand',-Value,Value)) %>% 
    filter(scen_cpol%in%lst$cpol_rep,scen_tech%in%lst$scen_tech,scen_tech!='H2off') %>% 
    ggplot()+
    geom_hline(yintercept=0,color='grey20',size=.2)+
    geom_bar(aes(x=scen_tech,y=Value,fill=Variable),position='stack',stat='identity')+
    labs(x=NULL,y='Hydrogen supply and consumption (EJ/yr)')+
    ylim(-100,100)+
    facet_grid(.~scen_cpol)+
    mytheme$set1+theme(legend.position='right',strip.background=element_blank(),axis.text.x=element_text(angle=90,hjust=1,vjust=.25),legend.key.height=unit(1.5,'lines'),legend.key.width=unit(.5,'lines'))+
    scale_fill_manual(values=col,labels=leg,name=NULL)

df$var <- tribble(~Variable,~label_var,
                  'Sec_Ene_Ele_Share_VRE','var_x',
                  'Cap_Ele_Sto','Battery storage',
                  'Cap_Hyd_Ele','Electrolysis')
col <- c('Electrolysis'='orchid','Battery storage'='steelblue2')
p$sto <- filter(df$all,Variable%in%df$var$Variable,Year%in%seq(2005,2050,by=5),Region=='World') %>% 
    inner_join(df$var,by='Variable') %>% inner_join(df$scen_mat,by='Scenario') %>% 
    filter(scen_tech%in%lst$scen_tech) %>% 
    select(-Variable,-Unit) %>% spread(key=label_var,value=Value) %>% 
    gather(`Battery storage`,Electrolysis,key=Variable,value=Value) %>% 
    mutate(scen_tech=factor(scen_tech,levels=lst$scen_tech),scen_cpol=factor(scen_cpol,levels=lst$cpol)) %>% 
    mutate(Value=Value/1000) %>% 
    ggplot()+
    geom_point(aes(x=var_x,y=Value,color=Variable,shape=scen_tech))+
    labs(x='Share of VRE in electricity',y='Capacity (TW)')+
    scale_x_continuous(limits=c(0,NA),labels=scales::percent_format(accuracy=1))+
    guides(color=guide_legend(title=NULL),shape=guide_legend(title=NULL))+
    mytheme$set1+theme(legend.position='bottom',strip.background=element_blank(),legend.box='vertical',legend.margin=margin(0,0,0,0),legend.key.size=unit(.5,'lines'))+
    scale_shape_manual(values=lst$scen_tech_shape)+
    scale_color_manual(values=col)

df$var <- tribble(~Variable,~label_var,
                  'Trd_Imp_Share_Sec_Ene_LowCarbon_Vol','Non fossil',
                  'Trd_Imp_Share_Sec_Ene_Bio_Vol','Bioenergy',
                  'Trd_Imp_Share_Sec_Ene_Amm_and_Syn_Vol','Hydrogen carriers')
p$trd <- filter(df$all,Variable%in%df$var$Variable,Year==2050,Region=='World',Scenario%in%lst$scen_pol) %>% 
    inner_join(df$var,by='Variable') %>% inner_join(df$scen_mat,by='Scenario') %>% 
    mutate(label_var=factor(label_var,levels=df$var$label_var),scen_cpol=factor(scen_cpol,levels=lst$cpol),scen_tech=factor(scen_tech,levels=lst$scen_tech)) %>% 
    ggplot()+
    geom_point(aes(x=scen_cpol,y=Value,color=scen_cpol,shape=scen_tech))+
    scale_y_continuous(limits=c(0,NA),labels=scales::percent_format(accuracy=1))+
    facet_grid(.~label_var)+
    labs(x=expression(paste('Carbon budget (Gt-',CO[2],')')),y='Share in global energy trade')+
    guides(color=guide_legend(title=NULL),shape=guide_legend(title=NULL))+
    mytheme$set1+theme(legend.position='none',strip.background=element_blank(),axis.text.x=element_text(angle=45,hjust=1))+
    scale_shape_manual(values=lst$scen_tech_shape)+
    scale_color_viridis_d(option='plasma',end=.9)

p$tmp <- plot_grid(p$hyd_2,p$sto,labels=c('a','b'),nrow=1,rel_widths=c(1,.7)) %>% 
    plot_grid(p$trd,labels=c('','c'),ncol=1,rel_heights=c(1,.8))
print(p$tmp)
ggsave(filename='output/fig3.png',plot=p$tmp,width=190,height=180,units='mm',dpi=300)


# Fig.4 -------------------------------------------------------------------

df$var <- tribble(~Variable,~label_var,
                  'Prc_Sec_Ene_Ele','Electricity',
                  'Prc_Sec_Ene_Hyd','Hydrogen')
p$prc_sec1 <- filter(df$all,Variable%in%df$var$Variable,Year==2050,Region=='World') %>% 
    inner_join(df$var,by='Variable') %>% inner_join(df$scen_mat,by='Scenario') %>% 
    mutate(scen_cpol=factor(scen_cpol,levels=lst$cpol),scen_tech=factor(scen_tech,levels=lst$scen_tech)) %>% 
    ggplot()+
    geom_point(aes(x=scen_cpol,y=Value,color=scen_cpol,shape=scen_tech))+
    labs(x=expression(paste('Carbon budget (Gt-',CO[2],')')),y='Energy production costs (US$/GJ)')+
    ylim(0,NA)+
    facet_grid(.~label_var)+
    guides(color=guide_legend(title=NULL,nrow=2),shape=guide_legend(title=NULL))+
    mytheme$set1+theme(legend.position='bottom',strip.background=element_blank(),axis.text.x=element_text(angle=45,hjust=1))+
    scale_shape_manual(values=lst$scen_tech_shape)+
    scale_color_viridis_d(option='plasma',end=.9)
p$prc_sec2 <- filter(df$all,Variable%in%df$var$Variable,Year%in%seq(2005,2050,by=5),Region=='World') %>% 
    inner_join(df$var,by='Variable') %>% inner_join(df$scen_mat,by='Scenario') %>% 
    select(-Variable) %>% spread(key=label_var,value=Value) %>% 
    filter(Hydrogen>0 & Hydrogen>0) %>% 
    mutate(scen_cpol=factor(scen_cpol,levels=lst$cpol),scen_tech=factor(scen_tech,levels=lst$scen_tech)) %>% 
    ggplot()+
    geom_abline(slope=c(1,2,3),linetype='dashed',color='grey50')+
    geom_text(x=32,y=30,label='s=1',size=3.5,color='grey50')+geom_text(x=32,y=60,label='s=2',size=3.5,color='grey50')+geom_text(x=32,y=90,label='s=3',size=3.5,color='grey50')+
    geom_point(aes(x=Electricity,y=Hydrogen,color=scen_cpol,shape=scen_tech))+
    labs(x='Electricity production cost (US$/GJ)',y='Hydrogen production cost (US$/GJ)')+
    ylim(0,NA)+xlim(0,33)+
    guides(color=guide_legend(title=NULL),shape=guide_legend(title=NULL))+
    mytheme$set1+theme(legend.position='none',strip.background=element_blank())+
    scale_shape_manual(values=lst$scen_tech_shape)+
    scale_color_viridis_d(option='plasma',end=.9)
print(p$prc_sec2)

p$prc_car <- filter(df$all,Variable=='Prc_Car',Year==2050,Region=='World',Scenario%in%lst$scen_pol) %>% 
    inner_join(df$scen_mat,by='Scenario') %>% 
    mutate(scen_cpol=factor(scen_cpol,levels=lst$cpol),scen_tech=factor(scen_tech,levels=lst$scen_tech)) %>% 
    ggplot()+
    geom_line(aes(x=scen_cpol,y=Value,group=scen_tech),color='grey',size=.3)+
    geom_point(aes(x=scen_cpol,y=Value,color=scen_cpol,shape=scen_tech))+
    labs(x=expression(paste('Carbon budget (Gt-',CO[2],')')),y=expression(paste('Carbon prices (US$/t-',CO[2],')')))+
    ylim(0,NA)+
    guides(color=guide_legend(title=NULL))+
    mytheme$set1+theme(legend.position='bottom',strip.background=element_blank(),axis.text.x=element_text(angle=45,hjust=1))+
    scale_shape_manual(values=lst$scen_tech_shape)+
    scale_color_viridis_d(option='plasma',end=.9)

obj$sec_axis_pol_cos <- filter(df$all,Variable%in%c('Pol_Cos_Cum_Dis_per_GDP','Pol_Cos_Cum_Dis'),Year==2050,Region=='World') %>% 
    mutate(Value=if_else(Variable=='Pol_Cos_Cum_Dis',Value/1000,Value)) %>% 
    select(-Unit) %>% spread(key=Variable,value=Value) %>% 
    mutate(Value=Pol_Cos_Cum_Dis_per_GDP/Pol_Cos_Cum_Dis) %>% filter(Scenario=='1000-Default') %>% .$Value
p$cuminv <- filter(df$all,Variable=='Pol_Cos_Cum_Dis',Year==2050,Region=='World',Scenario%in%lst$scen_pol) %>% 
    inner_join(df$scen_mat,by='Scenario') %>% 
    mutate(scen_cpol=factor(scen_cpol,levels=lst$cpol),scen_tech=factor(scen_tech,levels=lst$scen_tech)) %>% 
    mutate(Value=Value/1000) %>% 
    ggplot()+
    geom_line(aes(x=scen_cpol,y=Value,group=scen_tech),color='grey',size=.3)+
    geom_point(aes(x=scen_cpol,y=Value,color=scen_cpol,shape=scen_tech))+
    labs(x=expression(paste('Carbon budget (Gt-',CO[2],')')),y='Cumulative mitigation cost\n2021-2050 (trillion US$)')+
    scale_y_continuous(limits=c(0,NA),sec.axis=sec_axis(~.*obj$sec_axis_pol_cos,labels=scales::percent,name='Cumulative mitigation cost per GDP'))+
    guides(color=guide_legend(title=NULL))+
    mytheme$set1+theme(legend.position='bottom',strip.background=element_blank(),axis.text.x=element_text(angle=45,hjust=1))+
    theme(axis.line.y.right=element_blank())+
    scale_shape_manual(values=lst$scen_tech_shape)+
    scale_color_viridis_d(option='plasma',end=.9)

p$l_prc_sec <- get_legend(p$prc_sec1)
p$prc_sec <- plot_grid(p$prc_sec2,p$prc_sec1+theme(legend.position='none'),align='h',axis='tb',nrow=1,labels=c('a','b'),rel_widths=c(1,1.3))
p$pol_cos <- plot_grid(p$prc_car+theme(legend.position='none'),p$cuminv+theme(legend.position='none'),align='h',axis='tb',nrow=1,labels=c('c','d'),rel_widths=c(1,1.1))
p$tmp <- plot_grid(p$prc_sec,p$pol_cos,p$l_prc_sec,ncol=1,rel_heights=c(1,1,.15))
print(p$tmp)
ggsave(filename='output/fig4.png',plot=p$tmp,width=190,height=180,units='mm',dpi=300)
