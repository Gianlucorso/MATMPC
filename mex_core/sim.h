#ifndef SIM_H_
#define SIM_H_

#include "mex.h"

typedef struct{
    double h;
    size_t nx;
    size_t nu;
    size_t num_stages;
    size_t num_steps;
    bool forw_sens;
}sim_opts;

typedef struct{
    double *x;
    double *u;
    double *p;
}sim_in;

typedef struct{
    double *xn;
    double *Sx;
    double *Su;
}sim_out;

sim_opts* sim_opts_create(const mxArray *mem);
sim_in* sim_in_create(sim_opts *opts);
sim_out* sim_out_create(sim_opts *opts);

void sim_opts_free(sim_opts *opts);
void sim_in_free(sim_in *in);
void sim_out_free(sim_out *out);

#endif