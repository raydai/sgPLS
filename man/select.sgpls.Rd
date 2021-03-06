\name{select.sgpls}
\alias{select.sgpls}
\title{Output of selected variables from a gPLS model or a sgPLS model}
\usage{
  select.sgpls(model)
}
\arguments{
  \item{model}{object of class inheriting from  \code{"gPLS"} or\code{"sgPLS"}.}
   
}
\description{
This function outputs the selected variables on each component for the group and sparse group PLS. 
}

\value{
  \code{select.sgpls} produces a list with the following components: 
  \item{group.size.X}{A matrix containing in the first column the size of the groups in the \eqn{X} dataset. Then, the next columns indicate the size of the groups selected for each component.}
  \item{select.group.X}{A list containing for each element (corresponding to each group of the \eqn{X} dataset) the indices of the variables selected.}
\item{group.size.Y}{A matrix containing in the first column the size of the groups in the \eqn{Y} dataset. Then the next columns indicate the size of the groups selected for each component.}
  \item{select.group.Y}{A list containing for each element (corresponding to each group of the \eqn{Y} dataset) the indices of the variables selected.}
\item{select.X}{A list containing for each element (corresponding to each component of the gPLS or sgPLS model) the names of the selected variables in the \eqn{X} dataset.}
  \item{select.Y}{A list containing for each element (corresponding to each component of the gPLS or sgPLS model) the names of the selected variables in the \eqn{Y} dataset.}
  \item{select.X.total}{The names of the variables selected from the gPLS or sgPLS model regarding the \eqn{X} matrix.}
  \item{select.Y.total}{The names of the variables selected from the gPLS or sgPLS model regarding the \eqn{Y} matrix.}
}

\author{
Benoit Liquet, \email{b.liquet@uq.edu.au}, \cr Pierre Lafaye de Micheaux \email{lafaye@dms.umontreal.ca}
}

\examples{
\dontrun{	
## Simulation of datasets X and Y with group variables
n <- 100
sigma.gamma <- 1
sigma.e <- 1.5
p <- 400
q <- 500
theta.x1 <- c(rep(1,15),rep(0,5),rep(-1,15),rep(0,5),rep(1.5,15)
			,rep(0,5),rep(-1.5,15),rep(0,325))
theta.x2 <- c(rep(0,320),rep(1,15),rep(0,5),rep(-1,15),rep(0,5),
			rep(1.5,15),rep(0,5),rep(-1.5,15),rep(0,5))

theta.y1 <- c(rep(1,15),rep(0,5),rep(-1,15),rep(0,5),rep(1.5,15)
			,rep(0,5),rep(-1.5,15),rep(0,425))
theta.y2 <- c(rep(0,420),rep(1,15),rep(0,5),rep(-1,15),rep(0,5),
			rep(1.5,15),rep(0,5),rep(-1.5,15),rep(0,5))                            


Sigmax <- matrix(0, nrow = p, ncol = p)
diag(Sigmax) <- sigma.e ^ 2
Sigmay <- matrix(0, nrow = q, ncol = q)
diag(Sigmay) <- sigma.e ^ 2

set.seed(125)

gam1 <- rnorm(n)
gam2 <- rnorm(n)

X <- matrix(c(gam1, gam2), ncol = 2, byrow = FALSE) \%*\% matrix(c(theta.x1, theta.x2),
     nrow = 2, byrow = TRUE) + rmvnorm(n, mean = rep(0, p), sigma =
     Sigmax, method = "svd")
Y <- matrix(c(gam1, gam2), ncol = 2, byrow = FALSE) \%*\% matrix(c(theta.y1, theta.y2),
     nrow = 2, byrow = TRUE) + rmvnorm(n, mean = rep(0, q), sigma =
     Sigmay, method = "svd")

ind.block.x <- seq(20, 380, 20)
ind.block.y <- seq(20, 480, 20)

#### gPLS model
model.sgPLS <- sgPLS(X, Y, ncomp = 2, mode = "regression", keepX = c(4, 4), 
                   keepY = c(4, 4), ind.block.x = ind.block.x,
                   ind.block.y = ind.block.y,
                   alpha.x = c(0.5, 0.5), alpha.y = c(0.5, 0.5))

result.sgPLS <- select.sgpls(model.sgPLS)
result.sgPLS$group.size.X
result.sgPLS$group.size.Y

#### gPLS model
model.gPLS <- gPLS(X, Y, ncomp = 2, mode = "regression", keepX = c(4, 4), 
     keepY = c(4,4), ind.block.x = ind.block.x ,ind.block.y = ind.block.y)

result.gPLS <- select.sgpls(model.gPLS)
result.gPLS$group.size.X
result.gPLS$group.size.Y



}
}