if (window.Vue) {
  Vue.component("st-tabs", {
    name: "st-tabs",
    template: `
      <q-tabs 
        v-model="localSelectedId"
        :vertical="vertical">
        <q-tab 
          v-for="(id, index) in (ids || [])" 
          :key="id" 
          :name="id" 
          :label="labels && labels[index]"
          :icon="icons && icons[index] ? icons[index] : undefined" 
        />
      </q-tabs>
    `,

    model: {
      prop: 'selected_id',
      event: 'input'
    },

    props: {
      selected_id: { type: String, required: false },
      ids: { type: Array, required: true },
      labels: { type: Array, required: true },
      icons: { type: Array, required: false, default: () => [] },
      vertical: { type: Boolean, required: false }
    },

    data() {
      console.log("StippleTabs tests. icons: ", this.icons);
      return {
        localSelectedId: this.selected_id != null ? 
          this.selected_id : 
          (this.ids && this.ids.length > 0) ? this.ids[0] : undefined
      };
    },

    watch: {
      // Watch for changes in the prop and update the local data property
      selected_id(newVal) {
        this.localSelectedId = newVal;
      },
      // Watch for changes in the local data property and emit the update to the parent
      localSelectedId(newVal) {
        this.$emit('input', newVal);
      }
    }
  });
} else {
  console.warn("Can't register custom component because Vue is not available");
}
