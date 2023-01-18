%lang starknet 

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.math import assert_nn, assert_le
from  starkware.cairo.common.pow import pow
from ./src/interfaces/ICoraPricer.cairo import ICoraPricer


const A_LOWER_BOUND = 0;
const A_UPPER_BOUND = 10e18;
const B_LOWER_BOUND = 0;
const B_UPPER_BOUND = 20e18;
const C_LOWER_BOUND = 0;
const C_UPPER_BOUND = 1000e18;
const D_LOWER_BOUND = 0;
const D_UPPER_BOUND = 20e18;
const UTIL_LOWER_BOUND = 0;
const UTIL_UPPER_BOUND = 1e18;


struct Curve{
    //estos int 256 vienen de PRBmathSD, existe en cairo?????
    //how to define curve paramters are signet 59x18bit fix point numbers
    a_59x18 : int256,
    b_59x18 : int256,
    c_59x18 : int256,
    d_59x18 : int256,
    max_util_59x18 : int256,
}

//Cairo doesn't have enums, so we use an struct as an enum
struct directionEnum{
    Bear : felt, //directionEnum.Bear == 0
    Bull : felt, //directionEnum.Bull== 1
    Full : felt, //directionEnum.Full == 2
}

struct trainingParameters{
    startDateTimestamp : uint256,
    endDateTimestamp : uint256,
    strikePercentage : uint256,
    expirationDays : uint256,
    trainingLabel : directionEnum,
}

//contructor to initialize curve, training parameters and message sender 
//message sender is equal to contract owner?
//Cual es el analogo de message sender de solidity en cairo
@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}
    (_curve :  Curve, _trainingParameters : trainingParameters, owner_address : felt){

    //Need to define a storage var to save this values?????  AL PARECER SI
    
    
}



@view 
func _hyperbolicCurve{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}
    (_x_59x18 : int256) -> (output59x18 : int256){

    //In this point, we do not check that cirve is valid, but only valid curves can be added to registry

    //assert_le(a,b) -> verify that a<=b
    // Verify that _x_59x18 >= UTIL_LOWER_BOUND
    assert_le(UTIL_LOWER_BOUND, _x_59x18);

    // Verify that _x_59x18 <= UTIL_UPPER_BOUND
    assert_le(_x_59x18, UTIL_UPPER_BOUND);

    let coshPart : int256 = cosHyperbolic(curve.b_59x18 * pow(_x_59x18,curve.c_59x18));

    let output59x18 : int256 = curve.a_59x18 * _x_59x18 * coshPart + curve.d_59x18; // PARA ACCEDER A ESTOS VALORES DEBERIA 
                                                                                    // USAR STORAGEVAR.READ();

    return output59x18;
}


@view
func cosHyperbolic{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}
    (_input59x18 : int256) -> (output59x18 : int256){

    // The maximum input we need to support when called by hyperbolicCurve is `b*x^c`
    // We know that |x| <= 1, so the max input we must support is B_UPPER_BOUND

    //Verify that cosh input >= 0
    assert_nn(_input59x18); 

    //Verify that cosh input <= B_UPPER_BOUND
    assert_le(_input59x18, B_UPPER_BOUND); 

    //Local variable to calculate cosh argument
    let value : int256;
    //using hints to calculate cos h
    %{
        import math
        ids.value = math.cosh(ids._input59x18)
    %}
    return (output59x18 = value);
}