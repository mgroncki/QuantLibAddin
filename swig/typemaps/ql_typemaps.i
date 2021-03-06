
//*****************************************************************************
// rp_tm_xxx_* - typemaps shared by multiple addins
//*****************************************************************************

// rp_tm_xxx_rp_get:  Retrieve an object from the repository.

//*****************************************************************************
// rp_tm_lib_* - typemaps for Library Objects
//*****************************************************************************

// GROUP

// HPP

// Not a real typemap. Defined in code.  RP_OBJ_CLASS (C)
// rp_tm_lib_cls

// CPP

// rp_tm_lib_rtst - Return statement (F)

//*****************************************************************************
// rp_tm_vob_* - typemaps for Value Objects
//*****************************************************************************

// GROUP

// XPP

// rp_tm_vob_parm - Value Object constructor parameters (C)

%typemap(rp_tm_vob_parm) QuantLib::Date "const reposit::property_t&";
%typemap(rp_tm_vob_parm) QuantLib::Date & "const reposit::property_t&";
%typemap(rp_tm_vob_parm) QuantLib::Handle<QuantLib::Quote> & "const reposit::property_t&";
%typemap(rp_tm_vob_parm) QuantLib::Matrix & "const std::vector<std::vector<double> >&";
%typemap(rp_tm_vob_parm) std::vector<QuantLib::Date> & "const std::vector<reposit::property_t>&";
%typemap(rp_tm_vob_parm) std::vector<QuantLib::Period> & "const std::vector<reposit::property_t>&";
%typemap(rp_tm_vob_parm) std::vector<boost::shared_ptr<QuantLib::RateHelper > > & "const std::vector<std::string>&";

// HPP

// rp_tm_vob_mbvr - Value Object class member variables (C)

%typemap(rp_tm_vob_mbvr) QuantLib::Date "reposit::property_t $1_name_";
%typemap(rp_tm_vob_mbvr) QuantLib::Date & "reposit::property_t $1_name_";
%typemap(rp_tm_vob_mbvr) QuantLib::Handle<QuantLib::Quote> & "reposit::property_t $1_name_";
%typemap(rp_tm_vob_mbvr) QuantLib::Matrix & "std::vector<std::vector <double> > $1_name_";
%typemap(rp_tm_vob_mbvr) std::vector<QuantLib::Date> & "std::vector<reposit::property_t> $1_name_";
%typemap(rp_tm_vob_mbvr) std::vector<QuantLib::Period> & "std::vector<reposit::property_t> $1_name_";
%typemap(rp_tm_vob_mbvr) std::vector<boost::shared_ptr<QuantLib::RateHelper > > & "std::vector<std::string> $1_name_";

// rp_tm_vob_srmv - code to serialize a Value Object member variable (C)

// CPP

// rp_tm_vob_name - Insert the parameter name into the vo property names array (C)

// rp_tm_vob_init - vo ctor initializer list (C)

// rp_tm_vob_cnvt - in ValueObject::setSystemProperty, convert value from property_t to native type (C)

%typemap(rp_tm_vob_cnvt) QuantLib::Date "value";
%typemap(rp_tm_vob_cnvt) QuantLib::Date & "value";
%typemap(rp_tm_vob_cnvt) QuantLib::Matrix & "reposit::matrix::convert<double>(value, nameUpper)";
%typemap(rp_tm_vob_cnvt) std::vector<QuantLib::Date> & "reposit::vector::convert<reposit::property_t>(value, nameUpper)";
%typemap(rp_tm_vob_cnvt) std::vector<QuantLib::Period> & "reposit::vector::convert<reposit::property_t>(value, nameUpper)";
%typemap(rp_tm_vob_cnvt) std::vector<boost::shared_ptr<QuantLib::RateHelper> > & "reposit::vector::convert<std::string>(value, nameUpper)";

//*****************************************************************************
// rp_tm_scr_* - typemaps for Serialization - Create
//*****************************************************************************

// GROUP

// CPP

// rp_tm_scr_cnvt - convert types from the Value Object to the corresponding Library Object (C)

%typemap(rp_tm_scr_cnvt) QuantLib::Period %{
    std::string $1_name_str =
        reposit::convert<std::string>(valueObject->getProperty("$1_name"));
    QuantLib::Period $1_name = getPeriod($1_name_str);
%}
%typemap(rp_tm_scr_cnvt) QuantLib::Period & = QuantLib::Period;

%typemap(rp_tm_scr_cnvt) QuantLib::Date & %{
    QuantLib::Date $1_name =
        reposit::convert<QuantLib::Date>(
            valueObject->getProperty("$1_name"));
%}

%typemap(rp_tm_scr_cnvt) QuantLib::Matrix & %{
    std::vector<std::vector<double> > $1_name_vec =
        reposit::matrix::convert<double>(valueObject->getProperty("$1_name"), "$1_name");
    QuantLib::Matrix $1_name =
        QuantLibAddin::vvToQlMatrix($1_name_vec);
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Real> & %{
   std::vector<double> $1_name_vec =
        reposit::vector::convert<double>(valueObject->getProperty("$1_name"), "$1_name");
   std::vector<QuantLib::Real> $1_name =
        QuantLibAddin::convertVector<double, QuantLib::Real>($1_name_vec);
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Date> & %{
    std::vector<reposit::property_t> $1_name_vec =
        reposit::vector::convert<reposit::property_t>(valueObject->getProperty("$1_name"), "$1_name");
    std::vector<QuantLib::Date> $1_name =
        reposit::vector::convert<QuantLib::Date>($1_name_vec, "$1_name");
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Period> & %{
    std::vector<reposit::property_t> $1_name_vec =
        reposit::vector::convert<reposit::property_t>(valueObject->getProperty("$1_name"), "$1_name");
    std::vector<QuantLib::Period> $1_name =
        reposit::vector::convert<QuantLib::Period>($1_name_vec, "$1_name");
%}

//*****************************************************************************
// rp_tm_cpp_* - typemaps for the C++ Addin
//*****************************************************************************

// GROUP

// XPP

// rp_tm_cpp_rttp - Function return type (F)

// rp_tm_cpp_parm - Function input parameter (F/C/M)

// rp_tm_cpp_rtmb - return type of a member function (M)

// CPP

// rp_tm_cpp_cnvt - Convert inputs from C++ Addin api types into underlying Library types (F/C/M)

// rp_tm_cpp_rtdc - declare variable to capture return value of Library function (F/M)

// rp_tm_cpp_rtst - return statement (F/M)

// rp_tm_cpp_args - arguments to the underlying Library function (F/C/M)

//*****************************************************************************
// rp_tm_xll_* - typemaps for the Excel Addin
//*****************************************************************************

// GROUP

// CPP

// rp_tm_xll_rtft - function return type (F/M)

%typemap(rp_tm_xll_rtft) QuantLib::Date "long*";
%typemap(rp_tm_xll_rtft) QuantLib::Date & "long*";
%typemap(rp_tm_xll_rtft) QuantLib::Disposable< QuantLib::Matrix > "OPER*";
%typemap(rp_tm_xll_rtft) QuantLib::Array & "OPER*";
%typemap(rp_tm_xll_rtft) QuantLib::Matrix "OPER*";
%typemap(rp_tm_xll_rtft) QuantLib::Matrix & "OPER*";
%typemap(rp_tm_xll_rtft) QuantLib::InterestRate "double*";

// rp_tm_xll_parm - function parameters (F/C/M)

%typemap(rp_tm_xll_parm) QuantLib::InterestRate & "double*";
%typemap(rp_tm_xll_parm) QuantLib::Matrix & "FP*";
%typemap(rp_tm_xll_parm) boost::shared_ptr<QuantLibAddin::RateHelper> & "char*";

// rp_tm_xll_cnvt - convert from Excel datatypes to the datatypes of the underlying Library

%typemap(rp_tm_xll_cnvt) QuantLib::Period %{
        QuantLib::Period $1_name_cnv = QuantLibAddin::getPeriod($1_name);
%}
%typemap(rp_tm_xll_cnvt) QuantLib::Period & = QuantLib::Period;

// FIXME in the two typemaps below we allow all date arguments to have a default value.
// This should be done explicitly using rp_tm_xll_cnvt2.
%typemap(rp_tm_xll_cnvt) QuantLib::Date %{
        QuantLib::Date $1_name_cnv = reposit::convert<QuantLib::Date>(
            reposit::ConvertOper(*$1_name), "$1_name", QuantLib::Date());

        reposit::property_t $1_name_cnv2 = reposit::convert<reposit::property_t>(
            reposit::ConvertOper(*$1_name));
%}
%typemap(rp_tm_xll_cnvt) QuantLib::Date & = QuantLib::Date;

// Here are the correct typemaps for when a default value is specified in the swig iface file.
%typemap(rp_tm_xll_cnvt2) QuantLib::Date %{
        QuantLib::Date $1_name_cnv = reposit::convert<QuantLib::Date>(
            reposit::ConvertOper(*$1_name), "$1_name", QuantLib::Date());

        reposit::property_t $1_name_cnv2 = reposit::convert<reposit::property_t>(
            reposit::ConvertOper(*$1_name));
%}
%typemap(rp_tm_xll_cnvt2) QuantLib::Date & = QuantLib::Date;

%typemap(rp_tm_xll_cnvt) QuantLib::Matrix & %{
        std::vector<std::vector<double> > $1_name_vec =
            reposit::fpToMatrix<double>(*$1_name);
        QuantLib::Matrix $1_name_vec2 =
            QuantLibXL::operToQlMatrix(*$1_name);
%}

%typemap(rp_tm_xll_cnvt) std::vector<QuantLib::Date> %{
        std::vector<QuantLib::Date> $1_name_vec =
            reposit::operToVector<QuantLib::Date>(*$1_name, "$1_name");
%}

%typemap(rp_tm_xll_cnvt) std::vector<QuantLib::Date> & %{
        std::vector<reposit::property_t> $1_name_vec =
            reposit::operToVector<reposit::property_t>(*$1_name, "$1_name");
        std::vector<QuantLib::Date> $1_name_vec2 =
            reposit::operToVector<QuantLib::Date>(*$1_name, "$1_name");
%}

%typemap(rp_tm_xll_cnvt) std::vector<QuantLib::Period> & %{
        std::vector<reposit::property_t> $1_name_vec =
            reposit::operToVector<reposit::property_t>(*$1_name, "$1_name");
        std::vector<QuantLib::Period> $1_name_vec2 =
            reposit::operToVector<QuantLib::Period>(*$1_name, "$1_name");
%}

// rp_tm_xll_argv - arguments to the Value Object constructor (C)

%typemap(rp_tm_xll_argv) QuantLib::Date "$1_name_cnv2";
%typemap(rp_tm_xll_argv) QuantLib::Date & "$1_name_cnv2";
%typemap(rp_tm_xll_argv) QuantLib::Matrix & "$1_name_vec";

%typemap(rp_tm_xll_argv2) QuantLib::Date "$1_name_cnv2";
%typemap(rp_tm_xll_argv2) QuantLib::Date & "$1_name_cnv2";

// rp_tm_xll_argf - arguments to the underlying Library function (F/C/M)

%typemap(rp_tm_xll_argf) QuantLib::InterestRate & "*$1_name";
%typemap(rp_tm_xll_argf) QuantLib::Period "$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::Period & "$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::Date "$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::Date & "$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::Matrix & "$1_name_vec2";
%typemap(rp_tm_xll_argf) boost::shared_ptr<QuantLibAddin::RateHelper> & "$1_name_obj";
%typemap(rp_tm_xll_argf) std::vector<QuantLib::Date> & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<QuantLib::Period> & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<QuantLib::Handle<QuantLib::Quote> >& "$1_name_vec";
%typemap(rp_tm_xll_argf) std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > > & "$1_name_vec";

// rp_tm_xll_rtdc - declare variable to capture return value of Library function (F/M)

%typemap(rp_tm_xll_rtdc) QuantLib::Array & "QuantLib::Array returnValue =";
%typemap(rp_tm_xll_rtdc) QuantLib::Matrix & "QuantLib::Matrix returnValue =";
%typemap(rp_tm_xll_rtdc) QuantLib::Disposable<QuantLib::Matrix> "QuantLib::Matrix returnValue =";
%typemap(rp_tm_xll_rtdc) QuantLib::InterestRate "double returnValue =";

%typemap(rp_tm_xll_rtst) QuantLib::InterestRate %{
        static double ret;
        ret = returnValue;
        return &ret;
%}

// rp_tm_xll_rtst - return statement (F/M)

%typemap(rp_tm_xll_rtst) QuantLib::Array & %{
        static OPER xRet;
        reposit::vectorToOper(returnValue, xRet);
        return &xRet;
%}

%typemap(rp_tm_xll_rtst) QuantLib::Matrix %{
        static OPER xRet;
        reposit::matrixToOper(returnValue, xRet);
        return &xRet;
%}
%typemap(rp_tm_xll_rtst) QuantLib::Matrix & = QuantLib::Matrix;
%typemap(rp_tm_xll_rtst) QuantLib::Disposable<QuantLib::Matrix> = QuantLib::Matrix;

%typemap(rp_tm_xll_rtst) QuantLib::Period %{
        std::string str = QuantLibAddin::libraryToScalar(returnValue);
        static char ret[XL_MAX_STR_LEN];
        reposit::stringToChar(str, ret);
        return ret;
%}
%typemap(rp_tm_xll_rtst) QuantLib::Period & = QuantLib::Period;

%typemap(rp_tm_xll_rtst) QuantLib::Date %{
        static long returnValueXL;
        returnValueXL = static_cast<long>(QuantLibAddin::libraryToScalar(returnValue));
        return &returnValueXL;
%}
%typemap(rp_tm_xll_rtst) QuantLib::Date & = QuantLib::Date;

%define QL_VEC_RET(T_QL,T_CPP...)
%typemap(rp_tm_xll_rtst) std::vector<T_QL> %{
        std::vector<T_CPP> returnValVec = QuantLibAddin::libraryToVector(returnValue);
        static OPER xRet;
        reposit::vectorToOper(returnValVec, xRet);
        return &xRet;
%}
%typemap(rp_tm_xll_rtst) std::vector<T_QL> & = std::vector<T_QL>;
%enddef

QL_VEC_RET(QuantLib::Date, long)
QL_VEC_RET(QuantLib::Period, std::string)

// FIXME QuantLib::Size=std::size_t, this typemap could be moved into the reposit swig module
%typemap(rp_tm_xll_rtst) std::vector<QuantLib::Size> %{
        std::vector<long> returnValVec = QuantLibAddin::convertVector<QuantLib::Size, long>(returnValue);
        static OPER xRet;
        reposit::vectorToOper(returnValVec, xRet);
        return &xRet;
%}
%typemap(rp_tm_xll_rtst) const std::vector<QuantLib::Size>& %{
        std::vector<long> returnValVec = QuantLibAddin::convertVector<QuantLib::Size, long>(returnValue);
        static OPER xRet;
        reposit::vectorToOper(returnValVec, xRet);
        return &xRet;
%}

// rp_tm_xll_cdrt - code to register the return type with Excel

%typemap(rp_tm_xll_cdrt) QuantLib::Date "N";
%typemap(rp_tm_xll_cdrt) QuantLib::Date & "N";
%typemap(rp_tm_xll_cdrt) QuantLib::Disposable< QuantLib::Matrix > "P";
%typemap(rp_tm_xll_cdrt) QuantLib::Array & "P";
%typemap(rp_tm_xll_cdrt) QuantLib::Matrix "P";
%typemap(rp_tm_xll_cdrt) QuantLib::Matrix & "P";
%typemap(rp_tm_xll_cdrt) QuantLib::InterestRate "E";

// rp_tm_xll_code - code to register the parameter with Excel

%typemap(rp_tm_xll_code) QuantLib::InterestRate & "E";
%typemap(rp_tm_xll_code) QuantLib::Date "P";
%typemap(rp_tm_xll_code) QuantLib::Date & "P";
%typemap(rp_tm_xll_code) QuantLib::Bond & "C";
%typemap(rp_tm_xll_code) QuantLib::Matrix & "K";
%typemap(rp_tm_xll_code) QuantLib::YieldTermStructure & "P";
%typemap(rp_tm_xll_code) boost::shared_ptr<QuantLibAddin::RateHelper> & "C";

%typemap(rp_tm_xll_code) std::vector<QuantLib::Date> "P";
%typemap(rp_tm_xll_code) std::vector<QuantLib::Date> & "P";
%typemap(rp_tm_xll_code) std::vector<QuantLib::Period> "P";
%typemap(rp_tm_xll_code) std::vector<QuantLib::Period> & "P";
%typemap(rp_tm_xll_code) std::vector<QuantLib::TimeSeries<QuantLib::Real > > "P";
%typemap(rp_tm_xll_code) QuantLib::Handle<QuantLib::Quote> "P";
%typemap(rp_tm_xll_code) std::vector<QuantLib::Handle<QuantLib::Quote> > & "P";
%typemap(rp_tm_xll_code) std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > > & "P";

// rp_tm_xll_loop - arguments to boost::bind object for a looping function (F/M)

%typemap(rp_tm_xll_loop) QuantLib::Date & "$1_name_cnv";
%typemap(rp_tm_xll_loop) QuantLib::Period & "$1_name_cnv";
