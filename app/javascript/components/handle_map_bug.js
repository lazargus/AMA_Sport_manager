import { initMapbox } from "../plugins/init_mapbox";

const handleMapBug = () => {
  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    initMapbox();
  })
}

export { handleMapBug };
