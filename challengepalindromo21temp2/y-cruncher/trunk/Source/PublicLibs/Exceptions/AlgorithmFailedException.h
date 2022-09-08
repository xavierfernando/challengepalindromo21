/* AlgorithmFailedException.h
 * 
 * Author           : Alexander J. Yee
 * Date Created     : 04/09/2017
 * Last Modified    : 04/09/2017
 * 
 */

#pragma once
#ifndef ymp_Exceptions_AlgorithmFailedException_H
#define ymp_Exceptions_AlgorithmFailedException_H
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//  Dependencies
#include "StringException.h"
namespace ymp{
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class AlgorithmFailedException : public StringException{
    YMP_EXCEPTION_DECLARATIONS()

public:
    using StringException::StringException;

};
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}
#endif
