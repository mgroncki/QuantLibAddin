
SWIG_FILES := \
    quantlib.i \
    functions/all.i \
    functions/calendars.i \
    functions/couponvectors.i \
    functions/date.i \
    functions/daycounters.i \
    functions/exercise.i \
    functions/handles.i \
    functions/indexes.i \
    functions/instruments.i \
    functions/interpolation.i \
    functions/leg.i \
    functions/math.i \
    functions/models.i \
    functions/payoffs.i \
    functions/piecewiseyieldcurve.i \
    functions/prices.i \
    functions/pricingengines.i \
    functions/processes.i \
    functions/quote.i \
    functions/ratehelpers.i \
    functions/schedule.i \
    functions/settings.i \
    functions/termstructures.i \
    functions/utilities.i \
    functions/vanillaswaps.i \
    functions/volatilities.i \
    typedefs/all.i \
    typemaps/addincountify.i \
    typemaps/addincpp.i \
    typemaps/addincsharp.i \
    typemaps/addinexcel.i \
    typemaps/all.i \
    typemaps/apply.i \
    typemaps/doxygen.i \
    typemaps/handles.i \
    typemaps/libraryobjects.i \
    typemaps/serialization.i \
    typemaps/shared.i \
    typemaps/valueobjects.i

DOCSTRINGS_FILE=../docstrings/docstrings.txt

EXTRA_DIST = \
    $(SWIG_FILES) \
    Makefile.vc \
    swigrun_cpp_vc9.vcproj \
    swigrun_xl_vc9.vcproj

SWIG_DIR = @swig_dir@
SWIG_BIN = $(SWIG_DIR)/swig
SWIG_SWG = $(SWIG_DIR)/Lib/reposit/reposit.swg
SWIG_CMD = $(SWIG_DIR)/preinst-swig
#SWIG_DEBUG = -debug-top 4 -debug-tmsearch

SWIG_ARGS = -c++ -reposit -legacy -prefix ql
if BUILD_CPP
    SWIG_ARGS += -genc++
endif
#if BUILD_CALC
#    SWIG_ARGS += -gencalc
#endif
if BUILD_CFY
    SWIG_ARGS += -gencfy
endif
#SWIG_ARGS += -genxll
SWIG_ARGS += quantlib.i

all: SWIG

.PHONY: SWIG
SWIG: .time-stamp

.time-stamp: $(SWIG_FILES) $(SWIG_BIN) $(SWIG_SWG) $(DOCSTRINGS_FILE)
	$(SWIG_CMD) $(SWIG_DEBUG) $(SWIG_ARGS)
	touch .time-stamp

clean:
	rm -f .time-stamp

