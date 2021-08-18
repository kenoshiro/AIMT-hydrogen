# Fig.2
# as ggtern sometimes changes ggplot settings, it is recommended to execute this program separately with main one.

library(ggtern)

df$var <- tribble(~Variable,~Sector,~label_var,
                  'Fin_Ene_Ind_Share_Hyd','Industry','Hydrogen',
                  'Fin_Ene_Ind_Share_Ele_Heat','Industry','Electricity',
                  'Fin_Ene_Tra_Share_Hyd_Syn','Transport','Hydrogen',
                  'Fin_Ene_Tra_Share_Ele_Heat','Transport','Electricity',
                  'Fin_Ene_Res_and_Com_Share_Hyd','Buildings','Hydrogen',
                  'Fin_Ene_Res_and_Com_Share_Ele_Heat','Buildings','Electricity')
p$fec_tern <- filter(df$all,Variable%in%df$var$Variable,Year%in%seq(2020,2050,5),Region=='World',Scenario%in%lst$scen_pol) %>% 
    inner_join(df$var,by='Variable') %>% inner_join(df$scen_mat,by='Scenario') %>% 
    select(-Variable,-Unit) %>% spread(key=label_var,value=Value,fill=0) %>% 
    mutate(scen_cpol=factor(scen_cpol,levels=lst$cpol),scen_tech=factor(scen_tech,levels=lst$scen_tech),Sector=factor(Sector,levels=unique(df$var$Sector))) %>% 
    mutate(Other=1-Electricity-Hydrogen) %>% 
    ggtern(aes(x=Other,y=Hydrogen,z=Electricity))+
    ggplot2::theme_bw()+
    geom_point(aes(color=scen_cpol,shape=scen_tech))+
    facet_grid(.~Sector)+
    Llab('')+Tlab('')+Rlab('')+Larrowlab('Fossil & Biomass')+Tarrowlab('Hydrogen')+Rarrowlab('Electricity & Heat')+
    guides(color=guide_legend(title=NULL),shape=guide_legend(title=NULL))+
    theme_clockwise()+
    theme(legend.position='bottom',strip.background=element_blank(),strip.text=element_text(size=9),plot.margin=margin(0,0,0,0),
          tern.axis.arrow.show=T,tern.axis.arrow.text.T=element_text(vjust=-0.5),tern.axis.arrow.text.R=element_text(vjust=-0.5),
          tern.panel.grid.major=element_line(color='grey',size=0.1,linetype='dashed'),tern.panel.grid.minor=element_line(color='transparent'))+
    scale_shape_manual(values=lst$scen_tech_shape)+
    scale_color_viridis_d(option='plasma',end=.9)
print(p$fec_tern)

p$tmp <- grid.arrange(p$fec_point+theme(legend.position='none'),p$fec_tern,heights=c(1,.6))
ggsave(filename='output/fig2.png',plot=p$tmp,width=190,height=200,units='mm',dpi=300)
