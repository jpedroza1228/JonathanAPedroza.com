import numpy as np
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
import plotnine as pn
import joblib
from pyhere import here
from janitor import clean_names


from sklearn.model_selection import TimeSeriesSplit
from skore import compare, evaluate

jpcolor = 'seagreen'

pd.set_option('display.max_columns', None)
pd.options.mode.copy_on_write = True

df = pd.read_csv(here('posts/2026-03-21-skore/american_airlines_forecasting.csv')).clean_names(case_type = 'snake')

train = df.iloc[0:round(df.shape[0] * .8), :]
test = df.iloc[round(df.shape[0] * .8):, :]

print(df.shape)
print(train.shape)
print(test.shape)

from darts import TimeSeries
train_time = TimeSeries.from_dataframe(train, value_cols = 'close', freq = 'B')
train_series, val_series = train_time.split_after(round(train_time.shape[0] * .8))

print(train_series.shape)
print(val_series.shape)

from darts.models import NaiveMovingAverage, ExponentialSmoothing
from darts.metrics import mape

# model = NaiveMovingAverage()
model = ExponentialSmoothing()
model.fit(train_series)
forecast = model.predict(len(val_series))
mape(forecast, val_series)

plt.clf()
train_series.plot(label = 'actual')
val_series.plot(label = 'actual_val')
forecast.plot(label = 'forecast')
plt.legend()
plt.show()

# y_train = df['close']
# x_train = df['date']

# ts_cv = TimeSeriesSplit(n_splits = 5, gap = 30)
# train_splits = list(ts_cv.split(x_train, y_train))


# train['date'] = pd.to_datetime(train['date'])
# train = train.drop(columns = 'date')
# train_time = TimeSeries.from_dataframe(train.iloc[train_splits[0][0]], value_cols = 'close', freq = 'B')
# val_time = TimeSeries.from_dataframe(train.iloc[train_splits[0][1]], value_cols = 'close', freq = 'B')

# def eval_model(train_set,
#                test_set,
#                model = ['naive_drift',
#                         'naive_moving_avg',
#                         'exp_smoothing',
#                         'auto_arima']):
#   if model == 'naive_drift':
#     model = NaiveDrift()
#   elif model == 'naive_moving_avg':
#     model = NaiveMovingAverage()
#   elif model == 'exp_smoothing':
#     model = ExponentialSmoothing()
#   elif model == 'auto_arima':
#     model = AutoARIMA()
    
#   model.fit(train_set)
#   forecast = model.predict(len(test_set))
#   mape_value = mape(forecast, test_set)
  
#   return mape_value, model

# [eval_model(train_time, val_time, i)[0] for i in ['naive_drift', 'naive_moving_avg', 'exp_smoothing', 'auto_arima']]

# eval_model(train_time, val_time, 'naive_drift')[1]

# average_error = AutoARIMA().backtest(
#     series = TimeSeries.from_dataframe(train, value_cols = 'close', freq = 'B'),
#     start = .5,                # Start CV halfway through the data
#     forecast_horizon = 5,       # Predict 5 business days (1 week) at a time
#     stride = 5,                 # Move forward 5 days after each prediction
#     retrain = True,             # TRUE = Re-train on all past data at each step (CV)
#     metric = mape
# )
# average_error
