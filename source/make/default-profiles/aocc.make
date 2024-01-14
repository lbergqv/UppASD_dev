#####################################################################################
## Makefile Settings for ifort profile  														  ##
#####################################################################################

#------------------------------------------------------------------------------------
# The different compilers
#------------------------------------------------------------------------------------

# Fortran compiler
FC = flang

# C compiler
CC = clang

# C++ compiler
CXX = clang
#------------------------------------------------------------------------------------
# Flags for FORTRAN compilation
#------------------------------------------------------------------------------------
# Basic optimization settings explained
# -ip         Inline function, substantioal speed up
# -O3         Optimization, faster execution, slow make times
# -ipo        Inline between files
# -xP         Intel processor specific optimizations
#c-fast       Uses -ipo -O3 -xP  -static
#FCFLAGS = -O3 -ffast-math -fopenmp -march=znver4 -Mextend
FCFLAGS = -Ofast -ffast-math -march=znver4 -Mextend -zopt

# Basic debug settings explained
# -g           Debug with gdb
# -CB          Array bound checks (same as check)
# -traceback   Gdb traceback
# -p           Function profiling with gprof
# -warn all    Show all warning messages
# -check all   Check all
# -xT          Optimization for intel(R) core(TM)2 Duo
#FCDEBUG = -g -traceback
FCDEBUG =
#------------------------------------------------------------------------------------
# Flags for C compilation
#------------------------------------------------------------------------------------
CCFLAGS = -O3 -g
CCLIBFLAGS =-fopenmp
# Declare what fortran compiler is used (for C/C++/CUDA code)
C_FCFLAG = -D__IFORT__
#------------------------------------------------------------------------------------
# Flags for C++ compilation
#------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------
# Define the path for the GCC
#------------------------------------------------------------------------------------
GCC_ID :=$(shell which icc | sed 's/bin/lib/g')
GCCPATH :=$(dir $(GCC_ID))
CXXFLAGS = -O3 -g -pthread
CXXLIBFLAGS = -L${GCCPATH} -lstdc++ -fopenmp 
#------------------------------------------------------------------------------------
# OpenMp related flags (-mp on PGI, -openmp on ifort)
#------------------------------------------------------------------------------------
# Special treatment for ifort compiler to ensure correct [q]openmp flags.
# First find compiler version
IFORTVER := $(shell $(FC) --version | sed 's/\./ /;s/ //;s/[^ ]* *//;s/ .*//;q')
# Then use -openmp if IFORTVER <= 14.x; otherwise use -qopenmp
#ifneq ($(shell test $(IFORTVER) -gt 14; echo $$?),0)
FCOMPFLAGS = -fopenmp -fopenmp-simd -mp
#else
#FCOMPFLAGS = -qopenmp -qno-openmp-simd
#endif
#------------------------------------------------------------------------------------
# Library flags
#------------------------------------------------------------------------------------
# -lblas       Basic Linear Algebra Subprograms
# -llapack     Linear Algebra Package (for eigenvalue, cholesky etc...)
# -lmkl        Includes lapack and blas
#FLIBFLAGS = -L/opt/AMD/aocl/aocl-linux-aocc-4.1.0/aocc/lib/ -lblis-mt -lflame -lfftw3f -lm -fopenmp
FLIBFLAGS = -lblis-mt -lflame -lrng_amd -lfftw3f -lm -fopenmp
#FLIBFLAGS = -llapack -lblas
#FLIBFLAGS =  -lopenblas

# ifort mod folder flag (used to put .mods in separate files)
FCMODFLAG = -module

# Enable CUDA support
USE_CUDA = NO

# Enable Intel Vector Statistical Library support for RNG
USE_VSL = NO 

PREPROC = -Mpreprocess

# Enable FFTW Support
USE_FFTW = NO 
# Enable MKL FFT Support
USE_MKL_FFT = NO 

# Enable OVF support
USE_OVF = NO


