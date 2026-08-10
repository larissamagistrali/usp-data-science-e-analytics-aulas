# Modelo só com a variável 'idade' como prditora

modelo_idade = sm.Logit.from_formula('fidelidade ~ idade',
                                     df_fidelidade_dummies).fit()

# Parâmetros do 'modelo_idade'
modelo_idade.summary()

step_modelo_fidelidade.llf
modelo_idade.llf

#%%
# Criar a ROC

df_fidelidade_dummies['phat2'] = modelo_idade.predict()

fpr2, tpr2, thresholds2 =roc_curve(df_fidelidade_dummies['fidelidade'],
                                df_fidelidade_dummies['phat2'])
roc_auc2 = auc(fpr2, tpr2)

# Cálculo do coeficiente de GINI
gini2 = (roc_auc2 - 0.5)/(0.5)

#%%
# Comparação das duas ROCs

plt.figure(figsize=(15,10))

plt.plot(fpr, tpr, marker='o', color='darkorchid', markersize=10, linewidth=3,
         label=f'AUROC: {roc_auc:.4f} | GINI: {gini:.4f}')

plt.plot(fpr2, tpr2, marker='o', color='orange', markersize=10, linewidth=3,
         linestyle='dashed',
         label=f'AUROC2: {roc_auc2:.4f} | GINI2: {gini2:.4f}')
         
plt.plot(fpr2, fpr2, color='gray', linestyle='dashed')

plt.title('Curva ROC', fontsize=22)

plt.xlabel('1 - Especificidade', fontsize=20)
plt.ylabel('Sensitividade', fontsize=20)
plt.xticks(np.arange(0, 1.1, 0.2), fontsize=14)
plt.yticks(np.arange(0, 1.1, 0.2), fontsize=14)

plt.legend(fontsize = 18)
plt.show()
