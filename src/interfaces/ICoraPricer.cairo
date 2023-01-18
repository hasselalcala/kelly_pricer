%lang starknet 

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256

@contract_interface
namespace ICoraPricer {

    struct PricerParams {
    //estos uint256 son de los "normales" 
        orderSize : uint256,
        underlyingSpotPrice: uint256,
        time : uint256,
        strikePrice : uint256,
        totalPoolDeposits : uint256,
        totalPoolLockedAmount : uint256,
    }

    //Parameter of this function is the struct, I am assuming that the value that return is the BorrowingFee
    func calculateBorrowingFee(_params : PricerParams) ->(BorrowingFee : uint256){
    }

    //
    func getPricerName()->(pricerName : string){
    }
    
}