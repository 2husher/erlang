-module(records).
-compile(export_all).
-include("records.hrl").

-record(robot, {name,
                type=industrial,
                hobbies,
                details=[]}).
-record(user, {id, name, group, age}).

first_robot() ->
        #robot{name="Mechatron",
               type=handmade,
               details=["Moved by a small man inside"]}.

car_factory(CorpName) ->
        #robot{name=CorpName, hobbies="buiding cars"}.

admin_panel(#user{name=Name, group=admin}) ->
        Name ++ " is allowed!";
admin_panel(#user{name=Name}) ->
        Name ++ " is not allowed".

adult_section(U = #user{}) when U#user.age >= 18 ->
        allowed;
adult_section(_) ->
        forbidden.

repairman(Rob) ->
        Details = Rob#robot.details,
        NewRob  = Rob#robot{details=["Repaired by repairman"|Details]},
        {repaired, NewRob}.

included() -> #included{some_field="Some value"}.