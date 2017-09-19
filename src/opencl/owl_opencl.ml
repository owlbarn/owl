(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Ctypes

open Owl_opencl_utils

open Owl_opencl_generated

module CI = Cstubs_internals


(** platform definition *)
module Platform = struct

  type info = {
    profile    : string;
    version    : string;
    name       : string;
    vendor     : string;
    extensions : string;
  }


  let get_platforms () =
    let _n = allocate uint32_t uint32_0 in
    clGetPlatformIDs uint32_0 cl_platform_id_ptr_null _n |> cl_check_err;
    let n = Unsigned.UInt32.to_int !@_n in
    let _platforms = allocate_n cl_platform_id n in
    clGetPlatformIDs !@_n _platforms magic_null |> cl_check_err;
    Array.init n (fun i -> !@(_platforms +@ i))


  let get_platform_info plf_id param_name =
    let param_name = Unsigned.UInt32.of_int param_name in
    let param_value_size_ret = allocate size_t size_0 in
    clGetPlatformInfo plf_id param_name size_0 null param_value_size_ret |> cl_check_err;

    let _param_value_size = Unsigned.Size_t.to_int !@param_value_size_ret in
    let param_value = allocate_n char ~count:_param_value_size |> Obj.magic in
    clGetPlatformInfo plf_id param_name !@param_value_size_ret param_value magic_null |> cl_check_err;
    (* null terminated string, so minus 1 *)
    Ctypes.string_from_ptr param_value (_param_value_size - 1)


  let get_info plf_id = {
    profile    = get_platform_info plf_id cl_PLATFORM_PROFILE;
    version    = get_platform_info plf_id cl_PLATFORM_VERSION;
    name       = get_platform_info plf_id cl_PLATFORM_NAME;
    vendor     = get_platform_info plf_id cl_PLATFORM_VENDOR;
    extensions = get_platform_info plf_id cl_PLATFORM_EXTENSIONS;
  }


  let to_string x = ""


end



(** device definition *)
module Device = struct

  type info = {
    name                  : string;
    profile               : string;
    vendor                : string;
    version               : string;
    driver_version        : string;
    opencl_c_version      : string;
    build_in_kernels      : string;
    typ                   : int;
    address_bits          : int;
    available             : bool;
    compiler_available    : bool;
    linker_available      : bool;
    global_mem_cache_size : int;
    global_mem_size       : int;
    max_clock_frequency   : int;
    max_compute_units     : int;
    max_parameter_size    : int;
    max_samplers          : int;
    reference_count       : int;
    extensions            : string;
    parent_device         : cl_device_id;
    platform              : cl_platform_id;
  }


  let get_devices plf_id =
    let dev_typ = Unsigned.UInt64.of_int cl_DEVICE_TYPE_ALL in
    let _num_devices = allocate uint32_t uint32_0 in
    clGetDeviceIDs plf_id dev_typ uint32_0 cl_device_id_ptr_null _num_devices |> cl_check_err;

    let num_devices = Unsigned.UInt32.to_int !@_num_devices in
    let _devices = allocate_n cl_device_id num_devices in
    clGetDeviceIDs plf_id dev_typ !@_num_devices _devices magic_null |> cl_check_err;
    Array.init num_devices (fun i -> !@(_devices +@ i))


  let get_device_info dev_id param_name =
    let param_name = Unsigned.UInt32.of_int param_name in
    let param_value_size_ret = allocate size_t size_0 in
    clGetDeviceInfo dev_id param_name size_0 null param_value_size_ret |> cl_check_err;

    let _param_value_size = Unsigned.Size_t.to_int !@param_value_size_ret in
    let param_value = allocate_n char ~count:_param_value_size |> Obj.magic in
    clGetDeviceInfo dev_id param_name !@param_value_size_ret param_value magic_null |> cl_check_err;
    param_value, _param_value_size


  let get_info dev_id = {
      name                  = ( let p, l = get_device_info dev_id cl_DEVICE_NAME in string_from_ptr p (l - 1) );
      profile               = ( let p, l = get_device_info dev_id cl_DEVICE_PROFILE in string_from_ptr p (l - 1) );
      vendor                = ( let p, l = get_device_info dev_id cl_DEVICE_VENDOR in string_from_ptr p (l - 1) );
      version               = ( let p, l = get_device_info dev_id cl_DEVICE_VERSION in string_from_ptr p (l - 1) );
      driver_version        = ( let p, l = get_device_info dev_id cl_DRIVER_VERSION in string_from_ptr p (l - 1) );
      opencl_c_version      = ( let p, l = get_device_info dev_id cl_DEVICE_OPENCL_C_VERSION in string_from_ptr p (l - 1) );
      build_in_kernels      = ( let p, l = get_device_info dev_id cl_DEVICE_BUILT_IN_KERNELS in string_from_ptr p (l - 1) );
      typ                   = ( let p, l = get_device_info dev_id cl_DEVICE_TYPE in !@(char_ptr_to_uint32_ptr p) |> Unsigned.UInt32.to_int );
      address_bits          = ( let p, l = get_device_info dev_id cl_DEVICE_ADDRESS_BITS in !@(char_ptr_to_uint32_ptr p) |> Unsigned.UInt32.to_int );
      available             = ( let p, l = get_device_info dev_id cl_DEVICE_AVAILABLE in !@(char_ptr_to_uint32_ptr p) |> Unsigned.UInt32.to_int |> ( = ) 1);
      compiler_available    = ( let p, l = get_device_info dev_id cl_DEVICE_COMPILER_AVAILABLE in !@(char_ptr_to_uint32_ptr p) |> Unsigned.UInt32.to_int |> ( = ) 1);
      linker_available      = ( let p, l = get_device_info dev_id cl_DEVICE_LINKER_AVAILABLE in !@(char_ptr_to_uint32_ptr p) |> Unsigned.UInt32.to_int |> ( = ) 1);
      global_mem_cache_size = ( let p, l = get_device_info dev_id cl_DEVICE_GLOBAL_MEM_CACHE_SIZE in !@(char_ptr_to_ulong_ptr p) |> Unsigned.ULong.to_int);
      global_mem_size       = ( let p, l = get_device_info dev_id cl_DEVICE_GLOBAL_MEM_SIZE in !@(char_ptr_to_ulong_ptr p) |> Unsigned.ULong.to_int);
      max_clock_frequency   = ( let p, l = get_device_info dev_id cl_DEVICE_MAX_CLOCK_FREQUENCY in !@(char_ptr_to_uint32_ptr p) |> Unsigned.UInt32.to_int );
      max_compute_units     = ( let p, l = get_device_info dev_id cl_DEVICE_MAX_COMPUTE_UNITS in !@(char_ptr_to_uint32_ptr p) |> Unsigned.UInt32.to_int );
      max_parameter_size    = ( let p, l = get_device_info dev_id cl_DEVICE_MAX_PARAMETER_SIZE in !@(char_ptr_to_uint32_ptr p) |> Unsigned.UInt32.to_int );
      max_samplers          = ( let p, l = get_device_info dev_id cl_DEVICE_MAX_SAMPLERS in !@(char_ptr_to_uint32_ptr p) |> Unsigned.UInt32.to_int );
      reference_count       = ( let p, l = get_device_info dev_id cl_DEVICE_REFERENCE_COUNT in !@(char_ptr_to_uint32_ptr p) |> Unsigned.UInt32.to_int );
      extensions            = ( let p, l = get_device_info dev_id cl_DEVICE_EXTENSIONS in string_from_ptr p (l - 1) );
      parent_device         = ( let p, l = get_device_info dev_id cl_DEVICE_PARENT_DEVICE in !@(char_ptr_to_cl_device_id_ptr p) );
      platform              = ( let p, l = get_device_info dev_id cl_DEVICE_PLATFORM in !@(char_ptr_to_cl_platform_id_ptr p) );
  }


  let to_string x = ""


end



(** context definition *)
module Context = struct

  type info = {
    reference_count : int;
    num_devices     : int;
    devices         : cl_device_id array;
  }


  let get_context_info ctx param_name =
    let param_name = Unsigned.UInt32.of_int param_name in
    let param_value_size_ret = allocate size_t size_0 in
    clGetContextInfo ctx param_name size_0 null param_value_size_ret |> cl_check_err;

    let _param_value_size = Unsigned.Size_t.to_int !@param_value_size_ret in
    let param_value = allocate_n char ~count:_param_value_size |> Obj.magic in
    clGetContextInfo ctx param_name !@param_value_size_ret param_value magic_null |> cl_check_err;
    param_value, _param_value_size


  let get_info ctx =
    let reference_count = ( let p, l = get_context_info ctx cl_CONTEXT_REFERENCE_COUNT in !@(char_ptr_to_uint32_ptr p) |> Unsigned.UInt32.to_int ) in
    let num_devices     = ( let p, l = get_context_info ctx cl_CONTEXT_NUM_DEVICES in !@(char_ptr_to_uint32_ptr p) |> Unsigned.UInt32.to_int ) in
    let devices         = ( let p, l = get_context_info ctx cl_CONTEXT_DEVICES in let _devices = char_ptr_to_cl_device_id_ptr p in Array.init num_devices (fun i -> !@(_devices +@ i)) ) in
    {
      reference_count;
      num_devices = num_devices;
      devices = devices;
    }


  let retain ctx = clRetainContext ctx |> cl_check_err


  let release ctx = clReleaseContext ctx |> cl_check_err


  let create ?(properties=[||]) devices =
    let _properties = allocate_n intptr_t ~count:3 in
    let l = Platform.get_platforms () in
    (_properties +@ 0) <-@ Intptr.of_int cl_CONTEXT_PLATFORM;
    (_properties +@ 1) <-@ cl_platform_id_to_intptr l.(0);
    (_properties +@ 2) <-@ intptr_0;

    let num_devices = Array.length devices in
    let _devices = allocate_n cl_device_id ~count:num_devices in
    Array.iteri (fun i d -> (_devices +@ i) <-@ d) devices;
    let _num_devices = Unsigned.UInt32.of_int num_devices in
    let err_ret = allocate int32_t 0l in
    let ctx = clCreateContext _properties _num_devices _devices magic_null magic_null err_ret in
    cl_check_err !@err_ret;
    ctx


  let create_from_type () = ()


  let to_string x = ""


end



(** kernel definition *)
module Kernel = struct

end



(** program definition *)
module Program = struct


  let create_with_source ctx str =
    let str_num = Array.length str in
    let _str = allocate_n (ptr char) ~count:str_num in
    (* optimise: more efficient way? *)
    Array.iteri (fun i s ->
      let sl = String.length s in
      let _s = allocate_n char ~count:(sl + 1) in
      String.iteri (fun j c -> (_s +@ j) <-@ c) s;
      (_s +@ sl) <-@ '\000';
      (_str +@ i) <-@ _s;
    ) str;

    let err_ret = allocate int32_t 0l in
    let str_num = Unsigned.UInt32.of_int str_num in
    let program = clCreateProgramWithSource ctx str_num _str magic_null err_ret in
    cl_check_err !@err_ret;
    program


  let create_with_binary = ()


  let to_string = ""


end



(** event definition *)
module Event = struct

end



(** command queue definition *)
module CommandQueue = struct

end



(** memory object definition *)
module MemoryObject = struct

end



(** buffer definition *)
module Buffer = struct

end



(** shared virtual memroy definition, required opencl 2.0 *)
module SVM = struct

end



(* ends here *)
