// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Test {
    function test(uint testNum) external pure returns(uint data) {

        assembly {
            let _num := 4
            let _fmp := mload(0x40)
            //mstore(0x40, 0x90)
        }
        uint8[3] memory items = [1,2,3];

        assembly {
            data := mload(add(0x90, 0x20)) 
            // value from array is returned
            // 0x20 is 32 bytes length to skip 1st element and return the second
        }
        //return testNum;
    }

    function test2() external pure returns(uint data) {

        assembly {
            let fmp := mload(0x40)
            //  hello
            mstore(add(fmp, 0x00), 0x68656C6C6F)
            data := mload(add(fmp, 0x00))
        }
    }

    function test3() external pure returns(uint data) {

        assembly {
            mstore(0x40, 0xd2)  // stored with offset
        }
        uint8[3] memory items = [1,2,3];

        assembly {
            data := mload(add(0x90, 0x20))
        }
    }

}