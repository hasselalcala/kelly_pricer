%lang starknet 

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.math import assert_nn, assert_le
from starkware.cairo.common.pow import pow
from src.interfaces.ICoraPricer import ICoraPricer
from lib.cairo_math_64x61.contracts.cairo_math_64x61.hyp64x61 import Hyp64x61
from src.contracts.constants import PricerParams, Curve, directionEnum, trainingParameters, A_LOWER_BOUND, A_UPPER_BOUND, B_LOWER_BOUND , B_UPPER_BOUND, C_LOWER_BOUND, C_UPPER_BOUND, D_LOWER_BOUND, D_UPPER_BOUND, UTIL_LOWER_BOUND, UTIL_UPPER_BOUND

//contructor to initialize curve, training parameters and message sender 
//message sender is equal to contract owner?
//Cual es el analogo de message sender de solidity en cairo
@storage_var
func owner() -> (owner_address: felt) {
}

@storage_var
func Curve_created(_curve : Curve) -> (res:felt) {
}

@storage_var
func trainingParameters_created(_trainingParameters : trainingParameters) -> (res: felt) {
}



@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(_curve :  Curve, _trainingParameters : trainingParameters, owner_address : felt){

    Curve_created.write(_curve, 1);
    trainingParameters_created.write(_trainingParameters, 1);
    owner.write(value = owner_address);
    return();
}



// @view 
// func _hyperbolicCurve{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(_x_59x18 : felt) -> (output59x18 : felt){

//     //In this point, we do not check that cirve is valid, but only valid curves can be added to registry

//     //assert_le(a,b) -> verify that a<=b
//     // Verify that _x_59x18 >= UTIL_LOWER_BOUND
//     assert_le(UTIL_LOWER_BOUND, _x_59x18);

//     // Verify that _x_59x18 <= UTIL_UPPER_BOUND
//     assert_le(_x_59x18, UTIL_UPPER_BOUND);

//     let coshPart = cosHyperbolic(Curve.b_59x18 * pow(_x_59x18,Curve.c_59x18));

//     let output59x18 = Curve.a_59x18 * _x_59x18 * coshPart + Curve.d_59x18; 
                                                                                    

//     return output59x18;
// }


@view
func cosHyperbolic{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(_input59x18 : felt) -> (output59x18 : felt){

    // The maximum input we need to support when called by hyperbolicCurve is `b*x^c`
    // We know that |x| <= 1, so the max input we must support is B_UPPER_BOUND

    //Verify that cosh input >= 0
    assert_nn(_input59x18); 

    //Verify that cosh input <= B_UPPER_BOUND
    assert_le(_input59x18, B_UPPER_BOUND); 

    //Local variable to calculate cosh argument
    let value = Hyp64x61.cosh(_input59x18);

    return (output59x18 = value);
}