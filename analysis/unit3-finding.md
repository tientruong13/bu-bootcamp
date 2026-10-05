# Unit 3 Finding: Ride-Sharing Dashboard Audit

To the Dashboard Team,

The dashboard reported that roughly half of all trips were in a failure state, which led leadership to freeze the quarterly driver bonuses. After reviewing the underlying trip data, I found that this does not reflect what the data actually shows. The dataset contains 200 trips, and only 12 of them were associated with a rider no-show, which is 6% of all trips. This is substantially lower than the failure rate presented by the dashboard.

The discrepancy appears to come from the way missing cancellation information was handled. Many trips do not have a cancellation reason because that information does not apply to every trip. The dashboard logic treated or excluded these missing values in a way that distorted the result rather than separating actual rider no-shows from trips with no cancellation reason. Because the reported failure rate is not supported by the underlying data, the driver bonus freeze should be reconsidered. I recommend correcting the dashboard calculation, validating the updated result, and using the corrected figures before making a final decision about driver bonuses.
