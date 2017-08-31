coco_tibble <- function(works, left, right, fdr, span) {
  CorporaCoCo::surface_coco(
    a = works[[left]],
    b = works[[right]],
    fdr = fdr,
    span = span,
    nodes = c('back', 'eye', 'eyes', 'forehead', 'hand', 'hands', 'head', 'shoulder')
  )
}