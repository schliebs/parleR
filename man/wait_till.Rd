% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils_export.R
\name{wait_till}
\alias{wait_till}
\title{Planned sleep times}
\usage{
wait_till(from = NULL, resume = NULL, seconds = NULL)
}
\arguments{
\item{from}{A datetime object, when the beginning of the sleep interval.}

\item{resume}{A datetime object, representing when the script shall resume.}

\item{seconds}{An integer, representing the amount of seconds to wait.}
}
\description{
Pause the execution of a script either until a certain time is reached,
or until a specified amount of time has passed.
}
\details{
Takes either \code{resume} OR a combination of \code{from} and \code{seconds}.
}
\examples{
# Continue script after 20:30:34 on November 14th 2020

continue_at <- lubridate::as_datetime("2020-11-14 20:30:34")
wait_till(resume = continue_at, seconds = 12)

# Continue script 12 seconds after the last call was made

last_timestamp <- lubridate::now()
wait_till(from = last_timestamp, seconds = 12)
}
