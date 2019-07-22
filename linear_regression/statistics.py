from typing import List
from collections import Counter

Vector = List[float]

num_friends = [100.0,49,41,40,25,21,21,19,19,18,18,16,15,15,15,15,14,14,13,13,13,13,12,12,11,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,8,8,8,8,8,8,8,8,8,8,8,8,8,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]


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
    return [x_i for x_i, _ in counts.items()]

def data_range(xs: Vector) -> float:
    return max(xs) - min(xs)


assert data_range(num_friends) == 99

def variance(xs: List[float]) -> float:
    """A"""