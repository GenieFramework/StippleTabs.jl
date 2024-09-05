# StippleTabs.jl

Alternative UI tabs component for Stipple/StippleUI.
This component wraps Quasar's Q-Tabs component for Genie Builder compatibility.
Use it in combination with q-tab-panels and q-tab-panel to switch displayed content.

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

<q-tab-panels v-model="selected_tab">
    <q-tab-panel name="tab_1">
        Tab 1 Contents
    </q-tab-panel>

    <q-tab-panel name="tab_2">
        Tab 2 Contents
    </q-tab-panel>

    <q-tab-panel name="tab_3">
        Tab 3 Contents
    </q-tab-panel>
</q-tab-panels>
"""

@page("/", ui)

end
```
