/***********************************************************************/
/*                                                                     */
/*                                OCaml                                */
/*                                                                     */
/*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         */
/*                                                                     */
/*  Copyright 1999 Institut National de Recherche en Informatique et   */
/*  en Automatique.  All rights reserved.  This file is distributed    */
/*  under the terms of the GNU Library General Public License, with    */
/*  the special exception on linking described in file ../../LICENSE.  */
/*                                                                     */
/***********************************************************************/

/* $Id: elf.c 12858 2012-08-10 14:45:51Z maranget $ */

#include <stdio.h>

int main(int argc, char ** argv)
{
#ifdef __ELF__
  printf("elf\n");
#else
  printf("aout\n");
#endif
  return 0;
}
