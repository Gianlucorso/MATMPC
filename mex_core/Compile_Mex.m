%% set path for your computer
mex_core_dir = '/home/gianluca/Desktop/ms2019a-gianluca_corsini/Software/MATMPC/mex_core';
cd(mex_core_dir);

%% detect OS type

OS_MAC = 0;
OS_LINUX = 0;
OS_WIN = 0;

if ismac
    OS_MAC = 1;
elseif isunix
    OS_LINUX = 1;
    addpath(genpath('../solver/linux'));
elseif ispc
    OS_WIN = 1;
    addpath(genpath('../solver/win64'));
else
    disp('Platform not supported')
end

%% Configure Compiler

options = '-largeArrayDims';

if OS_WIN
   CC_FLAGS='CXXFLAGS="$CXXFLAGS -Wall"'; % use MinGW not VS studio
end
if OS_LINUX 
   CC_FLAGS = 'GCC="/usr/bin/gcc"';
end

OP_FLAGS='-O';
PRINT_FLAGS='-silent';

LIB1 = '-lmwblas';
LIB2 = '-lmwlapack';

LIB1_PATH = '';
LIB2_PATH = '';

HEAD1_PATH = '';
HEAD2_PATH = '';

%% These functions should be all compiled

mex(options, OP_FLAGS, CC_FLAGS, PRINT_FLAGS, HEAD1_PATH, LIB1_PATH, 'qp_generation.c','casadi_wrapper.c','sim.c','erk.c','irk.c','casadi_src.c','mpc_common.c',LIB1, LIB2);
% 
mex(options, CC_FLAGS, OP_FLAGS, PRINT_FLAGS, 'Condensing.c','mpc_common.c', LIB1);
% 
mex(options, CC_FLAGS, OP_FLAGS, PRINT_FLAGS, 'full2sparse.c','mpc_common.c');
% 
mex(options, CC_FLAGS, OP_FLAGS, PRINT_FLAGS, 'sparse2full.c','mpc_common.c');
% 
mex(options, CC_FLAGS, OP_FLAGS, PRINT_FLAGS, 'partial_condensing_default.c','partial_condensing_routines.c','mpc_common.c', LIB1);
% 
mex(options, OP_FLAGS, CC_FLAGS, PRINT_FLAGS, HEAD1_PATH, LIB1_PATH,'Recover.c', LIB1);
% 
mex(options, OP_FLAGS, CC_FLAGS, PRINT_FLAGS, HEAD1_PATH, LIB1_PATH,'Line_search.c','casadi_wrapper.c','casadi_src.c','sim.c','erk.c','irk.c','mpc_common.c', LIB1, LIB2);
% 
mex(options, OP_FLAGS, CC_FLAGS, PRINT_FLAGS, HEAD1_PATH, LIB1_PATH,'solution_info.c','casadi_wrapper.c','casadi_src.c','sim.c','erk.c','irk.c','mpc_common.c', LIB1, LIB2);

%% Optional functions
% mex(options, CC_FLAGS, OP_FLAGS, PRINT_FLAGS, 'Condensing_mb.c','mpc_common.c', LIB1);

% mex(options, OP_FLAGS, CC_FLAGS, PRINT_FLAGS, HEAD1_PATH, LIB1_PATH, 'qp_generation_ngrid.c','casadi_wrapper.c','sim.c','erk.c','irk.c','casadi_src.c','mpc_common.c',LIB1, LIB2);

% mex(options, OP_FLAGS, CC_FLAGS, PRINT_FLAGS, HEAD1_PATH, LIB1_PATH, 'qp_generation_mb.c','casadi_wrapper.c','sim.c','erk.c','irk.c','casadi_src.c','mpc_common.c',LIB1, LIB2);

% mex(options, OP_FLAGS, CC_FLAGS, PRINT_FLAGS, HEAD1_PATH, LIB1_PATH, 'qp_generation_tac.c','casadi_wrapper.c','casadi_src.c','mpc_common.c',LIB1, LIB2);

% mex(options, OP_FLAGS, CC_FLAGS, PRINT_FLAGS, HEAD1_PATH, LIB1_PATH, 'adaptive_eta.c',LIB1);