/* SystemException.h
 * 
 * Author           : Alexander J. Yee
 * Date Created     : 04/09/2017
 * Last Modified    : 04/09/2017
 * 
 */

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//  Dependencies
#include "PublicLibs/ConsoleIO/BasicIO.h"
#include "PublicLibs/ConsoleIO/Label.h"
#include "PublicLibs/ExportSafeLibs/Stream.h"
#include "ExceptionSerialization.h"
#include "SystemException.h"
namespace ymp{
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
YMP_EXCEPTION_DEFINITIONS(SystemException)
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
YM_NO_INLINE SystemException::SystemException(const char* function, const char* message, int code)
    : m_function(function)
    , m_message(message)
    , m_code(code)
{}
YM_NO_INLINE SystemException::SystemException(const char* function, std::string message, int code)
    : m_function(function)
    , m_message(std::move(message))
    , m_code(code)
{}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void SystemException::print() const{
    Console::println("\n", 'R');
    Console::println_labelc("System Exception Encountered", get_typename());
    Console::println();
    if (!m_function.empty()){
        Console::println_labelm("In Function:", m_function);
    }
    Console::println_labelm("Error Code: ", m_code);
    Console::println();
    Console::println(m_message);
    Console::println("\n");
    Console::SetColor('w');
}
SystemException::SystemException(SerializationPassKey key, const char*& stream)
    : Exception(key, stream)
{
    ExceptionTools::parse(stream, m_function);
    ExceptionTools::parse(stream, m_message);
    ExceptionTools::parse(stream, m_code);
}
void SystemException::serialize(std::string& stream) const{
    Exception::serialize(stream);
    ExceptionTools::write(stream, m_function);
    ExceptionTools::write(stream, m_message);
    ExceptionTools::write(stream, m_code);
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}