% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/kpPlotBAMCoverage.R
\name{kpPlotBAMCoverage}
\alias{kpPlotBAMCoverage}
\title{kpPlotBAMCoverage}
\usage{
kpPlotBAMCoverage(karyoplot, data=NULL, max.valid.region.size=1e6, ymin=NULL, ymax=NULL, data.panel=1, r0=NULL, r1=NULL, col=NULL, border=NA, clipping=TRUE,...)
}
\arguments{
\item{karyoplot}{(a \code{KaryoPlot} object) This is the first argument to all data plotting functions of \code{karyoploteR}. A KaryoPlot object referring to the currently active plot.}

\item{data}{(a character) The path to a bam file (must be indexed).}

\item{max.valid.region.size}{(numeric) If the length of plotted region exceeds this number, nothing will be plotted. It's a safety mechanism to from excessive memory usage. (Defaults to 1e6, 1 milion bases)}

\item{ymin}{(numeric) The minimum value to be plotted on the data panel. If NULL, it is set to 0. (deafults to NULL)}

\item{ymax}{(numeric) The maximum value to be plotted on the data.panel. If NULL the maximum density is used. (defaults to NULL)}

\item{data.panel}{(numeric) The identifier of the data panel where the data is to be plotted. The available data panels depend on the plot type selected in the call to \code{\link{plotKaryotype}}. (defaults to 1)}

\item{r0}{(numeric) r0 and r1 define the vertical range of the data panel to be used to draw this plot. They can be used to split the data panel in different vertical ranges (similar to tracks in a genome browser) to plot differents data. If NULL, they are set to the min and max of the data panel, it is, to use all the available space. (defaults to NULL)}

\item{r1}{(numeric) r0 and r1 define the vertical range of the data panel to be used to draw this plot. They can be used to split the data panel in different vertical ranges (similar to tracks in a genome browser) to plot differents data. If NULL, they are set to the min and max of the data panel, it is, to use all the available space. (defaults to NULL)}

\item{col}{(color) The fill color to plot. If NULL the color will be assigned automatically, either a lighter version of the color used for the outer line or gray if the line color is not defined. If NA no area will be drawn. (defaults to NULL)}

\item{border}{(color) The color to use to plot the borders of the bars. If NULL, it will be a darker version of 'col'. If NA, no border will be plotted. (Defaults to NA)}

\item{clipping}{(boolean) Only used if zooming is active. If TRUE, the data representation will be not drawn out of the drawing area (i.e. in margins, etc) even if the data overflows the drawing area. If FALSE, the data representation may overflow into the margins of the plot. (defaults to TRUE)}

\item{...}{The ellipsis operator can be used to specify any additional graphical parameters. Any additional parameter will be passed to the internal calls to the R base plotting functions. In particular \code{col} and \code{border} can be used to set the colors used.}
}
\value{
Returns the original karyoplot object with the data computed (max.coverage) stored at \code{karyoplot$latest.plot}
}
\description{
Plots the coverage of a BAM file along the genome
}
\details{
\code{kpPlotBAMCoverage} plots the read coverage of a BAM file, that is, the 
number of reads overlapping each position. It uses the 
\code{\link{bamsignals}} package to efficiently access the BAM file.
The BAM file must be indexed. This function is only recommended when 
plotting small parts of the genome. For larger plots consider using 
\code{\link{kpPlotBAMDensity}}.

There's more information at the \url{https://bernatgel.github.io/karyoploter_tutorial/}{karyoploteR tutorial}.
}
\note{
Since the plotting the exact coverage for large
regions of the genome may be unfeasable, it includes a safety mechanism
causing it to raise a warning and do nothing if the region is larger than 
a threshold specified by \code{max.valid.region.size}.
}
\examples{

library(pasillaBamSubset) #A package with 2 example bam files
un1.bam.file <- untreated1_chr4() # get the name of the first bam
un3.bam.file <- untreated3_chr4() #and the name of the second

kp <- plotKaryotype(genome="dm6", chromosomes="chr4") #The pasilla data comes from drosophila
kp <- kpAddBaseNumbers(kp, tick.dist = 1e5)
kp <- kpPlotBAMCoverage(kp, data = un1.bam.file) #Warning and does not plot. region too large.
kp <- kpPlotBAMCoverage(kp, data = un1.bam.file, max.valid.region.size=2000000)

#Use zoom to plot a smaller region to see the coverage with more detail
kp <- plotKaryotype(genome="dm6", zoom=toGRanges("chr4", 340000, 350000))
kp <- kpAddBaseNumbers(kp, tick.dist = 1e3)
kp <- kpPlotBAMCoverage(kp, data = un1.bam.file)


#Change the colors and borders and compare  two bams
kp <- plotKaryotype(genome="dm6", zoom=toGRanges("chr4", 340000, 350000))
kp <- kpAddBaseNumbers(kp, tick.dist = 1e3)
kp <- kpPlotBAMCoverage(kp, data = un1.bam.file, r0=0.5, r1=1, border="orange")
kp <- kpPlotBAMCoverage(kp, data = un3.bam.file, r0=0.5, r1=0, border="darkgreen") #r1 < r0 will flip the plot
kpAbline(kp, h=0.5, col="darkgray")



}
\seealso{
\code{\link{kpPlotBAMDensity}}, \code{\link{kpPlotCoverage}}
}
