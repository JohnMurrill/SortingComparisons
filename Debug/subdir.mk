################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../qsort.cpp 

C_SRCS += \
../cuda_bitonic.c 

CU_SRCS += \
../cuda_bitonic.cu 

CU_DEPS += \
./cuda_bitonic.d 

OBJS += \
./cuda_bitonic.o \
./qsort.o 

C_DEPS += \
./cuda_bitonic.d 

CPP_DEPS += \
./qsort.d 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.c
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-5.5/bin/nvcc -G -g -O0 -gencode arch=compute_30,code=sm_30 -odir "" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-5.5/bin/nvcc -G -g -O0 --compile  -x c -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

%.o: ../%.cu
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-5.5/bin/nvcc -G -g -O0 -gencode arch=compute_30,code=sm_30 -odir "" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-5.5/bin/nvcc --compile -G -O0 -g -gencode arch=compute_30,code=compute_30 -gencode arch=compute_30,code=sm_30  -x cu -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

%.o: ../%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-5.5/bin/nvcc -G -g -O0 -gencode arch=compute_30,code=sm_30 -odir "" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-5.5/bin/nvcc -G -g -O0 --compile  -x c++ -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


