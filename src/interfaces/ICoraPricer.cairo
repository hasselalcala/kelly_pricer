%lang starknet 

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from src.contracts.constants import PricerParams, Curve, directionEnum, trainingParameters

@contract_interface
namespace ICoraPricer {

    //Parameter of this function is the struct, I am assuming that the value that return is the BorrowingFee
    func calculateBorrowingFee(_params : PricerParams) ->(BorrowingFee : Uint256){
    }

    //
    func getPricerName()->(pricerName : felt){
    }
    
}