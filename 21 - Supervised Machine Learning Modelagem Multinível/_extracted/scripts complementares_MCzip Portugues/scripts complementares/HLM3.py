# Correlações intra-classe do modelo nulo HLM3 com medidas repetidas:

icc_escola = 180.222 / (180.222 + 325.798 + 41.6494)
icc_escola

icc_estudante = 325.798 / (180.222 + 325.798 + 41.6494)
icc_estudante

icc_temporal = 1 - icc_escola - icc_estudante
icc_temporal

#%%
# Cálculo do predict manualmente:

modelo_final_hlm3.params

51.401651 + 4.588455*1 -0.453789*0*1 + 0.784528*2 -13.7205 - 6.43934 + 0.18411*1
