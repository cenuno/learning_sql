from linear_regression.linear_algebra import Vector, sum_of_squares, distance
from linear_regression.linear_algebra import add, scalar_multiply, vector_mean
import random
from typing import Callable, TypeVar, List, Iterator
import matplotlib
matplotlib.use("TkAgg")
from matplotlib import pyplot as plt


def difference_quotient(f: Callable[[float], float],
                        x: float,
                        h: float) -> float:
    """Slope of the not-quiet-tangent line that runs through (x + h, f(x + h))
    As h gets smaller and smaller, the not-quite-tangent line gets
    closer and closer to the tangent line (x, f(x)),
    which is the derivative of the slope of the tangent line.
    """
    return (f(x + h) - f(x)) / h


# for many functions, its easy to exactly calculate derivative
# ex: the square function
def square(x: float) -> float:
    """Returns x multiplied by itself"""
    return x * x


# has the derivative of:
def derivative(x: float) -> float: 
    """Return the rate of change"""
    return 2 * x

# what if you couldn't find the gradient?
# we can estimate derivatives by evaluating the difference quotient
# for a very small e.
xs = range(-10, 11)
actuals = [derivative(x=x) for x in xs]
estimates = [difference_quotient(f=square, x=x, h=0.001) for x in xs]

# plot to show they're basically the same
plt.title("Actual derivatives v. estimates")
plt.plot(xs, actuals, "rx", label="actual")  # red x
plt.plot(xs, estimates, "b+", label="estimate")  # blue +
plt.xlabel("x")
plt.ylabel("y")
plt.legend(loc=9)
plt.tight_layout()
plt.savefig("visuals/derivatives_vs_estimates.png",
            dpi=175,
            bbox_inches="tight")

# when f is a function of many variables, it has multiple partial derivatives, 
# each indicating how f changes when we make small changes in just one of the 
# input variables.

# we calculate ith partial derivative by treating it as a 
# function of just its ith variable, holding the other variables fixed
def partial_difference_quotient(f: Callable[[Vector], float],
                                v: Vector,
                                i: int,
                                h: float) -> float:
    """Returns the i-th partial difference quotient of f at v"""
    w = [v_j + (h if j == i else 0)
         for j, v_j in enumerate(v)]

    return (f(w) - f(v)) / h


# we can estimate the gradient the same way
def estimate_gradient(f: Callable[[Vector], float],
                      v: Vector,
                      h: float = 0.0001) -> Vector:
    """Estimate the gradient using difference quotients"""
    return [partial_difference_quotient(f, v, i, h)
            for i in range(len(v))]

def gradient_step(v: Vector, gradient: Vector, step_size: float) -> Vector:
    """Moves `step_size` in the `gradient` direction from `v`"""
    assert len(v) == len(gradient)
    step = scalar_multiply(c=step_size, v=gradient)
    return add(v=v, w=step)


def sum_of_squares_gradient(v: Vector) -> Vector:
    return [2 * v_i for v_i in v]

# pick a random starting point
v = [random.uniform(-10, 10) for i in range(3)]

for epoch in range(1000):
    grad = sum_of_squares_gradient(v=v)  # computes the gradient at v
    v = gradient_step(v=v, gradient=grad, step_size=-0.01)  # take a negative gradient step
    print(epoch, v)

assert distance(v=v, w=[0, 0, 0]) < 0.001  # v should be close to 0

# you'll find that v always ends being very close to [0, 0, 0]
# the more epochs you run it for, the closer it will get

# choosing the right step size:
# * using a fixed step size
# * gradually shrinking the step size over time
# * choose the step size that minimizes 
#   the value of the objective function at each step
#
# 'too small' your gradient descent will take forever; 
# 'too large' and the descent may be undefined

# use gradient descent to fit parameterized models to data ----
# the goal is to minimize the loss function that measures 
# how well the model fits our data (smaller is better)

# if we think of our data as being fixed, then our loss function tells us
# how good or bad any particular model parameters are. This means we can use
# gradient descent to find the model parameters that make the loss as small as
# possible.

# x ranges from -50 to 49, y is always 20 * x + 5
inputs = [(x, 20 * x + 5) for x in range(-50, 50)]
print(inputs)


# in this case we know the parameters of the linear relationship 
# between x and y, but imagine we'd like to learn them from the data.
#
# We'll use gradient descent to find the slope and intercept that minimizes
# the average squared error (MSE)
#
# We'll start off with a function that determines the gradient based on the error
# from a single data point:
def linear_gradient(x: float, y: float, theta: Vector) -> Vector:
    """Determines the gradient based on the error from a single point"""
    slope, intercept = theta
    predicted = slope * x + intercept  # the prediction of the model
    error = (predicted - y)  # error is (predicted - actual)
    squared_error = error ** 2  # we'll minimize the squared error
    grad = [2 * error * x, 2 * error]  # using its gradient
    return grad

# let's think about what that gradient means
# imagine for some x our prediction is too large. In that case, the error 
# is positive. The second gradient term, 2 * error, is positive,
# which reflects the fact that small increases in the intercept will
# make the (already too large) prediction even larger, which will cause
# the squared error (for this x) to get even bigger

# the first gradient term, 2 * error * x, has the same sign as x. 
# sure enough, if x is positive, small increases in the slope will again
# make the prediction (and hence the error) larger. If x is negative,
# though, small increases in the slope will make the prediction
# (and hence the error) smaller

# now that computation was for a single data point. For the whole dataset,
# we'll look at the mean squared error. And the gradient of the mean 
# squared error is just the mean of the individual gradients.

# 1. start with a random value for theta
# 2. compute the mean of the gradients
# 3. adjust theta in that direction
# 4. repeat

# after a lot of epochs (what we call each pass through the dataset), we
# should learn something like the correct parameters

# start with random values for slope and intercept
theta = [random.uniform(-1, 1), random.uniform(-1, 1)]

learning_rate = 0.001

for epoch in range(5000):
    # Compute the mean of the gradients
    grad = vector_mean(vectors=[linear_gradient(x=x, y=y, theta=theta) 
                                for x, y in inputs])
    # take a step in that direction
    theta = gradient_step(v=theta, gradient=grad, step_size=-learning_rate)
    print(epoch, theta)

slope, intercept = theta
assert 19.9 < slope < 20.1, "slope should be about 20"
assert 4.9 < intercept < 5.1, "intercept should be about 5"

# minibatch gradient descent, in which we compute the gradient
# (and take a gradient step) based on a "minibatch" sampled from the
# larger dataset:
T = TypeVar("T")  # this allows us to type "generic" functions

def minibatches(dataset: List[T],
                batch_size: int,
                shuffle: bool = True) -> Iterator[List[T]]:
    """Generates `batch_size`-sized minibatches from the dataset"""
    # start indexes 0, batch_size, 2 * batch_size, ...
    batch_starts = [start for start in range(0, len(dataset), batch_size)]

    if shuffle:
        random.shuffle(batch_starts)  # shuffle the batches

    for start in batch_starts:
        end = start + batch_size
        yield dataset[start:end]


# now we can solve our problem again using minibatches
theta = [random.uniform(-1, 1), random.uniform(-1, 1)]

for epoch in range(1000):
    for batch in minibatches(dataset=inputs, batch_size=20):
        # Compute the mean of the gradients
        grad = vector_mean(vectors=[linear_gradient(x=x, y=y, theta=theta) 
                                    for x, y in inputs])
        # take a step in that direction
        theta = gradient_step(v=theta, gradient=grad, step_size=-learning_rate)
        print(epoch, theta)

slope, intercept = theta
assert 19.9 < slope < 20.1, "slope should be about 20"
assert 4.9 < intercept < 5.1, "intercept should be about 5"
