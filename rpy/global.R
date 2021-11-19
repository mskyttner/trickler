library(plumber)
library(reticulate)

# install some python libs
py_install(c("scipy", "pandas", "requests", "matplotlib"))

# NB: the "module name" is the test_function.py (no extension)
# and the dir is here given with full path
module <- import_from_path('test_function',  '/plumberdir/python_module')

