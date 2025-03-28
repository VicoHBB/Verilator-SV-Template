/**
************************************************************************************************************************
* @file    definitions.svh
* @author  Hugo Becerril
* @email   vhugobeb@gmail.com
* @brief   Definition of the project
************************************************************************************************************************
* @Description
* This is an example of header file for declareate datatypes and macros
*
************************************************************************************************************************
*/

/**********************************************************************************************************************/
/*                          START OF HEADER                                                                           */
/**********************************************************************************************************************/
`ifndef DEFINITIONS_SVH_
`define DEFINITIONS_SVH_

/**********************************************************************************************************************/
/*                          START OF DEFINES                                                                          */
/**********************************************************************************************************************/
/**********************************************************************************************************************/
/*                          END OF DEFINES                                                                            */
/**********************************************************************************************************************/

/**********************************************************************************************************************/
/*                           START OF MACROS                                                                          */
/**********************************************************************************************************************/
/**********************************************************************************************************************/
/*                           END OF MACROS                                                                            */
/**********************************************************************************************************************/

/**********************************************************************************************************************/
/*                          START OF DATATYPES                                                                        */
/**********************************************************************************************************************/
/*
* @brief:        Bus_t structure definition
* @description:  This contains a Tag and Data value
*/
typedef struct packed {
    logic [ 3 : 0 ] Tag;
    logic [ 7 : 0 ] Data;
} bus_t;
/**********************************************************************************************************************/
/*                          END OF DATATYPES                                                                          */
/**********************************************************************************************************************/

`endif    /* DEFINITIONS_SVH_ */
/**********************************************************************************************************************/
/*                          END OF HEADER                                                                             */
/**********************************************************************************************************************/
