(***********************************************************************)
(*                                                                     *)
(*                                OCaml                                *)
(*                                                                     *)
(*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 1996 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

(* $Id: emit.mli 12858 2012-08-10 14:45:51Z maranget $ *)

(* Generation of assembly code *)

val fundecl: Linearize.fundecl -> unit
val data: Cmm.data_item list -> unit
val begin_assembly: unit -> unit
val end_assembly: unit -> unit
