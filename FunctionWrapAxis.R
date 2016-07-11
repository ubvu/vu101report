#FunctionWrapAxis



# Functie om labels van assen in figuren te "wrappen"  
# Core wrapping function
wrap.it <- function(x, len)
{ sapply(x, function(y) paste(strwrap(y, len),collapse = "\n"),USE.NAMES = FALSE)}


# Call this function with a list or vector; deze functie aanroepen in code
wrap.labels <- function(x, len)
{
  if (is.list(x))
  { lapply(x, wrap.it, len)} else {wrap.it(x, len)}
}
