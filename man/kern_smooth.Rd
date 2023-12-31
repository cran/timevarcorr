% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/smoothers.R
\name{kern_smooth}
\alias{kern_smooth}
\title{Smoothing by kernel regression}
\usage{
kern_smooth(
  x,
  t = seq_along(x),
  h,
  t.for.pred = t,
  kernel = c("epanechnikov", "box", "normal"),
  param_smoother = list(),
  output = c("dataframe", "list")
)
}
\arguments{
\item{x}{a numeric vector of the series to be smoothed.}

\item{t}{a (numeric or Date) vector of time points. If missing, observations
are considered to correspond to sequential time steps (i.e., 1, 2 ...).}

\item{h}{a scalar indicating the bandwidth used by the smoothing function.}

\item{t.for.pred}{a (numeric or Date) vector of time points at which to
evaluate the smoothed fit. If missing, \code{t} is used.}

\item{kernel}{a character string indicating which kernel to use: "epanechnikov"
(the default), "box", or "normal" (abbreviations also work).}

\item{param_smoother}{a list of additional parameters to provide to the
internal smoothing function (see \strong{Details}).}

\item{output}{a character string indicating if the output should be a "dataframe"
(default) or a list (for faster computation when the function is called repeatedly).}
}
\value{
a dataframe of time points (\code{t.for.pred}) and corresponding fitted
values.
}
\description{
The function perform the smoothing of a time-series by non-parametric kernel regression.
}
\details{
The function is essentially a wrapper that calls different underlying
functions depending on the kernel that is selected:
\itemize{
\item \code{\link[lpridge:lpepa]{lpridge::lpepa()}} for "epanechnikov".
\item \code{\link[stats:ksmooth]{stats::ksmooth()}} for "normal" and "box".
The argument \code{param_smoother} can be used to pass additional arguments to
these functions.
}
}
\examples{

## Smooth 10 first values of a vector

kern_smooth(stockprice$DAX[1:20], h = 5)


## Prediction at time step 2 and 3

kern_smooth(stockprice$DAX, h = 1, t.for.pred = c(2, 3))


## Smoothing using a vector of dates for time

kern_smooth(x = stockprice$DAX[1:10], t = stockprice$DateID[1:10], h = 5)


## Smoothing conserves original order

kern_smooth(x = stockprice$DAX[10:1], t = stockprice$DateID[10:1], h = 5)


## Effect of the bandwidth

plot(stockprice$DAX[1:100] ~ stockprice$DateID[1:100],
     las = 1, ylab = "DAX index", xlab = "Date")
points(kern_smooth(stockprice$DAX[1:100], stockprice$DateID[1:100], h = 1),
       type = "l", col = "grey")
points(kern_smooth(stockprice$DAX[1:100], stockprice$DateID[1:100], h = 3),
       type = "l", col = "blue")
points(kern_smooth(stockprice$DAX[1:100], stockprice$DateID[1:100], h = 10),
       type = "l", col = "red")
legend("topright", fill = c("grey", "blue", "red"),
       legend = c("1", "3", "10"), bty = "n", title = "Bandwidth (h)")


## Effect of the kernel

plot(stockprice$DAX[1:100] ~ stockprice$DateID[1:100],
     las = 1, ylab = "DAX index", xlab = "Date")
points(kern_smooth(stockprice$DAX[1:100], stockprice$DateID[1:100], h = 10),
       type = "l", col = "orange")
points(kern_smooth(stockprice$DAX[1:100], stockprice$DateID[1:100], h = 10, kernel = "box"),
       type = "l", col = "blue")
points(kern_smooth(stockprice$DAX[1:100], stockprice$DateID[1:100], h = 10, kernel = "norm"),
       type = "l", col = "red")
legend("topright", fill = c("orange", "blue", "red"),
       legend = c("epanechnikov", "box", "normal"), bty = "n", title = "Kernel method")

}
\references{
A short post we found useful: \url{http://users.stat.umn.edu/~helwig/notes/smooth-notes.html}
}
\seealso{
\code{\link{tcor}}
}
