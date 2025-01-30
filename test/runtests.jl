using Test
using StippleTabs

@test contains(tabs("a", "b", param = :param, ["inner"]), ">ainner<")