%% Author: carl
%% Created: 19 Feb 2011
%% Description: TODO: Add description to test_binary_marshaller
-module(test_binary_marshaller).

%%
%% Include files
%%
-include_lib("eunit/include/eunit.hrl").
-include("field_defines.hrl").

%%
%% Exported Functions
%%
-export([]).

%%
%% API Functions
%%
%% Test that a message with only an MTI can be exported.
mti_only_test() ->
	Msg1 = iso8583_message:new(),
	Msg2 = iso8583_message:set(0, "0200", Msg1),
	<<2, 0>> = binary_marshaller:marshall(Msg2),
	Msg3 = iso8583_message:set(0, "0210", Msg1),
	<<2, 16>> = binary_marshaller:marshall(Msg3).

field_2_test() ->
	Msg1 = iso8583_message:new(),
	Msg2 = iso8583_message:set(0, "0210", Msg1),
	Msg3 = iso8583_message:set(?PAN, "15234567890123456", Msg2),
	<<2, 16, 64, 0, 0, 0, 0, 0, 0, 0, 23, 21, 35, 69, 103, 137, 1, 35, 69, 96>> 
		= binary_marshaller:marshall(Msg3).
	
fields_2_3_test() ->
	Msg1 = iso8583_message:new(),
	Msg2 = iso8583_message:set(0, "0200", Msg1),
	Msg3 = iso8583_message:set(?PAN, "1234567890123456789", Msg2),
	Msg4 = iso8583_message:set(?PROC_CODE, "1234", Msg3),
	<<2, 0, 96, 0, 0, 0, 0, 0, 0, 0, 25, 18, 52, 86, 120, 144, 18, 52, 86, 120, 144, 0, 18, 52>>
		= binary_marshaller:marshall(Msg4).

field_4_test() ->
	Msg1 = iso8583_message:new(),
	Msg2 = iso8583_message:set(0, "1200", Msg1),
	Msg3 = iso8583_message:set(4, "123", Msg2),
	<<18, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 35>>
		= binary_marshaller:marshall(Msg3).

field_5_test() ->
	Msg1 = iso8583_message:new(),
	Msg2 = iso8583_message:set(0, "1200", Msg1),
	Msg3 = iso8583_message:set(5, "10", Msg2),
	<<18, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16>>
		= binary_marshaller:marshall(Msg3).

field_6_test() ->
	Msg1 = iso8583_message:new(),
	Msg2 = iso8583_message:set(0, "0220", Msg1),
	Msg3 = iso8583_message:set(6, "098765", Msg2),
	<<2, 32, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 135, 101>>
		= binary_marshaller:marshall(Msg3).

fields_8_9_test() ->
	Msg1 = iso8583_message:new(),
	Msg2 = iso8583_message:set(0, "0220", Msg1),
	Msg3 = iso8583_message:set(8, "88", Msg2),
	Msg4 = iso8583_message:set(9, "99", Msg3),
	<<2, 32, 1, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 136, 0, 0, 0, 153>>
		= binary_marshaller:marshall(Msg4).

field_18_19_test() ->
	Msg1 = iso8583_message:new(),
	Msg2 = iso8583_message:set(0, "0220", Msg1),
	Msg3 = iso8583_message:set(18, "1234", Msg2),
	Msg4 = iso8583_message:set(19, "567", Msg3),
	<<2, 32, 0, 0, 96, 0, 0, 0, 0, 0, 18, 52, 5, 103>>
		= binary_marshaller:marshall(Msg4).

fields_28_29_test() ->
	Msg1 = iso8583_message:new(),
	Msg2 = iso8583_message:set(0, "0221", Msg1),
	Msg3 = iso8583_message:set(28, "C1", Msg2),
	Msg4 = iso8583_message:set(29, "D22", Msg3),
	<<2, 33, 0, 0, 0, 24, 0, 0, 0, 0, 67, 0, 0, 0, 1, 68, 0, 0, 0, 34>>
		= binary_marshaller:marshall(Msg4).

fields_33_34_test() ->
	Msg1 = iso8583_message:new(),
	Msg2 = iso8583_message:set(0, "0221", Msg1),
	Msg3 = iso8583_message:set(33, "12345", Msg2),
	Msg4 = iso8583_message:set(34, "567890", Msg3),
	<<2, 33, 0, 0, 0, 0, 192, 0, 0, 0, 5, 18, 52, 80, 6, 53, 54, 55, 56, 57, 48>>
		= binary_marshaller:marshall(Msg4).

fields_35_36_test() ->
	Msg1 = iso8583_message:new(),
	Msg2 = iso8583_message:set(0, "0221", Msg1),
	Msg3 = iso8583_message:set(35, ";1234123412341234=0305101193010877?", Msg2),
	Msg4 = iso8583_message:set(36, "ABC123", Msg3),
	<<2, 33, 0, 0, 0, 0, 48, 0, 0, 0, 53, 177, 35, 65, 35, 65, 35, 65, 35, 77, 3, 5, 16, 17, 147, 1, 8, 119, 240, 0, 6, 65, 66, 67, 49, 50, 51>> =
		binary_marshaller:marshall(Msg4).

%%
%% Local Functions
%%

