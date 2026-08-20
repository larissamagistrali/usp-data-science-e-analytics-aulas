# Predict: cálculo manual (sempre rezando...)

# Parâmetros do modelo final:
modelo_final_hlm2.params

# Fitted completo:
-0.849603 +  0.713461*11 + 1.585256*3.6 + 0.231829*11*3.6 - 0.2114 + 0.4388*11

#%%
# Definição de nova fórmula:
formula_dummies_modelo2 = ' + '.join(lista_colunas) + " + horas:texp"
formula_dummies_modelo2 = "desempenho ~ " + formula_dummies_modelo2
print("Fórmula utilizada: ",formula_dummies_modelo2)

# In[]: Estimação do modelo com n-1 dummies propriamente dito

modelo_ols_dummies2 = sm.OLS.from_formula(formula_dummies_modelo2,
                                         df_aluno_escola_dummies).fit()

# Parâmetros do 'modelo_ols_dummies2'
modelo_ols_dummies2.summary()

# In[]: Procedimento Stepwise para o 'modelo_ols_dummies2'

# Carregamento da função 'stepwise' do pacote 'statstests.process'
# Autores do pacote: Luiz Paulo Fávero e Helder Prado Santos
# https://stats-tests.github.io/statstests/

from statstests.process import stepwise

# Estimação do modelo por meio do procedimento Stepwise

modelo_ols_dummies_step2 = stepwise(modelo_ols_dummies2, pvalue_limit=0.05)

# In[]: Gráfico para comparação visual dos logLiks dos modelos HLM2 Final,
#OLS, OLS com Dummies e Stepwise e OLS com Dummies e Stepwise 2

df_llf = pd.DataFrame({'modelo':['OLS',
                                 'OLS com Dummies e Step.',
                                 'OLS com Dummies e Step.2',
                                 'HLM2 Modelo Final'],
                      'loglik':[modelo_ols.llf,
                                modelo_ols_dummies_step.llf,
                                modelo_ols_dummies_step2.llf,
                                modelo_final_hlm2.llf]})

fig, ax = plt.subplots(figsize=(15,15))

c = ['navy','darkorange','teal','deeppink']

ax1 = ax.barh(df_llf.modelo,df_llf.loglik, color = c)
ax.bar_label(ax1, label_type='center', color='white', fontsize=40)
ax.set_ylabel("Modelo Proposto", fontsize=24)
ax.set_xlabel("LogLik", fontsize=24)
ax.tick_params(axis='y', labelsize=20)
ax.tick_params(axis='x', labelsize=20)
plt.show()