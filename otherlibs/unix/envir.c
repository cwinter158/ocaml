/***********************************************************************/
/*                                                                     */
/*                                OCaml                                */
/*                                                                     */
/*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         */
/*                                                                     */
/*  Copyright 1996 Institut National de Recherche en Informatique et   */
/*  en Automatique.  All rights reserved.  This file is distributed    */
/*  under the terms of the GNU Library General Public License, with    */
/*  the special exception on linking described in file ../../LICENSE.  */
/*                                                                     */
/***********************************************************************/

/* $Id: envir.c 12858 2012-08-10 14:45:51Z maranget $ */

#include <mlvalues.h>
#include <alloc.h>

#ifndef _WIN32
extern char ** environ;
#endif

CAMLprim value unix_environment(value unit)
{
  if (environ != NULL) {
    return copy_string_array((const char**)environ);
  } else {
    return Atom(0);
  }
}
