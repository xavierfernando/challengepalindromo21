/* RawToCompressed.cpp
 * 
 * Author           : Alexander J. Yee
 * Date Created     : 02/10/2018
 * Last Modified    : 02/10/2018
 * 
 */

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//  Dependencies
#include "PublicLibs/SystemLibs/ProcessorCapability/ProcessorCapability.h"
////////////////////////////////////////////////////////////////////////////////
#if 0
#elif defined YMP_Arch_2017_x64_Skylake
#include "Kernels/WordToRaw_x64_AVX512-BW.ipp"
#elif defined YMP_Arch_2013_x64_Haswell
#include "Kernels/WordToRaw_x64_AVX2.ipp"
#elif defined YMP_Arch_2007_x64_Penryn
#include "Kernels/WordToRaw_x64_SSE41.ipp"
#elif defined YMP_Arch_2000_x86
#include "Kernels/WordToRaw_LittleEndian.ipp"
#else
#error "No generic implementation available."
#endif
////////////////////////////////////////////////////////////////////////////////
namespace DigitViewer2{
namespace WordToRaw{
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}
}
