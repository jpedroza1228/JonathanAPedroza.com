import os
import numpy as np
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
import plotnine as pn
import joblib
from pyhere import here
from janitor import clean_names
from great_tables import GT as gt

os.environ['QT_API'] = 'PyQt6'

pd.set_option('display.max_columns', None)
pd.options.mode.copy_on_write = True
matplotlib.rcParams.update({'savefig.bbox': 'tight'}) # Keeps plotnine legend from being cut off

df = pd.read_csv(here('posts/2026-03-11-interpretation/StudentPerformanceFactors.csv')).clean_names(case_type = 'snake')
df.head()

sub = df[['gender', 'exam_score', 'teacher_quality', 'previous_scores', 'sleep_hours', 'parental_involvement', 'attendance', 'hours_studied']]

# sub['gender'].value_counts()
# sub['parental_involvement'].value_counts()
# sub['teacher_quality'].value_counts()

sub['high_teach_qual'] = np.where(sub['teacher_quality'] == 'High', 1, 0)
sub['med_teach_qual'] = np.where(sub['teacher_quality'] == 'Medium', 1, 0)
sub['high_parent'] = np.where(sub['parental_involvement'] == 'High', 1, 0)
sub['med_parent'] = np.where(sub['parental_involvement'] == 'Medium', 1, 0)
sub['male'] = np.where(sub['gender'] == 'Male', 1, 0)

sub = sub.drop(columns = ['gender', 'teacher_quality', 'parental_involvement'])

sub.columns.tolist()

pn.ggplot.show(
  pn.ggplot(sub, pn.aes('previous_scores', 'exam_score'))
  + pn.geom_point(alpha = .25, color = 'seagreen')
  + pn.geom_smooth(method = 'lm', se = True)
  + pn.theme_light()
)

pn.ggplot.show(
  pn.ggplot(sub, pn.aes('sleep_hours', 'exam_score'))
  + pn.geom_point(alpha = .25, color = 'seagreen')
  + pn.geom_smooth(method = 'lm', se = True)
  + pn.theme_light()
)

pn.ggplot.show(
  pn.ggplot(sub, pn.aes('attendance', 'exam_score'))
  + pn.geom_point(alpha = .25, color = 'seagreen')
  + pn.geom_smooth(method = 'lm', se = True)
  + pn.theme_light()
)

import statsmodels.api as sm


def standard_coef(b, x, y):
  value = b * (x.std()/y.std())
  return round(value, 2)

def center_var(x):
  return x - x.mean()

def z_transform(x):
  num = x - x.mean()
  dem = x.std()
  return round(num/dem, 2)

sub[['zprevious_scores', 'zsleep_hours', 'zattendance', 'zhours_studied']] = z_transform(sub[['previous_scores', 'sleep_hours', 'attendance', 'hours_studied']])

sub[['cprevious_scores', 'csleep_hours', 'cattendance', 'chours_studied']] = center_var(sub[['previous_scores', 'sleep_hours', 'attendance', 'hours_studied']])


# ----------------- simple (bivariate) regression ----------------- 

y = sub['exam_score']
x = sub['previous_scores']
x = sm.add_constant(x)

simple_model = sm.OLS(y, x)
simple_fit = simple_model.fit()

simple_fit.summary()
standard_coef(b = simple_fit.params[1],
              x = sub['previous_scores'],
              y = sub['exam_score'])

xz = sub['zprevious_scores']
xz = sm.add_constant(xz)

simplez_model = sm.OLS(y, xz)
simplez_fit = simplez_model.fit()

simplez_fit.summary()
standard_coef(b = simplez_fit.params[1],
              x = sub['zprevious_scores'],
              y = sub['exam_score'])

xc = sub['cprevious_scores']
xc = sm.add_constant(xc)

simplec_model = sm.OLS(y, xc)
simplec_fit = simplec_model.fit()

simplec_fit.summary()
standard_coef(b = simplec_fit.params[1],
              x = sub['cprevious_scores'],
              y = sub['exam_score'])

sub.columns

# ----------------- multiple (multivariable) regression ----------------- 
x_main = sub.loc[:, 'previous_scores':'med_parent']
x_main = sm.add_constant(x_main)

main_model = sm.OLS(y, x_main)
main_fit = main_model.fit()

main_fit.summary()

main_beta = []
for i in np.arange(0, x_main.shape[1], 1):
  beta_values = standard_coef(b = main_fit.params[i],
                x = x_main.iloc[:, i],
                y = y)
  main_beta.append(beta_values)

main_param = main_fit.params.reset_index()
main_fit_param = pd.DataFrame({'b': main_param.iloc[:, 1],
                               'beta': pd.Series(main_beta)}).round(2)
main_fit_param['coef'] = main_param.iloc[:, 0]
main_fit_param = main_fit_param[['coef', 'b', 'beta']]
main_fit_param


z_main = sub[sub.filter(regex = r'^z').columns.tolist() + sub[['male', 'high_teach_qual', 'med_teach_qual', 'high_parent', 'med_parent']].columns.tolist()]
z_main = sm.add_constant(z_main)

mainz_model = sm.OLS(y, z_main)
mainz_fit = mainz_model.fit()

mainz_fit.summary()

mainz_beta = []
for i in np.arange(0, z_main.shape[1], 1):
  beta_values = standard_coef(b = mainz_fit.params[i],
                x = z_main.iloc[:, i],
                y = y)
  mainz_beta.append(beta_values)

mainz_param = mainz_fit.params.reset_index()
mainz_fit_param = pd.DataFrame({'b': mainz_param.iloc[:, 1],
                               'beta': pd.Series(mainz_beta)}).round(2)
mainz_fit_param['coef'] = mainz_param['index']
mainz_fit_param = mainz_fit_param[['coef', 'b', 'beta']]
mainz_fit_param

# ----------------- interactions ----------------- 
sub.columns.tolist()

sub['study_x_med_parent'] = sub['hours_studied'] * sub['med_parent']
sub['study_x_high_parent'] = sub['hours_studied'] * sub['high_parent']

sub[['hours_studied', 'med_parent', 'high_parent', 'study_x_med_parent', 'study_x_high_parent']].corr()
# such high correlations indicate multicollinearity
# so now we can use our centered variables

sub['cstudy_x_med_parent'] = sub['chours_studied'] * sub['med_parent']
sub['cstudy_x_high_parent'] = sub['chours_studied'] * sub['high_parent']


c_int = sub[sub.filter(regex = r'^c').columns.tolist() + sub[['male', 'high_teach_qual', 'med_teach_qual', 'high_parent', 'med_parent']].columns.tolist()]
c_int = sm.add_constant(c_int)

c_int_model = sm.OLS(y, c_int)
c_int_fit = c_int_model.fit()

c_int_fit.summary()

c_int_beta = []
for i in np.arange(0, c_int.shape[1], 1):
  beta_values = standard_coef(b = c_int_fit.params[i],
                x = c_int.iloc[:, i],
                y = y)
  c_int_beta.append(beta_values)

c_int_param = c_int_fit.params.reset_index()
c_int_fit_param = pd.DataFrame({'b': c_int_param.iloc[:, 1],
                               'beta': pd.Series(c_int_beta)}).round(2)
c_int_fit_param['coef'] = c_int_param['index']
c_int_fit_param = c_int_fit_param[['coef', 'b', 'beta']]
c_int_fit_param
