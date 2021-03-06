-module(bool).
-export([b_not/1, b_and/2, b_or/2, b_nand/2]).

b_not(false) ->
	true;
b_not(true) ->
	false;
b_not(_) ->
	{error, invalid_object}.

b_and(true, true) ->
	true;
b_and(true, false) ->
	false;
b_and(false, true) ->
	false;
b_and(false, false) ->
	false;
b_and(_, _) ->
	{error, invalid_object}.

b_or(true, true) ->
	true;
b_or(true, false) ->
	true;
b_or(false, true) ->
	true;
b_or(false, false) ->
	false;
b_or(_, _) ->
	{error, invalid_object}.

b_nand(One, Two) ->
	b_not(b_and(One, Two)).
	