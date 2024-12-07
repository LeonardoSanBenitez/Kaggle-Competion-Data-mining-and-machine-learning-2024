import pandas as pd
from libs import PandasStandardScaler


def test_standard_scaler():
    scaler = PandasStandardScaler()
    X = pd.DataFrame({'A': [1, 2, 3], 'B': [2, 3, 4]})
    y = pd.Series([1, 2, 3])
    scaler.fit(X, y)
    result = scaler.transform(X)
    expected = pd.DataFrame({'A': [-1.22, 0.0, 1.22], 'B': [-1.22, 0.0, 1.22]})
    pd.testing.assert_frame_equal(result, expected, atol=0.01)
