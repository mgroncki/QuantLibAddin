
%feature("rp:group", "quote");
%feature("rp:include") %{
#include <ql/quotes/simplequote.hpp>
#include <ql/math/comparison.hpp>
%}

namespace QuantLib {
    bool close(double x, double y);
    class SimpleQuote {
      public:
        SimpleQuote(double value = Null<double>());
        double value() const;
    };
}
