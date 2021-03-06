CC := gcc
CXX := g++
CFLAGS := -Wall -Wextra  -O0
uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
ifeq ($(uname_S),Linux)
	CFLAGS+=-DCORO_ASM
else
	CFLAGS+=-DCORO_UCONTEXT -D_XOPEN_SOURCE
endif

CXXFLAGS := $(CFLAGS) -std=c++11
TEST_OUT := libcoro_test
RM := rm -f

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

LIBCORO_OBJS :=  libcoro.o scheduler.o coro.o


test1:	test1.cpp $(LIBCORO_OBJS)
	$(CXX) $(CXXFLAGS) test1.cpp $(LIBCORO_OBJS) -o test1 -lpthread
	./test1

clean:
	$(RM) *.o test1