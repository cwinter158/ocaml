(***********************************************************************)
(*                                                                     *)
(*                                OCaml                                *)
(*                                                                     *)
(*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 1996 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the GNU Library General Public License, with    *)
(*  the special exception on linking described in file ../LICENSE.     *)
(*                                                                     *)
(***********************************************************************)

(* $Id: lexing.mli 12959 2012-09-27 13:12:51Z maranget $ *)

(** The run-time library for lexers generated by [ocamllex]. *)

(** {6 Positions} *)

type position = {
  pos_fname : string;
  pos_lnum : int;
  pos_bol : int;
  pos_cnum : int;
}
(** A value of type [position] describes a point in a source file.
   [pos_fname] is the file name; [pos_lnum] is the line number;
   [pos_bol] is the offset of the beginning of the line (number
   of characters between the beginning of the lexbuf and the beginning
   of the line); [pos_cnum] is the offset of the position (number of
   characters between the beginning of the lexbuf and the position).
   The difference between [pos_cnum] and [pos_bol] is the character
   offset within the line (i.e. the column number, assuming each
   character is one column wide).

   See the documentation of type [lexbuf] for information about
   how the lexing engine will manage positions.
 *)

val dummy_pos : position;;
(** A value of type [position], guaranteed to be different from any
   valid position.
 *)


(** {6 Lexer buffers} *)


type lexbuf =
  { refill_buff : lexbuf -> unit;
    mutable lex_buffer : string;
    mutable lex_buffer_len : int;
    mutable lex_abs_pos : int;
    mutable lex_start_pos : int;
    mutable lex_curr_pos : int;
    mutable lex_last_pos : int;
    mutable lex_last_action : int;
    mutable lex_eof_reached : bool;
    mutable lex_mem : int array;
    mutable lex_start_p : position;
    mutable lex_curr_p : position;
  }
(** The type of lexer buffers. A lexer buffer is the argument passed
   to the scanning functions defined by the generated scanners.
   The lexer buffer holds the current state of the scanner, plus
   a function to refill the buffer from the input.

   At each token, the lexing engine will copy [lex_curr_p] to
   [lex_start_p], then change the [pos_cnum] field
   of [lex_curr_p] by updating it with the number of characters read
   since the start of the [lexbuf].  The other fields are left
   unchanged by the lexing engine.  In order to keep them
   accurate, they must be initialised before the first use of the
   lexbuf, and updated by the relevant lexer actions (i.e. at each
   end of line -- see also [new_line]).
 *)

val from_channel : in_channel -> lexbuf
(** Create a lexer buffer on the given input channel.
   [Lexing.from_channel inchan] returns a lexer buffer which reads
   from the input channel [inchan], at the current reading position. *)

val from_string : string -> lexbuf
(** Create a lexer buffer which reads from
   the given string. Reading starts from the first character in
   the string. An end-of-input condition is generated when the
   end of the string is reached. *)

val from_function : (string -> int -> int) -> lexbuf
(** Create a lexer buffer with the given function as its reading method.
   When the scanner needs more characters, it will call the given
   function, giving it a character string [s] and a character
   count [n]. The function should put [n] characters or less in [s],
   starting at character number 0, and return the number of characters
   provided. A return value of 0 means end of input. *)


(** {6 Functions for lexer semantic actions} *)


(** The following functions can be called from the semantic actions
   of lexer definitions (the ML code enclosed in braces that
   computes the value returned by lexing functions). They give
   access to the character string matched by the regular expression
   associated with the semantic action. These functions must be
   applied to the argument [lexbuf], which, in the code generated by
   [ocamllex], is bound to the lexer buffer passed to the parsing
   function. *)

val lexeme : lexbuf -> string
(** [Lexing.lexeme lexbuf] returns the string matched by
           the regular expression. *)

val lexeme_char : lexbuf -> int -> char
(** [Lexing.lexeme_char lexbuf i] returns character number [i] in
   the matched string. *)

val lexeme_start : lexbuf -> int
(** [Lexing.lexeme_start lexbuf] returns the offset in the
   input stream of the first character of the matched string.
   The first character of the stream has offset 0. *)

val lexeme_end : lexbuf -> int
(** [Lexing.lexeme_end lexbuf] returns the offset in the input stream
   of the character following the last character of the matched
   string. The first character of the stream has offset 0. *)

val lexeme_start_p : lexbuf -> position
(** Like [lexeme_start], but return a complete [position] instead
    of an offset. *)

val lexeme_end_p : lexbuf -> position
(** Like [lexeme_end], but return a complete [position] instead
    of an offset. *)

val new_line : lexbuf -> unit
(** Update the [lex_curr_p] field of the lexbuf to reflect the start
    of a new line.  You can call this function in the semantic action
    of the rule that matches the end-of-line character.
    @since 3.11.0
*)

(** {6 Miscellaneous functions} *)

val flush_input : lexbuf -> unit
(** Discard the contents of the buffer and reset the current
    position to 0.  The next use of the lexbuf will trigger a
    refill. *)

(**/**)

(** {6  } *)

(** The following definitions are used by the generated scanners only.
   They are not intended to be used directly by user programs. *)

val sub_lexeme : lexbuf -> int -> int -> string
val sub_lexeme_opt : lexbuf -> int -> int -> string option
val sub_lexeme_char : lexbuf -> int -> char
val sub_lexeme_char_opt : lexbuf -> int -> char option

type lex_tables =
  { lex_base : string;
    lex_backtrk : string;
    lex_default : string;
    lex_trans : string;
    lex_check : string;
    lex_base_code : string;
    lex_backtrk_code : string;
    lex_default_code : string;
    lex_trans_code : string;
    lex_check_code : string;
    lex_code: string;}

val engine : lex_tables -> int -> lexbuf -> int
val new_engine : lex_tables -> int -> lexbuf -> int
