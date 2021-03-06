
%group(marketmodelevolvers);

%insert(obj_hpp) %{
#include <ql/types.hpp>

namespace QuantLib {
    class MarketModelEvolver;
    class BrownianGeneratorFactory;
    class MarketModel;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_marketmodels.hpp>
#include <qlo/objects/obj_browniangenerators.hpp>

#include <ql/models/marketmodels/evolvers/lognormalfwdratepc.hpp>
#include <ql/models/marketmodels/evolvers/lognormalfwdrateipc.hpp>
#include <ql/models/marketmodels/evolvers/normalfwdratepc.hpp>
%}

namespace QuantLib {

    class MarketModelEvolver {
        public:
            //! Start a new path for the MarketModelEvolver object.
            Real startNewPath();

            //! Advance a single step in the current path for the MarketModelEvolver object.
            Real advanceStep();

            //! Returns the current step index in the current path for the MarketModelEvolver object.
            Size currentStep() const;

            //! Returns the numeraries for the MarketModelEvolver object.
            const std::vector<Size>& numeraires() const;
    };

    class LogNormalFwdRatePc : public MarketModelEvolver {
        public:
            %rename2(LogNormalFwdRatePc, ForwardRatePc);
            LogNormalFwdRatePc(
                const boost::shared_ptr<MarketModel>& MarketModel,          //!< MarketModel object ID.
                const BrownianGeneratorFactory& BrownianGeneratorFactory,   //!< Brownian generator factory.
                const std::vector<Size>& Numeraires                         //!< Numeraire vector.
            );
    };

    class LogNormalFwdRateIpc : public MarketModelEvolver {
        public:
            %rename2(LogNormalFwdRateIpc, ForwardRateIpc);
            LogNormalFwdRateIpc(
                const boost::shared_ptr<MarketModel>& MarketModel,          //!< MarketModel object ID.
                const BrownianGeneratorFactory& BrownianGeneratorFactory,   //!< Brownian generator factory.
                const std::vector<Size>& Numeraires                         //!< Numeraire vector.
            );
    };

    class NormalFwdRatePc : public MarketModelEvolver {
        public:
            %rename2(NormalFwdRatePc, ForwardRateNormalPc);
            NormalFwdRatePc(
                const boost::shared_ptr<MarketModel>& MarketModel,          //!< MarketModel object ID.
                const BrownianGeneratorFactory& BrownianGeneratorFactory,   //!< Brownian generator factory.
                const std::vector<Size>& Numeraires                         //!< Numeraire vector.
            );
    };
}

