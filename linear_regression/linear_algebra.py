from typing import Callable, List, Tuple
import math

Vector = List[float]

# note: the examples come from Joel Grus' Data Science from Scratch book
#       from the Linear Algebra chapter
#
# note: do not use this code in production. Use numpy instead.


def add(v: Vector, w: Vector) -> Vector:
    """Adds corresponding elements"""
    assert len(v) == len(w), "vectors must be the same length"

    return [v_i + w_i for v_i, w_i in zip(v, w)]


assert add(v=[1, 2, 3], w=[4, 5, 6]) == [5, 7, 9]


def subtract(v: Vector, w: Vector) -> Vector:
    """Subtracts correponding elements"""
    assert len(v) == len(w), "vectors must be the same length"

    return [v_i - w_i for v_i, w_i in zip(v, w)]


assert subtract(v=[5, 7, 9], w=[4, 5, 6]) == [1, 2, 3]


def vector_sum(vectors: List[Vector]) -> Vector:
    """Sums all corresponding elements"""
    assert vectors, "no vectors provided!"

    # check the vectors are all the same size
    num_elements = len(vectors[0])
    assert all(len(v) == num_elements for v in vectors), "different sizes!"

    # the i-th element of the result is the sum of every vector[i]
    return [sum(vector[i] for vector in vectors)
            for i in range(num_elements)]


assert vector_sum(vectors=[[1, 2], [3, 4], [5, 6], [7, 8]]) == [16, 20]


def scalar_multiply(c: float, v: Vector) -> Vector:
    """Multiplies every element by c"""
    return [c * v_i for v_i in v]


assert scalar_multiply(c=2, v=[1, 2, 3]) == [2, 4, 6]


def vector_mean(vectors: List[Vector]) -> Vector:
    """Computes the element-wise average"""
    n = len(vectors)
    return scalar_multiply(1 / n, vector_sum(vectors=vectors))


assert vector_mean(vectors=[[1, 2], [3, 4], [5, 6]]) == [3, 4]


def dot(v: Vector, w: Vector) -> float:
    """Sum of componentwise products of two vectors"""
    assert len(v) == len(w), "vectors must be the same length"

    return (sum(v_i * w_i for v_i, w_i in zip(v, w)))


assert dot(v=[1, 2, 3], w=[4, 5, 6]) == 32  # 1 * 4 + 2 * 5 + 3 * 6


def sum_of_squares(v: Vector) -> float:
    """"Sum of the ith-element squared from a vector"""
    return dot(v=v, w=v)


assert sum_of_squares(v=[1, 2, 3]) == 14  # 1 * 1 + 2 * 2 + 3 * 3


def magnitude(v: Vector) -> float:
    """Calculate the length of the vector"""
    return math.sqrt(sum_of_squares(v=v))


assert magnitude(v=[3, 4]) == 5


def squared_distance(v: Vector, w: Vector) -> float:
    """Computes the squared-difference between the componentwise elements"""
    return sum_of_squares(v=subtract(v=v, w=w))


def distance(v: Vector, w: Vector) -> float:
    return magnitude(v=subtract(v=v, w=w))


Matrix = List[List[float]]

A = [[1, 2, 3],  # A has 2 rows and 3 columns
     [4, 5, 6]]

B = [[1, 2],  # B has 3 rows and 2 columns
     [3, 4],
     [5, 6]]


def shape(A: Matrix) -> Tuple[int, int]:
    """Calculates the number of rows and columns in a matrix"""
    num_rows = len(A)
    num_cols = len(A[0]) if A else 0  # if A is an empty list, return 0
    return num_rows, num_cols


assert shape(A=[[1, 2, 3], [4, 5, 6]]) == (2, 3)  # 2 rows, 3 columns


def get_row(A: Matrix, i: int) -> Vector:
    """Returns the i-th row of A (as a Vector)"""
    return A[i]  # A[i] is already the ith row


def get_column(A: Matrix, j: int) -> Vector:
    """Returns the j-ith column of A (as a Vector)"""
    return [A_i[j] for A_i in A]  # jth element for row A_i for each row in A


def make_matrix(num_rows: int,
                num_cols: int,
                entry_fn: Callable[[int, int], float]) -> Matrix:
    """"Returns a num_rows x num_cols matrix
    The (i, j)-th entry is entry_fn(i, j)
    """
    return [[entry_fn(i, j)                # given i, create a list
             for j in range(num_cols)]     # [entry_fn(i, 0), ...]
            for i in range(num_rows)]     # create one list for each i


def identity_matrix(n: int) -> Matrix:
    """Create n x n identity matrix
    (with 1s going across diagonally and 0s elsewhere)
    """
    return make_matrix(num_rows=n,
                       num_cols=n,
                       entry_fn=lambda i, j: 1 if i == j else 0)


assert identity_matrix(n=3) == [[1, 0, 0],
                                [0, 1, 0],
                                [0, 0, 1]]


friend_matrix = [[0, 1, 1, 0, 0, 0, 0, 0, 0, 0],
                 [1, 0, 1, 1, 0, 0, 0, 0, 0, 0],
                 [1, 1, 0, 1, 0, 0, 0, 0, 0, 0],
                 [0, 1, 1, 0, 1, 0, 0, 0, 0, 0],
                 [0, 0, 0, 1, 0, 1, 0, 0, 0, 0],
                 [0, 0, 0, 0, 1, 0, 1, 1, 0, 0],
                 [0, 0, 0, 0, 0, 1, 0, 0, 1, 0],
                 [0, 0, 0, 0, 0, 1, 0, 0, 1, 0],
                 [0, 0, 0, 0, 0, 0, 1, 1, 0, 1],
                 [0, 0, 0, 0, 0, 0, 0, 0, 1, 0]]

assert friend_matrix[0][2] == 1, "0 and 2 are friends"
assert friend_matrix[0][8] == 0, "0 and 9 are not friends"

# only need to look at one row
friends_of_five = [i
                   for i, is_friend in enumerate(friend_matrix[5])
                   if is_friend]
