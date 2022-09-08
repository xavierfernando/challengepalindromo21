/* Environment_Windows7.ipp
 * 
 * Author           : Alexander J. Yee
 * Date Created     : 01/04/2015
 * Last Modified    : 08/27/2016
 * 
 */

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//  Dependencies
#include <Windows.h>
#include "Environment.h"
namespace ymp{
namespace Environment{
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
upL_t GetLogicalProcessors(){
    upL_t out = GetActiveProcessorCount(ALL_PROCESSOR_GROUPS);
    return out == 0 ? 1 : out;
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}
}
