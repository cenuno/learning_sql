from typing import List
from collections import Counter
from linear_regression.linear_algebra import dot, sum_of_squares
import math
import matplotlib
matplotlib.use("TkAgg")
from matplotlib import pyplot as plt

Vector = List[float]

# test data ----
num_friends = [
    100.0,
    49,
    41,
    40,
    25,
    21,
    21,
    19,
    19,
    18,
    18,
    16,
    15,
    15,
    15,
    15,
    14,
    14,
    13,
    13,
    13,
    13,
    12,
    12,
    11,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
]

daily_minutes = [1,68.77,51.25,52.08,38.36,44.54,57.13,51.4,41.42,31.22,34.76,54.01,38.79,47.59,49.1,27.66,41.03,36.73,48.65,28.12,46.62,35.57,32.98,35,26.07,23.77,39.73,40.57,31.65,31.21,36.32,20.45,21.93,26.02,27.34,23.49,46.94,30.5,33.8,24.23,21.4,27.94,32.24,40.57,25.07,19.42,22.39,18.42,46.96,23.72,26.41,26.97,36.76,40.32,35.02,29.47,30.2,31,38.11,38.18,36.31,21.03,30.86,36.07,28.66,29.08,37.28,15.28,24.17,22.31,30.17,25.53,19.85,35.37,44.6,17.23,13.47,26.33,35.02,32.09,24.81,19.33,28.77,24.26,31.98,25.73,24.86,16.28,34.51,15.23,39.72,40.8,26.06,35.76,34.76,16.13,44.04,18.03,19.65,32.62,35.59,39.43,14.18,35.24,40.13,41.82,35.45,36.07,43.67,24.61,20.9,21.9,18.79,27.61,27.21,26.61,29.77,20.59,27.53,13.82,33.2,25,33.1,36.65,18.63,14.87,22.2,36.81,25.53,24.62,26.25,18.21,28.08,19.42,29.79,32.8,35.99,28.32,27.79,35.88,29.06,36.28,14.1,36.63,37.49,26.9,18.58,38.48,24.48,18.95,33.55,14.24,29.04,32.51,25.63,22.22,19,32.73,15.16,13.9,27.2,32.01,29.27,33,13.74,20.42,27.32,18.23,35.35,28.48,9.08,24.62,20.12,35.26,19.92,31.02,16.49,12.16,30.7,31.22,34.65,13.13,27.51,33.2,31.57,14.1,33.42,17.44,10.12,24.42,9.82,23.39,30.93,15.03,21.67,31.09,33.29,22.61,26.89,23.48,8.38,27.81,32.35,23.84]

daily_hours = [dm / 60 for dm in daily_minutes]

# Central Tendancies ----


def mean(xs: Vector) -> float:
    """Mean value from a list of numbers"""
    return sum(xs) / len(xs)


# the underscores indicate that these are 'private' functions,
# as they're intended to be called by our median() but not by other
# people using our statistics library
def _median_odd(xs: Vector) -> float:
    """If len(xs) is odd, the median is the middle element
    (note the use of // as a way to perform floor divison)
    """
    return sorted(xs)[len(xs) // 2]


def _median_even(xs: Vector) -> float:
    """If len(xs) is even, it's the average of the middle two elements"""
    sorted_xs = sorted(xs)
    hi_midpoint = len(xs) // 2  # e.g. length 4 => hi_midpoint 2
    return (sorted_xs[hi_midpoint - 1] + sorted_xs[hi_midpoint]) / 2


def median(xs: Vector) -> float:
    """Finds the 'middle-most' value of xs"""
    return _median_even(xs=xs) if len(xs) % 2 == 0 else _median_odd(xs=xs)


assert median([1, 10, 2, 9, 5]) == 5
assert median([1, 9, 2, 10]) == (2 + 9) / 2


def quantile(xs: Vector, p: float) -> float:
    """Calculates the pth-percentile value in xs"""
    p_index = int(p * len(xs))
    return sorted(xs)[p_index]


assert quantile(xs=num_friends, p=0.10) == 1
assert quantile(xs=num_friends, p=0.25) == 3
assert quantile(xs=num_friends, p=0.75) == 9
assert quantile(xs=num_friends, p=0.90) == 13


def mode(xs: Vector) -> Vector:
    """Returns the most commonly seen observation"""
    counts = Counter(xs)
    max_count = max(counts.values())
    return [x_i for x_i, count in counts.items() if count == max_count]


assert set(mode(xs=num_friends)) == {1, 6}

# Dispersion ----


# "range" already means something in Python, so we'll use a different name
def data_range(xs: Vector) -> float:
    return max(xs) - min(xs)


assert data_range(xs=num_friends) == 99


def de_mean(xs: Vector) -> Vector:
    """Subtract the mean from x_i for each element in xs"""
    x_bar = mean(xs)
    return [x_i - x_bar for x_i in xs]  # note: the mean of de_mean() ~ 0


def variance(xs: Vector) -> float:
    """Almost the average squared deviation from the mean"""
    assert len(xs) >= 2, "variance requires at least 2 elements"

    n = len(xs)
    deviations = de_mean(xs)
    return sum_of_squares(deviations) / (n - 1)  # note: units are squared now


assert 81.54 < variance(xs=num_friends) < 81.55


def standard_deviation(xs: Vector) -> float:
    """The standard deviation is the square root of the variance"""
    return math.sqrt(variance(xs=xs))  # note: units no longer squared


assert 9.02 < standard_deviation(xs=num_friends) < 9.04


def interquartile_range(xs: Vector) -> float:
    """Returns the difference between the 75%-ile and the 25%-ile"""
    return quantile(xs=xs, p=0.75) - quantile(xs=xs, p=0.25)


assert interquartile_range(xs=num_friends) == 6


# Overview of covariance ----
# When corresponding elements of x and y are either both above their means
# or below their means, a positive number enters the sum. When one is above 
# its mean and the other is below, a negative number enters the sum.
#
# A 'large' positive covariance means that x tends to be large when y is large
# and small when y is small.
#
# A 'large' negative covariance means the opposite: x tends to be small when
# y is large and vice versa.
#
# A covariance close to zero means no such relationship exists.
#
# Cons of covariance ----
#    * units are the product of the inputs' units (e.g. friend-min-per-day)
#    * hard to say what counts as a 'large' covariance because
#      its susceptible to the size of xs or ys
def covariance(xs: Vector, ys: Vector) -> float:
    """Measures how two variables vary in tandem from their means"""
    assert len(xs) == len(ys), "xs and ys must have same number of elements"

    return dot(v=de_mean(xs=xs), w=de_mean(xs=ys)) / (len(xs) - 1)


assert 22.42 < covariance(xs=num_friends, ys=daily_minutes) < 22.43
assert 22.42 / 60 < covariance(xs=num_friends, ys=daily_hours) < 22.43 / 60


# more common to look at the correlation, which divides the 
# standard deviations of both variables
def correlation(xs: Vector, ys: Vector) -> float:
    """Preferred measures of how much xs + ys vary in tandem to their means"""
    stdev_x = standard_deviation(xs=xs)
    stdev_y = standard_deviation(xs=ys)
    if stdev_x > 0 and stdev_y > 0:
        return covariance(xs=xs, ys=ys) / stdev_x / stdev_y
    else:
        return 0  # if no variation, correlation is zero


# notice that the correlation is unitless and always lies between
# -1 (perfect anticorrelation) and 1 (perfect correlation)
# 0.25 represents relatively weak positive correlation
assert 0.24 < correlation(xs=num_friends, ys=daily_minutes) < 0.25
assert 0.24 < correlation(xs=num_friends, ys=daily_hours) < 0.25


# what happens if we ignore the outlier?
outlier = set([num_friends.index(100)])

num_friends_clean = [x_i for i, x_i in enumerate(num_friends) if i not in outlier]

daily_minutes_clean = [x_i for i, x_i in enumerate(daily_minutes) if i not in outlier]

daily_hours_clean = [dm / 60 for dm in daily_minutes_clean]

assert 0.57 < correlation(xs=num_friends_clean, ys=daily_minutes_clean) < 0.58
assert 0.57 < correlation(xs=num_friends_clean, ys=daily_hours_clean) < 0.58

# store outliers ----
corr_w_outlier = round(correlation(xs=num_friends, 
                                   ys=daily_minutes), 
                       ndigits=2)
corr_wo_outlier = round(correlation(xs=num_friends_clean, 
                                    ys=daily_minutes_clean), 
                        ndigits=2)
# visualize ----
fig, axs = plt.subplots(nrows=1, ncols=2)
axs[0].scatter(x=num_friends, 
               y=daily_minutes,
               label=corr_w_outlier)
axs[0].set_title(f"with outlier (n = {len(num_friends)})")
axs[0].legend()
axs[1].scatter(x=num_friends_clean,
               y=daily_minutes_clean,
               label=corr_wo_outlier)
axs[1].set_title(f"without outlier (n = {len(num_friends_clean)})")
axs[1].legend()
# remove the y-axis tick marks from the second subplot
axs[1].tick_params(labelleft=False) 
# assign an overall title
fig.suptitle("Correlation is affected by the presence of outliers", 
             fontsize=15, 
             fontweight=0,
             color="black", 
             y=1.02)
# label axes
fig.text(0.5, 0.01, "Number of friends", ha="center", va="center")
fig.text(0.01, 0.5, "Minutes per day", ha="center", va="center", rotation="vertical")
fig.tight_layout()
fig.savefig("visuals/corr_with_and_without_outlier.png",
            dpi=175,
            bbox_inches="tight")
