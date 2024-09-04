# StippleTabs.jl

This component wraps Quasar's Q-Tabs component for Genie Builder compatibility.

## Installation

To install the most recent released version of package:

```
pkg> add StippleTabs
```
 
## Usage



Create a simple `app.jl` script
```julia
module App

using GenieFramework
@genietools
using StippleTabs


@app begin
    @out tab_ids =      ["tab_1", "tab_2", "tab_3"]
    @out tab_labels =   ["Tab 1", "Tab 2", "Tab 3"]
    @in selected_tab =  "tab_1"
end

ui() = """
<st-tabs v-model="selected_tab" :ids="tab_ids" :labels="tab_labels" />
"""

@page("/", ui)

end
```
