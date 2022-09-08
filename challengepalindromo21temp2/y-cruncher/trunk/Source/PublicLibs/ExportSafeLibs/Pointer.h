/* Pointer.h
 * 
 * Author           : Alexander J. Yee
 * Date Created     : 05/31/2015
 * Last Modified    : 05/31/2015
 * 
 */

#pragma once
#ifndef ymp_ExportSafeLibs_Pointer_H
#define ymp_ExportSafeLibs_Pointer_H
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
namespace ymp{
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
template <typename type>
static void local_ptr_deleter(type* ptr){
    delete ptr;
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
template <typename type>
class dll_uptr{
    type* m_ptr;
    void (*m_deleter)(type*);

public:
    //  Rule of 5
    dll_uptr(const dll_uptr&) = delete;
    void operator=(const dll_uptr&) = delete;
    dll_uptr(dll_uptr&& x)
        : m_ptr(x.m_ptr)
        , m_deleter(x.m_deleter)
    {
        x.m_ptr = nullptr;
    }
    void operator=(dll_uptr&& x){
        clear();
        m_ptr = x.m_ptr;
        m_deleter = x.m_deleter;
        x.m_ptr = nullptr;
    }
    ~dll_uptr(){ clear(); }

public:
    //  Constructors
    dll_uptr() : m_ptr(nullptr) {}
    dll_uptr(type* ptr, void (*deleter)(type*) = &local_ptr_deleter)
        : m_ptr(ptr)
        , m_deleter(deleter)
    {}
    void clear(){
        if (m_ptr != nullptr){
            m_deleter(m_ptr);
        }
    }
    void reset(type* ptr, void (*deleter)(type*) = &local_ptr_deleter){
        clear();
        m_ptr = ptr;
        m_deleter = deleter;
    }

public:
    //  Getters
    type* get(){
        return m_ptr;
    }
    const type* get() const{
        return m_ptr;
    }
    type* operator->(){
        return m_ptr;
    }
    const type* operator->() const{
        return m_ptr;
    }
    type& operator*(){
        return *m_ptr;
    }
    const type& operator*() const{
        return *m_ptr;
    }
};
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}
#endif
