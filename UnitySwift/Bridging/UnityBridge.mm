

/////////////Test////////////
//Method 2 -- Success
#include "RegisterMonoModules.h"
#include "RegisterFeatures.h"
#include <csignal>

// Hack to work around iOS SDK 4.3 linker problem
// we need at least one __TEXT, __const section entry in main application .o files
// to get this section emitted at right time and so avoid LC_ENCRYPTION_INFO size miscalculation

static const int constsection = 0;
void UnityInitTrampoline();

// WARNING: this MUST be c decl (NSString ctor will be called after +load, so we cant really change its value)

extern "C" void unity_init(int argc, char* argv[])

{
    @autoreleasepool
        {
            UnityInitTrampoline();
            UnityInitRuntime(argc, argv);
    
            RegisterMonoModules();
            NSLog(@"-> registered mono modules %p\n", &constsection);
            RegisterFeatures();
    
            // iOS terminates open sockets when an application enters background mode.
            // The next write to any of such socket causes SIGPIPE signal being raised,
            // even if the request has been done from scripting side. This disables the
            // signal and allows Mono to throw a proper C# exception.
            std::signal(SIGPIPE, SIG_IGN);
        
      
    }
    
    return 0;
}

#if TARGET_IPHONE_SIMULATOR && TARGET_TVOS_SIMULATOR

#include <pthread.h>

extern "C" int pthread_cond_init$UNIX2003(pthread_cond_t *cond, const pthread_condattr_t *attr)
{ return pthread_cond_init(cond, attr); }
extern "C" int pthread_cond_destroy$UNIX2003(pthread_cond_t *cond)
{ return pthread_cond_destroy(cond); }
extern "C" int pthread_cond_wait$UNIX2003(pthread_cond_t *cond, pthread_mutex_t *mutex)
{ return pthread_cond_wait(cond, mutex); }
extern "C" int pthread_cond_timedwait$UNIX2003(pthread_cond_t *cond, pthread_mutex_t *mutex,
                                               const struct timespec *abstime)
{ return pthread_cond_timedwait(cond, mutex, abstime); }

#endif // TARGET_IPHONE_SIMULATOR && TARGET_TVOS_SIMULATOR




//extern "C" void UnityPostMessage(NSString* gameObject, NSString* methodName, NSString* message)
//{
//    UnitySendMessage([gameObject UTF8String], [methodName UTF8String], [message UTF8String]);
//}

// The following functions are for demo purpose only.
// You don't need them if your Unity code does not invoke them.
//extern "C" void UnityToggleRotation(bool isOn)
//{
//    NSDictionary* dict = @{ @"isOn": @(isOn) };
//    [[NSNotificationCenter defaultCenter] postNotificationName: @"UnityToggleRotation" object:nil userInfo:dict];
//}
