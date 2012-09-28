(***********************************************************************)
(*                                                                     *)
(*                                OCaml                                *)
(*                                                                     *)
(*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 1997 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

(* $Id: syntaxerr.mli 12959 2012-09-27 13:12:51Z maranget $ *)

(* Auxiliary type for reporting syntax errors *)

open Format

type error =
    Unclosed of Location.t * string * Location.t * string
  | Applicative_path of Location.t
  | Variable_in_scope of Location.t * string
  | Other of Location.t

exception Error of error
exception Escape_error

val report_error: formatter -> error -> unit
