#ifndef SF_ERROR_H_
#define SF_ERROR_H_

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    SF_ERROR_OK = 0,      /* no error */
    SF_ERROR_SINGULAR,    /* singularity encountered */
    SF_ERROR_UNDERFLOW,   /* floating point underflow */
    SF_ERROR_OVERFLOW,    /* floating point overflow */
    SF_ERROR_SLOW,        /* too many iterations required */
    SF_ERROR_LOSS,        /* loss of precision */
    SF_ERROR_NO_RESULT,   /* no result obtained */
    SF_ERROR_DOMAIN,      /* out of domain */
    SF_ERROR_ARG,         /* invalid input parameter */
    SF_ERROR_OTHER,       /* unclassified error */
    SF_ERROR__LAST
} sf_error_t;

typedef enum {
    SF_ERROR_IGNORE = 0,  /* Ignore errors */
    SF_ERROR_WARN,        /* Warn on errors */
    SF_ERROR_RAISE        /* Raise on errors */
} sf_action_t;

extern const char *sf_error_messages[];
void sf_error(const char *func_name, sf_error_t code, const char *fmt, ...);

#ifdef __cplusplus
}
#endif

#endif /* SF_ERROR_H_ */
