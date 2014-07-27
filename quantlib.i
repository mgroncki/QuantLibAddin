
%typemap(rp_cpp_in) QuantLib::Date const & "const ObjectHandler::property_t&";

%typemap(rp_cpp_cnv) QuantLib::Date const & %{
    QuantLib::Date $1_name_cnv =
        ObjectHandler::convert2<QuantLib::Date, ObjectHandler::property_t>($1_name);
%}

%typemap(rp_cpp_call) QuantLib::Date const & "$1_name_cnv";

%typemap(rp_excel) QuantLib::Date const & "P";

%typemap(rp_excel_in) QuantLib::Date const & "OPER*";

%typemap(rp_excel_cnv) QuantLib::Date const & %{
        QuantLib::Date $1_name_cnv = ObjectHandler::convert2<QuantLib::Date>(
            ObjectHandler::ConvertOper(*$1_name), "$1_name", QuantLib::Date());
%} 

%typemap(rp_excel_call) QuantLib::Date const & "$1_name_cnv";

//%module QuantLibAddin
%module(
    rp_obj_dir="qlo",
    rp_xl_dir="../QuantLibXL2"
    ) QuantLibAddin

%include date.i
%include quote.i
%include utilities.i
%include settings.i

