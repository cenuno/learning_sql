from typing import List
from collections import Counter
from linear_regression.linear_algebra import sum_of_squares
import math

Vector = List[float]

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
    return math.sqrt(x=variance(xs=xs))  # note: units no longer squared


assert 9.02 < standard_deviation(xs=num_friends) < 9.04


def interquartile_range(xs: Vector) -> float:
    """Returns the difference between the 75%-ile and the 25%-ile"""
    return quantile(xs=xs, p=0.75) - quantile(xs=xs, p=0.25)


assert interquartile_range(xs=num_friends) == 6
