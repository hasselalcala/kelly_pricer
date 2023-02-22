from starkware.cairo.common.uint256 import Uint256

const A_LOWER_BOUND = 0;
const A_UPPER_BOUND = 10; // 10 as 64x61 fixed point
const B_LOWER_BOUND = 0;
const B_UPPER_BOUND = 20; // 20 as 64x61 fixed point
const C_LOWER_BOUND = 0;
const C_UPPER_BOUND = 1000; // 1000 as 64x61 fixed point
const D_LOWER_BOUND = 0;
const D_UPPER_BOUND = 20; // 20 as 64x61 fixed point
const UTIL_LOWER_BOUND = 0; // 0%, Also used as a bound for max_util
const UTIL_UPPER_BOUND = 1; // 1 as 64x61 fixed point. Also udes as bound for max_util


struct PricerParams {
    //estos uint256 son de los "normales" 
        orderSize : Uint256,
        underlyingSpotPrice: Uint256,
        time : Uint256,
        strikePrice : Uint256,
        totalPoolDeposits : Uint256,
        totalPoolLockedAmount : Uint256,
}

struct Curve{
    //estos int 256 vienen de PRBmathSD, existe en cairo?????
    //how to define curve paramters are signet 59x18bit fix point numbers
    a_59x18 : felt, //int256
    b_59x18 : felt, //int256
    c_59x18 : felt, //int256
    d_59x18 : felt, //int256
    max_util_59x18 : felt, //int256
}

//Cairo doesn't have enums, so we use an struct as an enum
struct directionEnum{
    Bear : felt, //directionEnum.Bear == 0
    Bull : felt, //directionEnum.Bull== 1
    Full : felt, //directionEnum.Full == 2
}

struct trainingParameters{
    startDateTimestamp : Uint256,
    endDateTimestamp : Uint256,
    strikePercentage : Uint256,
    expirationDays : Uint256,
    trainingLabel : directionEnum,
}
